import 'package:sqflite/sqflite.dart';
import 'package:test_notification/module/club/model/club_model.dart';

class ClubService {
  final Database _db;
  static const String _tableName = "clubs";

  const ClubService(this._db);

  Future<List<ClubModel>> getClubs() async {
    final result = await _db.query(_tableName, orderBy: "id");

    return result.map((map) => ClubModel.fromMap(map)).toList();
  }

  Future<ClubModel> getClubById(int id) async {
    final result = await _db.query(
      _tableName,
      where: 'id = ?',
      whereArgs: [id],
    );

    return result.map((map) => ClubModel.fromMap(map)).toList().first;
  }

  Future<void> joineClubById(int id, ClubModel value) async {
     await _db.update(
      _tableName,
      value.toMap(),
      where: 'id = ?',
      whereArgs: [id],
    );

    return;
  }
}
