import 'package:client/dto/image_view_route_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:photo_view/photo_view.dart';
import '../../widgets/zno_top_header_small.dart';

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
          ZnoTopHeaderSmall(
            backgroundColor: const Color(0xFFF5F5F5),
            child: Container(
              margin: EdgeInsets.fromLTRB(7.w, 0, 0, 0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: GestureDetector(
                  onTap: () => context.pop(),
                  child: Icon(
                    Icons.arrow_back,
                    size: 45.sp,
                    color: const Color(0xFFF5F5F5),
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: PhotoView(
              imageProvider: dto.imageProvider,
              backgroundDecoration:
                  const BoxDecoration(color: Color(0xFFF5F5F5)),
            ),
          )
        ]),
      ),
    );
  }
}
