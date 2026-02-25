import 'package:servicenear/features/chat/domain/entites/chat_conversation_entity.dart';

class ChatConversationModel extends ChatConversationEntity {
  ChatConversationModel({
    required super.userId,
    required super.userName,
    required super.lastMessage,
    required super.lastMessageTime,
    required super.unreadCount,
  });
}
