import 'package:servicenear/features/chat/domain/entites/message_entity.dart';

class MessageModel extends MessageEntity {
  MessageModel({
    required super.senderId,
    required super.receiverId,
    required super.senderType,
    required super.receiverType,
    required super.messageText,
    required super.isRead,
    required super.createdAt,
    super.parentId,
  });

  factory MessageModel.fromMap(Map<String, dynamic> map) {
    return MessageModel(
      senderId: map['sender_id'],
      receiverId: map['receiver_id'],
      senderType: map['sender_type'],
      receiverType: map['receiver_type'],
      messageText: map['message_text'],
      isRead: map['is_read'] ?? false,
      createdAt: DateTime.parse(map['created_at']),
      parentId: map['parent_id'],
    );
  }

  factory MessageModel.fromEntity(MessageEntity entity) {
    return MessageModel(
      senderId: entity.senderId,
      receiverId: entity.receiverId,
      senderType: entity.senderType,
      receiverType: entity.receiverType,
      messageText: entity.messageText,
      isRead: entity.isRead,
      createdAt: entity.createdAt,
      parentId: entity.parentId,
    );
  }

  MessageEntity toEntity() {
    return MessageEntity(
      senderId: senderId,
      receiverId: receiverId,
      senderType: senderType,
      receiverType: receiverType,
      messageText: messageText,
      isRead: isRead,
      createdAt: createdAt,
      parentId: parentId,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'sender_id': senderId,
      'receiver_id': receiverId,
      'sender_type': senderType,
      'receiver_type': receiverType,
      'message_text': messageText,
      'is_read': isRead,
      'created_at': createdAt.toIso8601String(),
      'parent_id': parentId,
    };
  }
}
