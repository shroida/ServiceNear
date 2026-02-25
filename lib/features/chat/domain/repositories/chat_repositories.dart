import 'package:servicenear/features/chat/domain/entites/chat_conversation_entity.dart';
import 'package:servicenear/features/chat/domain/entites/message_entity.dart';

abstract class ChatRepository {
  Future<void> sendMessage(MessageEntity message);
  Future<List<MessageEntity>> getMessages(String senderId);
  Future<List<ChatConversationEntity>> getAllChats(String currentUserId);
}
