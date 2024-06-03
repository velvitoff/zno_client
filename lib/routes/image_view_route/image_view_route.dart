import 'package:client/routes/image_view_route/image_view_page.dart';
import 'package:client/routes/image_view_route/state/image_view_route_input_data.dart';
import 'package:client/routes/image_view_route/state/image_view_route_state_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ImageViewRoute extends StatelessWidget {
  final ImageViewRouteInputData dto;

  const ImageViewRoute({super.key, required this.dto});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ImageViewRouteStateModel(
        input: dto,
      ),
      child: const Scaffold(
        body: ImageViewPage(),
      ),
    );
  }
}
