import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:servicenear/features/chat/domain/entites/chat_conversation_entity.dart';
import 'package:servicenear/features/chat/domain/entites/message_entity.dart';
import 'package:servicenear/features/chat/domain/repositories/chat_repositories.dart';
import 'package:servicenear/features/chat/domain/usecases/get_all_chats_usecase.dart';
import 'package:servicenear/features/chat/domain/usecases/get_messages_usecase.dart';
import 'package:servicenear/features/chat/domain/usecases/make_all_chat_messages_read.dart';
import 'package:servicenear/features/chat/domain/usecases/send_message_usecase.dart';
import 'package:servicenear/features/chat/presentation/cubit/chat_state.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ChatCubit extends Cubit<ChatState> {
  final SendMessageUseCase sendMessageUseCase;
  final GetMessagesUsecase getMessagesUseCase;
  final GetAllChatsUseCase getAllChatsUseCase;
  final MakeAllChatMessagesReadUseCase makeAllChatMessagesReadUseCase;
  final ChatRepository repository;

  RealtimeChannel? _channel;

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
  ) async {
    try {
      final receiver = await repository.getUserById(receiverId);

      final messages = await repository.getMessagesBetweenCustomerAndWorker(
        currentUserId,
        receiverId,
      );

      emit(ChatLoaded(messages: messages, receiver: receiver));

      subscribeToMessages(currentUserId, receiverId);
    } catch (e) {
      emit(ChatError(e.toString()));
    }
  }

  void subscribeToMessages(String currentUserId, String receiverId) {
    _channel = Supabase.instance.client
        .channel('chat_room_$currentUserId$receiverId')
        .onPostgresChanges(
          event: PostgresChangeEvent.insert,
          schema: 'public',
          table: 'chats',
          callback: (payload) {
            final record = payload.newRecord;

            final newMessage = MessageEntity(
              senderId: record['sender_id'],
              receiverId: record['receiver_id'],
              senderType: record['sender_type'],
              receiverType: record['receiver_type'],
              messageText: record['message_text'],
              isRead: record['is_read'] ?? false,
              createdAt: DateTime.parse(record['created_at']),
              parentId: record['parent_id'],
            );

            if (state is ChatLoaded) {
              final current = state as ChatLoaded;

              emit(
                ChatLoaded(
                  messages: [...current.messages, newMessage],
                  receiver: current.receiver,
                ),
              );
            }
          },
        )
        .subscribe();
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

  @override
  Future<void> close() {
    _channel?.unsubscribe();
    return super.close();
  }
}
