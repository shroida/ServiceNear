import 'package:servicenear/features/chat/domain/entites/message_entity.dart';

abstract class ChatRepository {
  Future<void> sendMessage(MessageEntity message);
  Future<List<MessageEntity>> getMessages(String senderId);
}
