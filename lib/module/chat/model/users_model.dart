class UsersModel {
  final int? id;
  final String name;
  final String lastName;
  final String email;

  UsersModel({
    this.id,
    required this.name,
    required this.lastName,
    required this.email,
  });

  factory UsersModel.fromMap(Map<String, dynamic> json) {
    return UsersModel(
      id: json['id'],
      name: json['name'],
      lastName: json['last_name'],
      email: json['email'],
    );
  }

  Map<String, dynamic> toMap() {
    return {'id': id, 'name': name, 'last_name': lastName, 'email': email};
  }
}
