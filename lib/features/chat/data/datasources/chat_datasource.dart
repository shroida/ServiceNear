abstract class ChatDataSource {
  Future<void> sendMessage(String message, String senderId, String receiverId);
}
