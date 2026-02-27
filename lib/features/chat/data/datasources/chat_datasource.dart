import 'package:servicenear/features/chat/data/models/chat_conversation_model.dart';
import 'package:servicenear/features/chat/data/models/message_model.dart';

abstract class ChatDataSource {
  Future<void> sendMessage(MessageModel message);
  Future<List<MessageModel>> getMessages(String senderId);
  Future<List<ChatConversationModel>> getAllChats(String currentUserId);
  Future<void> markMessagesAsRead(String senderId, String receiverId);
}
