import 'package:servicenear/common/entities/app_user.dart';
import 'package:servicenear/features/chat/data/datasources/chat_datasource.dart';
import 'package:servicenear/features/chat/data/models/chat_conversation_model.dart';
import 'package:servicenear/features/chat/data/models/message_model.dart';
import 'package:servicenear/features/chat/domain/entites/chat_conversation_entity.dart';
import 'package:servicenear/features/chat/domain/entites/message_entity.dart';
import 'package:servicenear/features/chat/domain/repositories/chat_repositories.dart';

class ChatRepositoryImpl implements ChatRepository {
  final ChatDataSource dataSource;

  ChatRepositoryImpl(this.dataSource);

  @override
  Future<void> sendMessage(MessageEntity message) {
    return dataSource.sendMessage(MessageModel.fromEntity(message));
  }

  @override
  Future<List<MessageEntity>> getMessages(String senderId, String receiverId) {
    return dataSource.getMessages(senderId).then((models) {
      return models.map((model) => model.toEntity()).toList();
    });
  }

  @override
  Future<List<ChatConversationEntity>> getAllChats(String currentUserId) async {
    final models = await dataSource.getAllChats(currentUserId);

    return models.map((model) => model.toEntity()).toList();
  }

  @override
  Future<void> markMessagesAsRead(ChatConversationEntity chat) {
    return dataSource.markMessagesAsRead(
      ChatConversationModel.fromEntity(chat),
    );
  }

  @override
  Future<AppUser> getUserById(String userId) {
    return dataSource.getUserById(userId);
  }
}
