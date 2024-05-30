import 'package:client/routes/image_view_route/state/image_view_route_input_data.dart';
import 'package:client/routes/image_view_route/widgets/image_view_route_header.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ImageViewRoute extends StatelessWidget {
  final ImageViewRouteInputData dto;

  const ImageViewRoute({super.key, required this.dto});

  void _onPopInvoked(BuildContext context, bool didPop) {
    context.pop();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (bool didPop) => _onPopInvoked(context, didPop),
      child: Scaffold(
        body: Column(
          children: [
            const ImageViewRouteHeader(),
            Expanded(
              child: ColoredBox(
                color: const Color(0xFFF5F5F5),
                child: InteractiveViewer(
                  child: Image(image: dto.imageProvider),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
