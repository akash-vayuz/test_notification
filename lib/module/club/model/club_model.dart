enum ClubType { private, public }

class ClubModel {
  final int? id;
  final String name;
  final int topics;
  final int members;
  final String about;
  final ClubType type;
  final bool isJoined;

  ClubModel({
    this.id,
    required this.name,
    required this.topics,
    required this.members,
    required this.about,
    this.type = ClubType.private,
    this.isJoined = false,
  });

  factory ClubModel.fromMap(Map<String, dynamic> json) {
    return ClubModel(
      id: json['id'],
      name: json['name'],
      topics: json['topics'],
      members: json['members'],
      about: json['about'],
      type: ClubType.values[json['type']],
      isJoined: json['isJoined'] == 1,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'topics': topics,
      'members': members,
      'isJoined': isJoined ? 1 : 0,
      'type': type.index,
      'about': about,
    };
  }
}

    //  CREATE TABLE clubs (
    //         id INTEGER PRIMARY KEY AUTOINCREMENT,
    //         name TEXT NOT NULL,
    //         topics INTEGER NOT NULL,
    //         members INTEGER NOT NULL,
    //         about TEXT NOT NULL,
    //         type INTEGER DEFAULT 0,
    //         isJoine INTEGER DEFAULT 0