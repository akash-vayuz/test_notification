import 'dart:io';

import 'package:audio_waveforms/audio_waveforms.dart';
import 'package:file_picker_pro/file_data.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:test_notification/core/user_me.dart';
import 'package:test_notification/module/chat/model/message_model.dart';
import 'package:test_notification/module/chat/model/users_model.dart';
import 'package:test_notification/module/chat/service/message_service.dart';
import 'package:test_notification/utils/file_data_extensions.dart';

class ChatController extends ChangeNotifier {
  final MessageService _service;
  late final Directory _aapDirectory;
  ChatController(this._service) {
    _init();
  }

  // states
  UsersModel? _user;

  FileData _fileData = FileData();
  String? _error;
  List<MessageModel> _messages = [];

  bool _isRecording = false;
  String? _currentAudioFile;

  // Getters
  final recorderController = RecorderController();
  final TextEditingController messageController = TextEditingController();
  List<MessageModel> get messages => _messages;
  String? get error => _error;
  UsersModel? get user => _user;
  FileData get fileDate => _fileData;
  bool get isRecording => _isRecording;
  String? get currentAuidoFile => _currentAudioFile;

  void _init() async {
    _aapDirectory = await getApplicationDocumentsDirectory();
  }

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
                  : _fileData.fileMimeType.contains("audio")
                  ? MessageType.audio
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

  void clearControllers() {
    messageController.clear();
    _fileData = FileData();
  }

  void startOrStopRecording() async {
    try {
      if (_isRecording) {
        recorderController.reset();

        final path = await recorderController.stop(false);
        _isRecording = false;
        notifyListeners();
       

        if (path != null) {
          _currentAudioFile = path;
          _fileData = FileDataX.fromRcordFile(path: path);
          debugPrint(path);
          debugPrint("Recorded file size: ${File(path).lengthSync()}");
        }
      } else {
        final path =
            "${_aapDirectory.path}/recording_${DateTime.now().millisecondsSinceEpoch}.m4a";
        await recorderController.record(
          path: path, 
          recorderSettings: const RecorderSettings(),
        );
        _isRecording = true;
        notifyListeners();
      }

      notifyListeners();
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      if (recorderController.hasPermission) {
        notifyListeners();
      }
    }
  }

  @override
  void dispose() {
    super.dispose();
    messageController.clear();
    messageController.dispose();
    recorderController.dispose();
  }
}
