import 'package:flutter/material.dart';
import 'package:test_notification/core/user_me.dart';
import 'package:test_notification/module/chat/model/users_model.dart';
import 'package:test_notification/module/chat/service/user_service.dart';

class ChatListController extends ChangeNotifier {
  final List<UsersModel> _users = [];
  final UserService _userService;

  String? _error;

  ChatListController(this._userService);

  List<UsersModel> get users => _users;
  String? get erro => _error;

  Future<void> loadUsers() async {
    try {
      final users = await _userService.getAllUsers();
      users.removeWhere((user) => user.id == UserMe.id);
      _users.addAll(users);

      notifyListeners();
    } on Exception catch (e) {
      _error = e.toString();
      notifyListeners();
    }
  }
}
