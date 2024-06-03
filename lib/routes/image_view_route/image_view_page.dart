import 'package:client/routes/image_view_route/state/image_view_route_state_model.dart';
import 'package:client/routes/image_view_route/widgets/image_view_route_header.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ImageViewPage extends StatelessWidget {
  const ImageViewPage({super.key});

  @override
  Widget build(BuildContext context) {
    final imageProvider =
        context.read<ImageViewRouteStateModel>().input.imageProvider;
    return Column(
      children: [
        const ImageViewRouteHeader(),
        Expanded(
          child: ColoredBox(
            color: const Color(0xFFF5F5F5),
            child: InteractiveViewer(
              child: Image(
                image: imageProvider,
              ),
            ),
          ),
        )
      ],
    );
  }
}
