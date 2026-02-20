import 'package:servicenear/features/chat/domain/entites/message_entity.dart';
import 'package:servicenear/features/chat/domain/repositories/chat_repositories.dart';

class SendMessageUseCase {
  final ChatRepository repository;

  SendMessageUseCase(this.repository);

  Future<void> call(MessageEntity message) async {
    await repository.sendMessage(message);
  }
}
