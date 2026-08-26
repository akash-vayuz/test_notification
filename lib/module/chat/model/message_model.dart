class MessageModel {
  final int? id;
  final String content;
  final int senderId;
  final int receiverId;
  final DateTime createdAt;

  MessageModel({
    this.id,
    required this.content,
    required this.senderId,
    required this.receiverId,
    required this.createdAt,
  });

  factory MessageModel.fromMap(Map<String, dynamic> json) {
    return MessageModel(
      id: json['id'],
      content: json['content'],
      senderId: json["sender_id"],
      receiverId: json['receiver_id'],
      createdAt: DateTime.fromMillisecondsSinceEpoch(json['created_at']),
    );
  }
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'content': content,
      'sender_id': senderId,
      'receiver_id': receiverId,
      'created_at': createdAt.millisecondsSinceEpoch,
    };
  }
}
