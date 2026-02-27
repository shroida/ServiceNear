import 'package:servicenear/features/chat/data/models/chat_conversation_model.dart';

class ChatConversationEntity {
  final String userId;
  final String userName;
  final String lastMessage;
  final String senderId;
  final String receiverId;
  final DateTime lastMessageTime;
  final int unreadCount;

  ChatConversationEntity({
    required this.userId,
    required this.userName,
    required this.lastMessage,
    required this.senderId,
    required this.receiverId,
    required this.lastMessageTime,
    required this.unreadCount,
  });
  ChatConversationEntity.fromModel(ChatConversationModel model)
    : userId = model.userId,
      userName = model.userName,
      lastMessage = model.lastMessage,
      senderId = model.senderId,
      receiverId = model.receiverId,
      lastMessageTime = model.lastMessageTime,
      unreadCount = model.unreadCount;

  ChatConversationEntity toEntity() {
    return ChatConversationEntity(
      userId: userId,
      userName: userName,

      lastMessage: lastMessage,
      senderId: senderId,
      receiverId: receiverId,
      lastMessageTime: lastMessageTime,
      unreadCount: unreadCount,
    );
  }
}
