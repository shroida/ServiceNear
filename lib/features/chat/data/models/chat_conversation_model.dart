import 'package:servicenear/features/chat/domain/entites/chat_conversation_entity.dart';

class ChatConversationModel extends ChatConversationEntity {
  ChatConversationModel({
    required super.userId,
    required super.userName,
    required super.senderId,
    required super.receiverId,
    required super.lastMessage,
    required super.lastMessageTime,
    required super.unreadCount,
  });
  ChatConversationModel copyWith({
    String? userId,
    String? userName,
    String? lastMessage,
    DateTime? lastMessageTime,
    int? unreadCount,
  }) {
    return ChatConversationModel(
      userId: userId ?? this.userId,
      userName: userName ?? this.userName,
      senderId: senderId,
      receiverId: receiverId,
      lastMessage: lastMessage ?? this.lastMessage,
      lastMessageTime: lastMessageTime ?? this.lastMessageTime,
      unreadCount: unreadCount ?? this.unreadCount,
    );
  }

  static ChatConversationModel fromEntity(ChatConversationEntity entity) {
    return ChatConversationModel(
      userId: entity.userId,
      userName: entity.userName,
      senderId: entity.senderId,
      receiverId: entity.receiverId,
      lastMessage: entity.lastMessage,
      lastMessageTime: entity.lastMessageTime,
      unreadCount: entity.unreadCount,
    );
  }
}
