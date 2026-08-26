import 'package:sqflite/sqflite.dart';
import 'package:test_notification/module/chat/model/message_model.dart';

class MessageService {
  final Database _db;

  final String messageTableName = 'messages';

  const MessageService(this._db);

  Future<void> insertMessage(MessageModel message) async {
    await _db.insert(messageTableName, message.toMap());
  }

  Future<List<MessageModel>> loadMessages(int id) async {
    final todos = await _db.query(
      messageTableName,
      where: 'sender_id = ? OR receiver_id = ?',
      orderBy: 'created_at ASC',
      whereArgs: [id, id],
    );

    return todos.map((json) => MessageModel.fromMap(json)).toList();
  }
}
