import 'package:servicenear/features/chat/domain/entites/message_entity.dart';
import 'package:servicenear/features/chat/domain/repositories/chat_repositories.dart';

class GetMessagesUsecase {
  final ChatRepository repository;

  GetMessagesUsecase(this.repository);

  Future<List<MessageEntity>> call(
    String currentUserId,
    String receiverId,
  ) async {
    return await repository.getMessages(currentUserId, receiverId);
  }
}
