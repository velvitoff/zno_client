import 'package:audioplayers/audioplayers.dart';
import 'package:client/services/interfaces/storage_service_interface.dart';
import 'package:flutter/material.dart';

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
  final player = AudioPlayer();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        player.play(DeviceFileSource(locator
            .get<StorageServiceInterface>()
            .getImagePath(
                widget.folderName, widget.folderInnerName, widget.fileName)));
      },
      child: Text("Audio"),
    );
  }
}
