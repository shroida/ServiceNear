import 'package:servicenear/features/chat/data/datasources/chat_datasource.dart';
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
      print('================================');
      print('Fetching messages for senderId: $senderId');
      print('================================');
      final response = await client
          .from('chats')
          .select()
          .or('sender_id.eq.$senderId,receiver_id.eq.$senderId')
          .order('created_at', ascending: true);

      print('Fetching messages for senderId: $response');
      return (response as List<dynamic>)
          .map((item) => MessageModel.fromMap(item as Map<String, dynamic>))
          .toList();
    } catch (e) {
      rethrow;
    }
  }
}
