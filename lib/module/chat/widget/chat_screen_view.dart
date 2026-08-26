import 'package:flutter/material.dart';
import 'package:test_notification/core/assets.dart';

import 'package:test_notification/core/const_color.dart';
import 'package:test_notification/core/constants.dart';
import 'package:test_notification/core/user_me.dart';
import 'package:test_notification/module/chat/model/message_model.dart';
import 'package:test_notification/module/chat/model/users_model.dart';
import 'package:test_notification/module/chat/widget/message_bubble.dart';
import 'package:test_notification/module/chat/widget/my_text_field.dart';

class ChatScreenView extends StatelessWidget {
  final VoidCallback? onLeftClick;
  final VoidCallback? onRightClick;
  final UsersModel user;
  final TextEditingController messageController;
  final List<MessageModel> messages;

  const ChatScreenView({
    super.key,
    this.onLeftClick,
    this.onRightClick,
    required this.user,
    required this.messageController,
    required this.messages,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: transparentColor,
        backgroundColor: whiteColor,
        scrolledUnderElevation: 0,
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: const Icon(
            Icons.arrow_back_ios_new_rounded,
            color: primaryColor,
          ),
        ),
        title: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(40),
              child: Image.asset(Assets.profile1, scale: 4),
            ),

            const SizedBox(width: 10),
            Column(
              crossAxisAlignment: .start,
              children: [
                Text(
                  "${user.name} ${user.lastName}",
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  Constants.activeNow,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: borderColor,
                  ),
                ),
              ],
            ),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.more_horiz_rounded),
          ),
        ],
      ),

      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            // Divider(color: dividerColor),
            Expanded(
              child: ListView.builder(
                itemCount: messages.length,
                itemBuilder: (_, index) {
                  final message = messages[index];
                  return MessageBubble(
                    message: message,
                    isMe: message.senderId != UserMe.id,
                  );
                },
              ),
            ),
            Row(
              children: [
                GestureDetector(
                  onTap: onLeftClick,
                  child: Transform.flip(
                    flipX: true,
                    child: Container(
                      padding: const EdgeInsets.only(left: 2),
                      decoration: BoxDecoration(
                        color: primaryColor,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: const Padding(
                        padding: EdgeInsets.all(12),
                        child: Icon(Icons.send_rounded, color: whiteColor),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: MyTextField(
                    controller: messageController,
                    hintText: Constants.enterYourMessages,
                  ),
                ),
                GestureDetector(
                  onDoubleTap: onRightClick,
                  child: Container(
                    // padding: const EdgeInsets.all(12),
                    padding: const EdgeInsets.only(left: 2),
                    decoration: BoxDecoration(
                      color: primaryColor,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: const Padding(
                      padding: EdgeInsets.all(12),
                      child: Icon(Icons.send_rounded, color: whiteColor),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),

    );
  }
}
