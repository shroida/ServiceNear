import 'package:servicenear/common/entities/app_user.dart';
import 'package:servicenear/common/entities/worker.dart';
import 'package:servicenear/features/chat/data/datasources/chat_datasource.dart';
import 'package:servicenear/features/chat/data/models/chat_conversation_model.dart';
import 'package:servicenear/features/chat/data/models/message_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ChatDatasourceImpl implements ChatDataSource {
  final SupabaseClient client;

  ChatDatasourceImpl(this.client);

  @override
  Future<void> sendMessage(MessageModel message) async {
    try {
      await client.from('chats').insert({
        'sender_id': message.senderId,
        'receiver_id': message.receiverId,
        'sender_type': message.senderType,
        'receiver_type': message.receiverType,
        'message_text': message.messageText,
        'is_read': message.isRead,
        'parent_id': message.parentId,
        'created_at': message.createdAt.toIso8601String(),
      });
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<MessageModel>> getMessages(String senderId) async {
    try {
      final response = await client
          .from('chats')
          .select()
          .or('sender_id.eq.$senderId,receiver_id.eq.$senderId')
          .order('created_at', ascending: true);

      return (response as List<dynamic>)
          .map((item) => MessageModel.fromMap(item as Map<String, dynamic>))
          .toList();
    } catch (e) {
      rethrow;
    }
  }

  Future<Map<String, dynamic>?> getUserName(
    String userId,
    String userType,
  ) async {
    try {
      if (userType == 'worker') {
        final res = await client
            .from('workers')
            .select('first_name,last_name')
            .eq('id', userId)
            .single();
        return res as Map<String, dynamic>?;
      } else if (userType == 'customer') {
        final res = await client
            .from('users')
            .select('first_name,last_name')
            .eq('id', userId)
            .single();
        return res as Map<String, dynamic>?;
      }
    } catch (e) {
      throw Exception('Error fetching user name for $userId: $e');
    }
    return null;
  }

  @override
  Future<List<ChatConversationModel>> getAllChats(String currentUserId) async {
    final response = await client
        .from('chats')
        .select()
        .or('sender_id.eq.$currentUserId,receiver_id.eq.$currentUserId')
        .order('created_at', ascending: false);

    final data = response as List;

    final Map<String, ChatConversationModel> chats = {};
    final Map<String, int> unreadCounter = {};

    for (var message in data) {
      final senderId = message['sender_id'];
      final receiverId = message['receiver_id'];
      final senderType = message['sender_type'];
      final receiverType = message['receiver_type'];

      final otherUserId = senderId == currentUserId ? receiverId : senderId;

      final otherUserType = senderId == currentUserId
          ? receiverType
          : senderType;

      if (receiverId == currentUserId && message['is_read'] == false) {
        unreadCounter[otherUserId] = (unreadCounter[otherUserId] ?? 0) + 1;
      }

      if (!chats.containsKey(otherUserId)) {
        final nameMap = await getUserName(otherUserId, otherUserType);

        final userName = nameMap != null
            ? "${nameMap['first_name'] ?? ''} ${nameMap['last_name'] ?? ''}"
                  .trim()
            : "Unknown User";

        chats[otherUserId] = ChatConversationModel(
          senderId: senderId,
          receiverId: receiverId,
          userId: otherUserId,
          userName: userName,
          lastMessage: message['message_text'],
          lastMessageTime: DateTime.parse(message['created_at']),
          unreadCount: 0,
        );
      }
    }

    chats.forEach((key, chat) {
      chats[key] = chat.copyWith(unreadCount: unreadCounter[key] ?? 0);
    });

    return chats.values.toList();
  }

  @override
  Future<void> markMessagesAsRead(
    ChatConversationModel chatConversationModel,
  ) async {
    try {
      await client
          .from('chats')
          .update({'is_read': true})
          .eq('sender_id', chatConversationModel.senderId)
          .eq('receiver_id', chatConversationModel.receiverId);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<AppUser> getUserById(String userId) async {
    try {
      // Try to find in workers table
      try {
        final workerRes = await client
            .from('workers')
            .select()
            .eq('id', userId)
            .single();
        return Worker.fromMap(workerRes);
      } catch (_) {
        // ignore, will try users table next
      }

      // If not found in workers, try users table
      final userRes = await client
          .from('users')
          .select()
          .eq('id', userId)
          .single();
      return AppUser.fromMap(userRes);
    } catch (e) {
      throw Exception('Error fetching user for $userId: $e');
    }
  }
}
