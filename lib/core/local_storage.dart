import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:test_notification/core/user_me.dart';
import 'package:test_notification/module/chat/model/users_model.dart';

class LocalStorage {
  static const String databaseName = 'app.db';
  static const int databaseVersion = 1;

  static Future<Database> initDatabase() async {
    final databasePath = await getDatabasesPath();

    final path = join(databasePath, databaseName);

    return openDatabase(
      path,
      version: databaseVersion,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE user (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            name TEXT NOT NULL,
            last_name TEXT,
            email TEXT NOT NULL
          )

        ''');

        await db.execute('''

          CREATE TABLE messages (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            content TEXT NOT NULL,
            sender_id INTEGER NOT NULL,
            receiver_id INTEGER NOT NULL,
            created_at INTEGER NOT NULL,
            type INTEGER DEFAULT 0,
            path TEXT,
            FOREIGN KEY (sender_id) REFERENCES user(id),
            FOREIGN KEY (receiver_id) REFERENCES user(id)
          )
''');

  db.insert("user", {
    'id': UserMe.id,
    'name': UserMe.name,
    'last_name': UserMe.lastName,
    'email': UserMe.email,
  });
        await db.insert(
          'user',
          UsersModel(
            name: 'Alex',
            lastName: 'Wolf',
            email: 'alex@email.com',
          ).toMap(),
        );
        await db.insert(
          'user',
          UsersModel(
            name: 'John',
            lastName: 'Megan',
            email: 'john@email.com',
          ).toMap(),
        );
        await db.insert(
          'user',
          UsersModel(
            name: 'War',
            lastName: 'Ship',
            email: 'war@email.com',
          ).toMap(),
        );
        await db.insert(
          'user',
          UsersModel(
            name: 'Jash',
            lastName: 'Kalf',
            email: 'jash@email.com',
          ).toMap(),
        );
        // INSERT INTO user
        // VALUES
        // (1, 'Alex', 'Wolf', 'alex@email.com'),
        // (2, 'John', 'Megan', 'john@email.com'),
        // (3, 'War', 'Ship', 'warx@email.com'),
        // (4, 'Jash', 'Kalf', 'jash@email.com')
      },
    );
  }

  static Future<void> deleteDatabase() async {
    final databasePath = await getDatabasesPath();

    final path = join(databasePath, databaseName);

    await databaseFactory.deleteDatabase(path);
  }
}
