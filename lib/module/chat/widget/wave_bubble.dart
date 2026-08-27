import 'dart:async';

import 'package:audio_waveforms/audio_waveforms.dart';
import 'package:flutter/material.dart';
import 'package:test_notification/core/const_color.dart';

class WaveBubble extends StatefulWidget {
  const WaveBubble({
    super.key,
    this.width,
    this.isSender = false,
    required this.path,
  });

  final bool isSender;
  final String path;
  final double? width;

  @override
  State<WaveBubble> createState() => _WaveBubbleState();
}

class _WaveBubbleState extends State<WaveBubble> {
  late PlayerController controller;
  late StreamSubscription<PlayerState> playerStateSubscription;

  PlayerWaveStyle? playerWaveStyle;

  @override
  void initState() {
    super.initState();
    controller = PlayerController();
    playerWaveStyle = PlayerWaveStyle(
      fixedWaveColor: widget.isSender
          ? whiteColor.withValues(alpha: 0.3)
          : blackColor.withValues(alpha: 0.3),
      liveWaveColor: widget.isSender
          ? whiteColor
          : blackColor,
      spacing: 6,
    );
    _preparePlayer();
    playerStateSubscription = controller.onPlayerStateChanged.listen((_) {
      setState(() {});
    });
  }

  void _preparePlayer() async {
    controller.preparePlayer(
      path: widget.path,
      shouldExtractWaveform: widget.isSender,
    );
    if (!widget.isSender) {
      controller.waveformExtraction
          .extractWaveformData(
            path: widget.path,
            noOfSamples: playerWaveStyle?.getSamplesForWidth(
              widget.width ?? 200,
            ),
          )
          .then((waveformData) => debugPrint(waveformData.toString()));
    }
  }

  @override
  void dispose() {
    playerStateSubscription.cancel();
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        bottom: 6,
        right: widget.isSender ? 0 : 10,
        top: 6,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: widget.isSender ? primaryColor : whiteColor,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (!controller.playerState.isStopped)
            IconButton(
              onPressed: () async {
                controller.playerState.isPlaying
                    ? await controller.pausePlayer()
                    : await controller.startPlayer();
                controller.setFinishMode(finishMode: FinishMode.loop);
              },
              icon: Icon(
                controller.playerState.isPlaying
                    ? Icons.stop
                    : Icons.play_arrow,
              ),
              color: widget.isSender ? whiteColor : primaryColor,
              splashColor: transparentColor,
              highlightColor: transparentColor,
            ),
          AudioFileWaveforms(
            size: Size(MediaQuery.of(context).size.width / 2, 70),
            playerController: controller,
            waveformType: widget.isSender
                ? WaveformType.long
                : WaveformType.fitWidth,
            playerWaveStyle: playerWaveStyle ?? const PlayerWaveStyle(),
          ),
          if (widget.isSender) const SizedBox(width: 10),
        ],
      ),
    );
  }
}
