import 'package:servicenear/features/chat/domain/entites/message_entity.dart';

class MessageModel extends MessageEntity {
  MessageModel({
    required super.id,
    required super.workerId,
    required super.userId,
    required super.lastMessage,
    required super.timestamp,
  });
}
