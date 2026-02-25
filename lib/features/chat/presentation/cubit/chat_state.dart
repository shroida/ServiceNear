import 'package:servicenear/features/chat/domain/entites/chat_conversation_entity.dart';
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

class ChatConversationLoaded extends ChatState {
  final List<ChatConversationEntity> chats;

  const ChatConversationLoaded({required this.chats});
}

class ChatError extends ChatState {
  final String message;

  const ChatError(this.message);
}
