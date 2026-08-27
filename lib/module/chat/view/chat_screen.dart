import 'package:file_picker_pro/files.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_notification/module/chat/controller/chat_controller.dart';
import 'package:test_notification/module/chat/model/users_model.dart';
import 'package:test_notification/module/chat/widget/chat_screen_view.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key, required this.user});
  final UsersModel user;

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        Provider.of<ChatController>(
          context,
          listen: false,
        ).loadMessages(widget.user.id!);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final chatScreenController = context.watch<ChatController>();
    if (chatScreenController.error != null) {
      return Scaffold(
        body: Center(child: Text("Error ${chatScreenController.error}")),
      );
    }

    return PopScope(
      onPopInvokedWithResult: (_, _) {
        chatScreenController.clearControllers();
      },
      child: ChatScreenView(
        messages: chatScreenController.messages,
        user: widget.user,
        fileData: chatScreenController.fileDate,
        messageController: chatScreenController.messageController,
        onLeftClick: () =>
            chatScreenController.sendMessage(widget.user.id!, true),
        onRightClick: () =>
            chatScreenController.sendMessage(widget.user.id!, false),

        onFileSelected: (fileData) {
          chatScreenController.setFileData(fileData);
        },
        onFileClose: () => chatScreenController.clearFile(),
        onFileOpen: () =>
            Files.viewFile(fileData: chatScreenController.fileDate),
        recorderController: chatScreenController.recorderController,
        isRecording: chatScreenController.isRecording,
        onRecorderTap:()=> chatScreenController.startOrStopRecording(),
        
      ),
    );
  }
}
