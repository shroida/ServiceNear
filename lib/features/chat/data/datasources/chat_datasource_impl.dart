import 'package:servicenear/features/chat/data/datasources/chat_datasource.dart';
import 'package:servicenear/features/chat/data/models/message_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ChatDatasourceImpl implements ChatDataSource {
  final SupabaseClient client;

  ChatDatasourceImpl(this.client);

  @override
  Future<void> sendMessage(MessageModel message) async {
    print("Sending message: $message");
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
      print("Message sent to Supabase: ${message.toMap()}");
    } catch (e) {
      print("Error sending message: $e");
      rethrow;
    }

    print("Message sent to Supabase: ${message.toMap()}");
  }
}
