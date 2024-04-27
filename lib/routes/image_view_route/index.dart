import 'package:client/routes/image_view_route/image_view_route_data.dart';
import 'package:client/routes/image_view_route/image_view_route_header.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ImageViewRoute extends StatelessWidget {
  final ImageViewRouteData dto;

  const ImageViewRoute({super.key, required this.dto});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (bool didPop) => context.pop(),
      child: Scaffold(
        body: Column(children: [
          const ImageViewRouteHeader(),
          Expanded(
            child: ColoredBox(
              color: const Color(0xFFF5F5F5),
              child: InteractiveViewer(
                child: Image(image: dto.imageProvider),
              ),
            ),
          )
        ]),
      ),
    );
  }
}
