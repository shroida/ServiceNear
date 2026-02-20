import 'package:servicenear/features/chat/domain/entites/message_entity.dart';

class ChatState {
  final List<MessageEntity> messages;
  final bool isLoading;
  final String? error;

  ChatState({required this.messages, required this.isLoading, this.error});

  factory ChatState.initial() {
    return ChatState(messages: [], isLoading: false, error: null);
  }

  ChatState copyWith({
    List<MessageEntity>? messages,
    bool? isLoading,
    String? error,
  }) {
    return ChatState(
      messages: messages ?? this.messages,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }
}
