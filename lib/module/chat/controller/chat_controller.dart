import 'package:flutter/material.dart';
import 'package:test_notification/core/user_me.dart';
import 'package:test_notification/module/chat/model/message_model.dart';
import 'package:test_notification/module/chat/model/users_model.dart';
import 'package:test_notification/module/chat/service/message_service.dart';

class ChatController extends ChangeNotifier {
  final MessageService _service;
  UsersModel? _user;

  String? _error;
  List<MessageModel> _messages = [];

  ChatController(this._service);

  // Getters
  final TextEditingController messageController = TextEditingController();
  List<MessageModel> get messages => _messages;
  String? get error => _error;
  UsersModel? get user => _user;

  Future sendMessage(int userId, bool isMe) async {
    try {
      if (messageController.text.isEmpty) {
        // _error = "Message cant empty";
        // notifyListeners();
        return;
      }
      final message = MessageModel(
        content: messageController.text.trim(),
        senderId: isMe ? UserMe.id : userId,
        receiverId: isMe ? userId : UserMe.id,
        createdAt: DateTime.now(),
      );
      await _service.insertMessage(message);
      _messages.add(message);

      notifyListeners();
      messageController.clear();
    } on Exception catch (e) {
      _error = e.toString();
      notifyListeners();
    }
  }

  Future loadMessages(int userId) async {
    try {
      final messages = await _service.loadMessages(userId);
      _messages = messages;
      print(_messages);
      notifyListeners();
    } on Exception catch (e) {
      _error = e.toString();
      notifyListeners();
    }
  }
}
