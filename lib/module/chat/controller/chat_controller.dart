import 'package:file_picker_pro/file_data.dart';
import 'package:flutter/material.dart';
import 'package:test_notification/core/user_me.dart';
import 'package:test_notification/module/chat/model/message_model.dart';
import 'package:test_notification/module/chat/model/users_model.dart';
import 'package:test_notification/module/chat/service/message_service.dart';

class ChatController extends ChangeNotifier {
  final MessageService _service;
  UsersModel? _user;

  FileData _fileData = FileData();
  String? _error;
  List<MessageModel> _messages = [];

  ChatController(this._service);

  // Getters
  final TextEditingController messageController = TextEditingController();
  List<MessageModel> get messages => _messages;
  String? get error => _error;
  UsersModel? get user => _user;
  FileData get fileDate => _fileData;

  Future sendMessage(int userId, bool isMe) async {
    try {
      if (messageController.text.isEmpty && !_fileData.hasFile) {
        return;
      }
      final message = MessageModel(
        content: messageController.text.trim(),
        senderId: isMe ? UserMe.id : userId,
        receiverId: isMe ? userId : UserMe.id,
        createdAt: DateTime.now(),
        type: _fileData.hasFile
            ? _fileData.fileMimeType == "application/pdf"
                  ? MessageType.file
                  : MessageType.image
            : MessageType.text,
        path: _fileData.path,
      );
      await _service.insertMessage(message);

      _messages.add(message);
      notifyListeners();
      messageController.clear();
      _fileData = FileData();
    } on Exception catch (e) {
      _error = e.toString();
      notifyListeners();
    }
  }

  Future loadMessages(int userId) async {
    try {
      final messages = await _service.loadMessages(userId);
      _messages = messages;
      notifyListeners();
    } on Exception catch (e) {
      _error = e.toString();
      notifyListeners();
    }
  }

  void setFileData(FileData fileData) {
    _fileData = fileData;
    notifyListeners();
  }

  void clearFile() {
    _fileData = FileData();
    notifyListeners();
  }
}
