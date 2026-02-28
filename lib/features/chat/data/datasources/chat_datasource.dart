import 'package:servicenear/common/entities/app_user.dart';
import 'package:servicenear/features/chat/data/models/chat_conversation_model.dart';
import 'package:servicenear/features/chat/data/models/message_model.dart';

abstract class ChatDataSource {
  Future<void> sendMessage(MessageModel message);
  Future<List<MessageModel>> getMessagesBetweenCustomerAndWorker(
    String senderId,
    String receiverId,
  );
  Future<List<ChatConversationModel>> getAllChats(String currentUserId);
  Future<void> markMessagesAsRead(ChatConversationModel chatConversationModel);
  Future<AppUser> getUserById(String userId);
}
