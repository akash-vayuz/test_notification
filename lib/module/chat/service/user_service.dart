import 'package:sqflite/sqflite.dart';
import 'package:test_notification/module/chat/model/users_model.dart';

class UserService {
  final Database _db;
  final String tableName = 'user';

  const UserService(this._db);

  Future<UsersModel> findUserById(int id) async {
    final result = await _db.query(tableName, where: 'id = ?', whereArgs: [id]);
    return result.map((json) => UsersModel.fromMap(json)).toList().first;
  }

  Future<List<UsersModel>> getAllUsers() async {
    final result = await _db.query(tableName, orderBy: 'id');
    return result.map((json) => UsersModel.fromMap(json)).toList();
  }
}
