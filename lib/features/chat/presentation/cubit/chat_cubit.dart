import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:servicenear/features/chat/domain/entites/message_entity.dart';
import 'package:servicenear/features/chat/domain/usecases/send_message_usecase.dart';
import 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  final SendMessageUseCase sendMessageUseCase;

  ChatCubit(this.sendMessageUseCase) : super(ChatState.initial());

  Future<void> sendMessage({
    required String senderId,
    required String receiverId,
    required String senderType,
    required String receiverType,
    required String messageText,
  }) async {
    if (messageText.trim().isEmpty) return;

    emit(state.copyWith(isLoading: true));

    try {
      final message = MessageEntity(
        senderId: senderId,
        receiverType: receiverType,
        receiverId: receiverId,
        senderType: senderType,
        messageText: messageText,
        isRead: false,
        createdAt: DateTime.now(),
      );

      await sendMessageUseCase(message);

      final updatedMessages = List<MessageEntity>.from(state.messages)
        ..add(message);

      emit(
        state.copyWith(
          messages: updatedMessages,
          isLoading: false,
          error: null,
        ),
      );
    } catch (e) {
      emit(state.copyWith(isLoading: false, error: e.toString()));
    }
  }
}
