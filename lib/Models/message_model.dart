class MessageModel {
  String? id;
  String? authorId;
  String? receiverId;
  String? messageContent;
  String? chatID;

  MessageModel({
    this.id,
    this.authorId,
    this.receiverId,
    this.messageContent,
    this.chatID,
  });
}
