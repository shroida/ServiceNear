import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:servicenear/features/chat/domain/entites/chat_conversation_entity.dart';
import 'package:servicenear/features/chat/domain/entites/message_entity.dart';
import 'package:servicenear/features/chat/domain/repositories/chat_repositories.dart';
import 'package:servicenear/features/chat/domain/usecases/get_all_chats_usecase.dart';
import 'package:servicenear/features/chat/domain/usecases/get_messages_usecase.dart';
import 'package:servicenear/features/chat/domain/usecases/make_all_chat_messages_read.dart';
import 'package:servicenear/features/chat/domain/usecases/send_message_usecase.dart';
import 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  final SendMessageUseCase sendMessageUseCase;
  final GetMessagesUsecase getMessagesUseCase;
  final GetAllChatsUseCase getAllChatsUseCase;
  final MakeAllChatMessagesReadUseCase makeAllChatMessagesReadUseCase;
  final ChatRepository repository;
  final List<MessageEntity> messages = [];
  ChatCubit(
    this.repository,
    this.sendMessageUseCase,
    this.getMessagesUseCase,
    this.getAllChatsUseCase,
    this.makeAllChatMessagesReadUseCase,
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

      emit(
        ChatLoaded(
          messages: updatedMessages,
          receiver: (state as ChatLoaded).receiver,
        ),
      );
    } catch (e) {
      emit(ChatError(e.toString()));
    }
  }

  Future<void> loadReceiver(String receiverId, String userType) async {
    emit(ChatLoading());

    final user = await repository.getUserById(receiverId);

    emit(ChatReceiverLoaded(receiverName: user));
  }

  Future<void> loadMessagesBetweenCustomerAndWorker(
    String currentUserId,
    String receiverId,
    String receiverType,
  ) async {
    final receiver = await repository.getUserById(receiverId);

    final messages = await repository.getMessagesBetweenCustomerAndWorker(
      currentUserId,
      receiverId,
    );

    emit(ChatLoaded(messages: messages, receiver: receiver));
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

  Future<void> markMessagesAsRead(ChatConversationEntity chat) async {
    try {
      await makeAllChatMessagesReadUseCase(chat);
    } catch (e) {
      emit(ChatError(e.toString()));
    }
  }
}
