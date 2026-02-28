import 'package:servicenear/features/chat/domain/entites/chat_conversation_entity.dart';
import 'package:servicenear/features/chat/domain/repositories/chat_repositories.dart';

class MakeAllChatMessagesReadUseCase {
  final ChatRepository repository;

  MakeAllChatMessagesReadUseCase(this.repository);

  Future<void> call(ChatConversationEntity chatConversationEntity) async {
    await repository.markMessagesAsRead(chatConversationEntity);
  }
}
