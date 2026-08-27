import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:test_notification/core/constants.dart';
import 'package:test_notification/core/user_me.dart';
import 'package:test_notification/module/chat/model/users_model.dart';
import 'package:test_notification/module/club/model/club_model.dart';

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

        await db.execute('''
            CREATE TABLE clubs (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            name TEXT NOT NULL,
            topics INTEGER NOT NULL,
            members INTEGER NOT NULL,
            about TEXT NOT NULL,
            type INTEGER DEFAULT 0,
            isJoined INTEGER DEFAULT 0
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

        await dummyData(db);
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

Future<void> dummyData(Database db) async {
  await db.insert(
    'clubs',
    ClubModel(
      name: "Car Poolers",
      topics: 5,
      members: 20,
      about: Constants.loremIpsum,
      isJoined: true,
      type: ClubType.public,
      
    ).toMap(),
  );
  await db.insert(
    'clubs',
    ClubModel(
      name: "Women in Tech",
      topics: 5,
      type: ClubType.public,
      members: 20,
      about: Constants.loremIpsum,
    ).toMap(),
  );
  await db.insert(
    'clubs',
    ClubModel(
      name: "The 5PM Club/ Chai pe charcha",
      topics: 5,
      about: Constants.loremIpsum,
      members: 20,
      isJoined: true,
    ).toMap(),
  );
  await db.insert(
    'clubs',
    ClubModel(
      name: "Humans of Anacity",
      topics: 5,
      about: Constants.loremIpsum,
      members: 20,
    ).toMap(),
  );
  await db.insert(
    'clubs',
    ClubModel(
      name: "Car Poolers",
      topics: 5,
      about: Constants.loremIpsum,
      members: 20,
      isJoined: true,
    ).toMap(),
  );
  await db.insert(
    'clubs',
    ClubModel(
      name: "10K Steps a Day",
      topics: 5,
      members: 20,
      about: Constants.loremIpsum,
      type: ClubType.public,
      isJoined: true,
    ).toMap(),
  );
  await db.insert(
    'clubs',
    ClubModel(
      name: "Foodies of Anacity",
      topics: 5,
      members: 20,
      about: Constants.loremIpsum,
      type: ClubType.public,
    ).toMap(),
  );
  await db.insert(
    'clubs',
    ClubModel(
      name: "Tect Talks",
      topics: 5,
      members: 20,
      type: ClubType.public,
      about: Constants.loremIpsum,
    ).toMap(),
  );
}
