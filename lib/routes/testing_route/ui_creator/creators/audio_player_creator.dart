import 'package:client/routes/testing_route/state/testing_route_state_model.dart';
import 'package:client/routes/testing_route/ui_creator/widgets/audio_player_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AudioPlayerCreator {
  final BuildContext context;
  final String fileName;

  const AudioPlayerCreator({
    required this.context,
    required this.fileName,
  });

  Widget create() {
    final model = context.read<TestingRouteStateModel>();
    return AudioPlayerWidget(
        examFileAddress: model.sessionData, fileName: fileName);
  }
}
