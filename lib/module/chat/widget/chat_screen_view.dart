import 'dart:io';

import 'package:file_picker_pro/file_data.dart';
import 'package:file_picker_pro/file_picker.dart';
import 'package:file_picker_pro/files.dart';
import 'package:flutter/material.dart';
import 'package:test_notification/core/assets.dart';

import 'package:test_notification/core/const_color.dart';
import 'package:test_notification/core/constants.dart';
import 'package:test_notification/core/user_me.dart';
import 'package:test_notification/module/chat/model/message_model.dart';
import 'package:test_notification/module/chat/model/users_model.dart';
import 'package:test_notification/module/chat/widget/message_bubble.dart';
import 'package:test_notification/module/chat/widget/my_text_field.dart';

class ChatScreenView extends StatefulWidget {
  final VoidCallback? onLeftClick;
  final VoidCallback? onRightClick;
  final UsersModel user;
  final TextEditingController messageController;
  final List<MessageModel> messages;
  final void Function(FileData) onFileSelected;
  final void Function() onFileClose;
  final void Function() onFileOpen;
  final FileData fileData;

  const ChatScreenView({
    super.key,
    this.onLeftClick,
    this.onRightClick,
    required this.user,
    required this.messageController,
    required this.messages,
    required this.onFileClose,
    required this.fileData,
    required this.onFileOpen,

    required this.onFileSelected,
  });

  @override
  State<ChatScreenView> createState() => _ChatScreenViewState();
}

class _ChatScreenViewState extends State<ChatScreenView> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        scrollToBottom();
        // _scrollController.addListener(() {
        //   if (_scrollController.position.pixels <
        //       _scrollController.position.maxScrollExtent) {
        //     scrollToBottom();
        //   }
        // });
        WidgetsBinding.instance.addPostFrameCallback((_) {
          scrollToBottom();
        });
      }
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final bottomInset = MediaQuery.of(context).viewInsets.bottom;

    if (bottomInset > 0) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        scrollToBottom();
      });
    }
  }

  void scrollToBottom() {
    if (_scrollController.hasClients) {
      _scrollController.jumpTo(
        _scrollController.position.maxScrollExtent + 55,
        // duration: const Duration(milliseconds: 300),
        // curve: Curves.easeOut,
      );
    }
    // _scrollController.addListener((){print(_scrollController.position);});
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),

      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            // Divider(color: dividerColor),
            _buildMessagess(),
            _buildFileHolder(context),
          ],
        ),
      ),
    );
  }

  Expanded _buildMessagess() {
    return Expanded(
      child: ListView.builder(
        controller: _scrollController,
        itemCount: widget.messages.length,
        itemBuilder: (_, index) {
          final message = widget.messages[index];
          return MessageBubble(
            message: message,
            isMe: message.senderId != UserMe.id,
          );
        },
      ),
    );
  }

  Column _buildFileHolder(BuildContext context) {
    return Column(
      crossAxisAlignment: .start,
      children: [
        if (widget.fileData.hasFile) ...[
          Stack(
            clipBehavior: Clip.none,
            children: [
              GestureDetector(
                onTap: widget.onFileOpen,
                child: Container(
                  // margin: const EdgeInsets.only(left: 80),
                  // padding: EdgeInsets.symmetric(horizontal: 24, ),
                  decoration: BoxDecoration(
                    color: primaryColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: widget.fileData.fileMimeType == "application/pdf"
                      ? const Icon(
                          Icons.picture_as_pdf_rounded,
                          size: 48,
                          color: whiteColor,
                        )
                      : Image.file(
                          File(widget.fileData.path),
                          height: 48,
                          width: 48,
                        ),
                ),
              ),
              Positioned(
                right: -8,
                top: -8,
                child: Container(
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: whiteColor,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: dividerColor,
                        spreadRadius: 1,
                        blurRadius: 5,
                        offset: const Offset(2, -2),
                      ),
                    ],
                  ),
                  child: InkWell(
                    onTap: widget.onFileClose,
                    child: const Icon(
                      Icons.close_rounded,
                      color: primaryColor,
                      size: 18,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
        _buildActionRow(context),
      ],
    );
  }

  Row _buildActionRow(BuildContext context) {
    return Row(
      // crossAxisAlignment: .end,
      children: [
        GestureDetector(
          onTap: () {
            widget.onLeftClick?.call();
            scrollToBottom();
          },
          child: Transform.flip(
            flipX: true,
            child: Container(
              padding: const EdgeInsets.only(left: 2),
              decoration: const BoxDecoration(
                color: primaryColor,
                shape: BoxShape.circle,
              ),
              child: const Padding(
                padding: EdgeInsets.all(12),
                child: Icon(Icons.send_rounded, color: whiteColor),
              ),
            ),
          ),
        ),
        Expanded(
          child: Center(
            child: MyTextField(
              controller: widget.messageController,
              hintText: Constants.enterYourMessages,
              sufficIcon: IconButton(
                onPressed: () {},
                icon: FilePicker(
                  view: false,
                  // delete: false,
                  context: context,
                  height: 100,
                  fileData: widget.fileData,
                  crop: true,
                  maxFileSizeInMb: 10,
                  allowedExtensions: const [
                    Files.txt,
                    Files.png,
                    Files.jpg,
                    Files.pdf,
                  ],
                  // onSelected: (fileData) {

                  //   setState(() {});
                  // },
                  onSelected: (fileData) => widget.onFileSelected(fileData),
                  onCancel: (message, messageCode) {
                    debugPrint("[$messageCode] $message");
                  },

                  child: const Icon(Icons.add, color: whiteColor, size: 20),
                ),
              ),
            ),
          ),
        ),
        GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () {
            widget.onRightClick?.call();
            scrollToBottom();
          },
          child: Container(
            // padding: const EdgeInsets.all(12),
            padding: const EdgeInsets.only(left: 2),
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: primaryColor,
            ),
            child: const Padding(
              padding: EdgeInsets.all(12),
              child: Icon(Icons.send_rounded, color: whiteColor),
            ),
          ),
        ),
      ],
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
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
                "${widget.user.name} ${widget.user.lastName}",
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
    );
  }
}
