class MessageEntity {
  final String id;
  final String workerId;
  final String userId;
  final String lastMessage;
  final DateTime timestamp;

  MessageEntity({
    required this.id,
    required this.workerId,
    required this.userId,
    required this.lastMessage,
    required this.timestamp,
  });
}
