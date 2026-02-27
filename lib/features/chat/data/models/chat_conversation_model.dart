import 'package:servicenear/features/chat/domain/entites/chat_conversation_entity.dart';

class ChatConversationModel extends ChatConversationEntity {
  ChatConversationModel({
    required super.userId,
    required super.userName,
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
      lastMessage: lastMessage ?? this.lastMessage,
      lastMessageTime: lastMessageTime ?? this.lastMessageTime,
      unreadCount: unreadCount ?? this.unreadCount,
    );
  }
}
