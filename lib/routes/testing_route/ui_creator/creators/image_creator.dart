import 'package:client/locator.dart';
import 'package:client/routes/testing_route/state/testing_route_state_model.dart';
import 'package:client/routes/testing_route/ui_creator/widgets/image_in_a_test_wrapper.dart';
import 'package:client/services/storage_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ImageCreator {
  final BuildContext context;
  final String fileName;

  const ImageCreator({
    required this.context,
    required this.fileName,
  });

  Widget create() {
    final model = context.read<TestingRouteStateModel>();
    return ImageInATestWrapper(
      futureBytes: locator
          .get<StorageService>()
          .getImageBytes(model.sessionData, fileName),
    );
  }
}
