import 'package:servicenear/features/chat/data/datasources/chat_datasource.dart';
import 'package:servicenear/features/chat/data/models/message_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ChatDatasourceImpl implements ChatDataSource {
  final SupabaseClient client;

  ChatDatasourceImpl({required this.client});

  @override
  Future<void> sendMessage(MessageModel message) async {
    await client.from('chats').insert({
      'sender_id': message.senderId,
      'receiver_id': message.receiverId,
      'sender_type': message.senderType,
      'message_text': message.messageText,
      'is_read': message.isRead,
      'parent_id': message.parentId ?? '',
      'timestamp': message.createdAt.toIso8601String(),
    });
  }
}
