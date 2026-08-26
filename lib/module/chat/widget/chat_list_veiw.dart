import 'package:flutter/material.dart';
import 'package:test_notification/core/const_color.dart';
import 'package:test_notification/core/constants.dart';
import 'package:test_notification/module/chat/model/users_model.dart';
import 'package:test_notification/module/chat/widget/user_card.dart';

class ChatListVeiw extends StatelessWidget {
  const ChatListVeiw({super.key, required this.users, this.onCardLick});
  final List<UsersModel> users;
  final void Function(UsersModel)? onCardLick;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          Constants.messages,
          style: TextStyle(color: primaryColor, fontWeight: FontWeight.w700),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Divider(color: dividerColor),
          Expanded(
            child: ListView.separated(
              
              itemCount: users.length,
              itemBuilder: (_, index) {
                final user = users[index];
                return UserCard(
                  user: user,
                  onTap: () => onCardLick?.call(user),
                );
              },
              separatorBuilder: (_, _) => Divider(color: dividerColor),
            ),
          ),
        
        ],
      ),
    );
  }
}
