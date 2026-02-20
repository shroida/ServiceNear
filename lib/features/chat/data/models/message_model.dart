import 'package:servicenear/features/chat/domain/entites/message_entity.dart';

class MessageModel extends MessageEntity {
  MessageModel({
    required super.senderId,
    required super.receiverId,
    required super.senderType,
    required super.messageText,
    required super.isRead,
    super.parentId,
    required super.createdAt,
  });
  factory MessageModel.fromEntity(MessageEntity entity) {
    return MessageModel(
      senderId: entity.senderId,
      receiverId: entity.receiverId,
      senderType: entity.senderType,
      messageText: entity.messageText,
      isRead: entity.isRead,
      createdAt: entity.createdAt,
      parentId: entity.parentId,
    );
  }
  Map<String, dynamic> toMap() {
    return {
      'sender_id': senderId,
      'receiver_id': receiverId,
      'sender_type': senderType,
      'message_text': messageText,
      'is_read': isRead,
      'created_at': createdAt.toIso8601String(),
      'parent_id': parentId,
    };
  }
}
