import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_notification/module/chat/controller/chat_list_controller.dart';
import 'package:test_notification/module/chat/view/chat_screen.dart';
import 'package:test_notification/module/chat/widget/chat_list_veiw.dart';

class ChatListScreen extends StatefulWidget {
  const ChatListScreen({super.key});

  @override
  State<ChatListScreen> createState() => _ChatListScreenState();
}

class _ChatListScreenState extends State<ChatListScreen> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        Provider.of<ChatListController>(context, listen: false).loadUsers();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final chatListController = context.watch<ChatListController>();
    // final chatController = context.watch<ChatListController>();

    if (chatListController.erro != null) {
      return Text(chatListController.erro!);
    } else {
      return ChatListVeiw(
        users: chatListController.users,
        onCardLick: (user) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => ChatScreen(user: user)),
          );
        },
      );
    }
  }
}
