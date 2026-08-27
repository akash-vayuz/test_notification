import 'dart:io';

import 'package:audio_waveforms/audio_waveforms.dart';
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
  final void Function()? onRecorderTap;
  final RecorderController recorderController;
  final FileData fileData;
  final bool isRecording;

  const ChatScreenView({
    super.key,
    this.onLeftClick,
    this.onRightClick,
    required this.user,
    required this.messageController,
    required this.messages,
    required this.onFileClose,
    this.onRecorderTap,
    required this.fileData,
    this.isRecording = false,
    required this.onFileOpen,

    required this.onFileSelected,
    required this.recorderController,
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
                  child: _buildFilePreview(widget.fileData.fileMimeType),
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
        Align(
          alignment: Alignment.bottomRight,
          child: GestureDetector(
            onTap: () => widget.onRecorderTap?.call(),
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: widget.isRecording ? redColor : primaryColor,
                shape: BoxShape.circle,
              ),
              child: Icon(
                widget.isRecording ? Icons.mic_off_rounded : Icons.mic,
                color: whiteColor,
              ),
            ),
          ),
        ),
        _buildActionRow(context),
      ],
    );
  }

  Widget _buildFilePreview(String fileType) {
    if (fileType.contains("pdf")) {
      return const Icon(
        Icons.picture_as_pdf_rounded,
        size: 48,
        color: whiteColor,
      );
    } else if (fileType.contains("audio")) {
      return const Icon(Icons.audiotrack_rounded, size: 48, color: whiteColor);
    } else if (fileType.contains("text")) {
      return const Icon(
        Icons.text_snippet_rounded,
        size: 48,
        color: whiteColor,
      );
    } else {
      return Image.file(File(widget.fileData.path), height: 48, width: 48);
    }
  }

  Widget _buildAudioPlayer() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      padding: const EdgeInsets.symmetric(vertical: 4),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              border: Border.all(color: borderColor),
              color: primaryColor,
              // gradient: LinearGradient(
              //   begin: Alignment.topCenter,
              //   end: Alignment.bottomCenter,
              //   colors: [gradientWhite, gradientBlack],
              // ),
            ),
      child: Row(
        children: [
          AudioWaveforms(
            enableGesture: true,
            size: Size(MediaQuery.of(context).size.width / 2, 50),
            recorderController: widget.recorderController,
            waveStyle: const WaveStyle(
              waveColor: whiteColor,
              extendWaveform: true,
              showMiddleLine: false,
            ),
            // decoration: BoxDecoration(
            //   borderRadius: BorderRadius.circular(20.0),
            //   color: primaryColor,
            // ),
            padding: const EdgeInsets.symmetric(horizontal: 18, ),
            // margin: const EdgeInsets.symmetric(horizontal: 15),
          ),
        ],
      ),
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
          child: widget.isRecording
          // child: true
              ? _buildAudioPlayer()
              : MyTextField(
                  controller: widget.messageController,
                  hintText: Constants.enterYourMessages,
                  sufficIcon: IconButton(
                    onPressed: () {},
                    icon: FilePicker(
                      view: false,
                      delete: false,
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
                        Files.mp3,
                        Files.wav,
                        Files.m4a,
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
