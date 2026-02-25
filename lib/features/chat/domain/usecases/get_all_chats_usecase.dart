import 'package:servicenear/features/chat/domain/entites/chat_conversation_entity.dart';
import 'package:servicenear/features/chat/domain/repositories/chat_repositories.dart';

class GetAllChatsUseCase {
  final ChatRepository repository;

  GetAllChatsUseCase(this.repository);

  Future<List<ChatConversationEntity>> call(String currentUserId) {
    return repository.getAllChats(currentUserId);
  }
}
