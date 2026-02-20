import 'package:servicenear/features/chat/domain/entites/message_entity.dart';

abstract class ChatState {
  const ChatState();
}

class ChatInitial extends ChatState {
  const ChatInitial();
}

class ChatLoading extends ChatState {
  const ChatLoading();
}

class ChatLoaded extends ChatState {
  final List<MessageEntity> messages;

  const ChatLoaded({required this.messages});
}

class ChatError extends ChatState {
  final String message;

  const ChatError(this.message);
}
