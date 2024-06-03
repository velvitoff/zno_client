import 'package:client/routes/image_view_route/state/image_view_route_input_data.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ImageViewRouteStateModel extends ChangeNotifier {
  final ImageViewRouteInputData input;

  ImageViewRouteStateModel({
    required this.input,
  });

  void onBack(BuildContext context) {
    if (!context.canPop()) return;
    context.pop();
  }
}
