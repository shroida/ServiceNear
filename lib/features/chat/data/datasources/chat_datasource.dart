import 'package:servicenear/features/chat/data/models/message_model.dart';

abstract class ChatDataSource {
  Future<void> sendMessage(MessageModel message);
}
