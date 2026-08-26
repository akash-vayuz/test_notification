import 'package:flutter/material.dart';
import 'package:test_notification/core/const_color.dart';
import 'package:test_notification/module/chat/model/message_model.dart';
import 'package:test_notification/utils/daytime_utils.dart';

class MessageBubble extends StatelessWidget {
  final MessageModel message;
  final bool isMe;
  const MessageBubble({super.key, required this.message, required this.isMe});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: isMe ? Alignment.bottomRight : Alignment.bottomLeft,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Column(
          crossAxisAlignment: isMe
              ? CrossAxisAlignment.end
              : CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: isMe ? primaryColor : whiteColor,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: primaryColor),
              ),
              child: Text(
                message.content,
                style: TextStyle(
                  color: isMe ? whiteColor : blackColor,
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                ),
              ),
            ),
            // const SizedBox(height: 8),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: isMe ? 10.0 : 6,
              ).copyWith(top: 2),
              child: Text(
                DaytimeUtils.formatTime(message.createdAt),
                style: TextStyle(
                  color: borderColor,
                  fontWeight: FontWeight.w700,
                  fontSize: 12,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
