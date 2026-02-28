import 'package:servicenear/common/entities/app_user.dart';
import 'package:servicenear/features/chat/domain/entites/chat_conversation_entity.dart';
import 'package:servicenear/features/chat/domain/entites/message_entity.dart';

abstract class ChatRepository {
  Future<void> sendMessage(MessageEntity message);
  Future<List<MessageEntity>> getMessages(String senderId, String receiverId);
  Future<List<ChatConversationEntity>> getAllChats(String currentUserId);
  Future<void> markMessagesAsRead(ChatConversationEntity chat);
  Future<AppUser> getUserById(String userId, String userType);
}
