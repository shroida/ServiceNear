class MessageEntity {
  final String senderId;
  final String receiverId;
  final String senderType;
  final String receiverType;
  final String messageText;
  final bool isRead;
  final DateTime createdAt;
  final String? parentId;

  MessageEntity({
    required this.senderId,
    required this.receiverId,
    required this.senderType,
    required this.receiverType,
    required this.messageText,
    required this.isRead,
    required this.createdAt,
    this.parentId,
  });
}
