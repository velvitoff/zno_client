import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
import 'package:client/services/interfaces/storage_service_interface.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../locator.dart';

class AudioPlayerWidget extends StatefulWidget {
  final String folderName;
  final String folderInnerName;
  final String fileName;

  const AudioPlayerWidget(
      {super.key,
      required this.folderName,
      required this.folderInnerName,
      required this.fileName});

  @override
  State<AudioPlayerWidget> createState() => _AudioPlayerState();
}

class _AudioPlayerState extends State<AudioPlayerWidget> {
  late final Source source;
  late final List<StreamSubscription> subscriptions;
  final player = AudioPlayer();

  bool isPlaying = false;
  Duration duration = Duration.zero;
  Duration position = Duration.zero;

  @override
  void initState() {
    super.initState();
    source = DeviceFileSource(locator
        .get<StorageServiceInterface>()
        .getImagePath(
            widget.folderName, widget.folderInnerName, widget.fileName));

    player.setSource(source);

    subscriptions = [];
    subscriptions.addAll([
      player.onPlayerStateChanged.listen((state) => setState(() {
            isPlaying = state == PlayerState.playing;
          })),
      player.onDurationChanged.listen((newDuration) => setState(() {
            duration = newDuration;
          })),
      player.onPositionChanged.listen((newPosition) => setState(() {
            position = newPosition;
          }))
    ]);
  }

  @override
  void dispose() {
    for (var sub in subscriptions) {
      sub.cancel();
    }
    player.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 10.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: () {
              if (isPlaying) {
                player.pause();
              } else {
                player.play(source);
              }
              setState(() => isPlaying = !isPlaying);
            },
            child: Icon(
              isPlaying ? Icons.pause_circle : Icons.play_circle,
              size: 50.r,
              color: const Color(0xFF418C4A),
            ),
          ),
          Expanded(
            child: Container(
              margin: EdgeInsets.only(left: 8.w, right: 8.w),
              child: SliderTheme(
                data: SliderThemeData(
                    overlayShape: SliderComponentShape.noOverlay),
                child: Slider(
                  min: 0,
                  max: duration.inSeconds.toDouble(),
                  value: position.inSeconds.toDouble(),
                  onChanged: (value) =>
                      player.seek(Duration(seconds: value.toInt())),
                ),
              ),
            ),
          ),
          Text(
              '${position.inMinutes}:${(position.inSeconds % 60).toString().padLeft(2, '0')} / ${duration.inMinutes}:${(duration.inSeconds % 60).toString().padLeft(2, '0')}')
        ],
      ),
    );
  }
}
