import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:servicenear/features/chat/domain/entites/message_entity.dart';
import 'package:servicenear/features/chat/domain/usecases/get_all_chats_usecase.dart';
import 'package:servicenear/features/chat/domain/usecases/get_messages_usecase.dart';
import 'package:servicenear/features/chat/domain/usecases/send_message_usecase.dart';
import 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  final SendMessageUseCase sendMessageUseCase;
  final GetMessagesUsecase getMessagesUseCase;
  final GetAllChatsUseCase getAllChatsUseCase;
  final List<MessageEntity> messages = [];
  ChatCubit(
    this.sendMessageUseCase,
    this.getMessagesUseCase,
    this.getAllChatsUseCase,
  ) : super(const ChatInitial());
  Future<void> sendMessage({
    required String senderId,
    required String receiverId,
    required String senderType,
    required String receiverType,
    required String messageText,
  }) async {
    if (messageText.trim().isEmpty) return;

    emit(ChatLoading());

    try {
      final message = MessageEntity(
        senderId: senderId,
        receiverId: receiverId,
        senderType: senderType,
        receiverType: receiverType,
        messageText: messageText,
        isRead: false,
        createdAt: DateTime.now(),
      );

      await sendMessageUseCase(message);

      final currentMessages = state is ChatLoaded
          ? (state as ChatLoaded).messages
          : <MessageEntity>[];
      final updatedMessages = [...currentMessages, message];

      emit(ChatLoaded(messages: updatedMessages));
    } catch (e) {
      emit(ChatError(e.toString()));
    }
  }

  Future<void> loadMessages(String senderId) async {
    emit(ChatLoading());
    try {
      final fetchedMessages = await getMessagesUseCase(senderId);
      emit(ChatLoaded(messages: fetchedMessages));
    } catch (e) {
      emit(ChatError(e.toString()));
    }
  }

  Future<void> loadAllChats(String currentUserId) async {
    emit(ChatLoading());
    try {
      final chats = await getAllChatsUseCase(currentUserId);
      emit(ChatConversationLoaded(chats: chats));
    } catch (e) {
      emit(ChatError(e.toString()));
    }
  }
}
