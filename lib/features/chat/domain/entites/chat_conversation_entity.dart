class ChatConversationEntity {
  final String userId;
  final String userName;
  final String lastMessage;
  final DateTime lastMessageTime;
  final int unreadCount;

  ChatConversationEntity({
    required this.userId,
    required this.userName,
    required this.lastMessage,
    required this.lastMessageTime,
    required this.unreadCount,
  });
}
