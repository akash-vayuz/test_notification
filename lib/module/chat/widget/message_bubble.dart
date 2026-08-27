import 'dart:io';

import 'package:flutter/material.dart';
import 'package:open_share_plus/open.dart';
import 'package:test_notification/core/const_color.dart';
import 'package:test_notification/module/chat/model/message_model.dart';
import 'package:test_notification/module/chat/widget/wave_bubble.dart';
import 'package:test_notification/utils/daytime_utils.dart';
import 'package:test_notification/utils/path_utils.dart';

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
            switch (message.type) {
              MessageType.text => _buildTextBubble(),
              MessageType.image => _buildImageBubble(context),
              MessageType.audio => _buidlAudiPlayer(context),

              MessageType.file => _buildFileBubble(context),
            },
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

  Container _buildFileBubble(BuildContext context) {
    return Container(
      // height: 50,
      width: MediaQuery.of(context).size.width * 0.6,
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      decoration: BoxDecoration(
        color: isMe ? primaryColor : whiteColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Wrap(
        direction: Axis.horizontal,
        crossAxisAlignment: .center,
        children: [
          Icon(
            Icons.picture_as_pdf_rounded,
            color: isMe ? whiteColor : primaryColor,
            size: 40,
          ),
          // const SizedBox(width: 10),
          GestureDetector(
            onTap: () {
              Open.localFile(filePath: message.path!);
            },
            child: Text(
              maxLines: 1,
              PathUtils.extractFileName(message.path!),
              style: TextStyle(
                color: isMe ? whiteColor : blackColor,
                fontWeight: FontWeight.w600,
                fontSize: 16,
                overflow: TextOverflow.ellipsis,
                decoration: TextDecoration.underline,
                decorationColor: isMe ? whiteColor : blackColor,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Container _buildImageBubble(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.7,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      decoration: BoxDecoration(
        color: isMe ? primaryColor : whiteColor,
        borderRadius: BorderRadius.circular(20),
      ),

      child: GestureDetector(
        onTap: () {
          Open.localFile(filePath: message.path!);
        },
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Image.file(File(message.path!), fit: BoxFit.cover),
        ),
      ),
    );
  }

  Container _buildTextBubble() {
    return Container(
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
    );
  }

  Widget _buidlAudiPlayer(BuildContext context) {
    // return Container();
    return WaveBubble(
      path: message.path!,
      isSender: isMe,
      width: MediaQuery.of(context).size.width * 0.7,
    );
  }
}
