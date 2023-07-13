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
    return Scaffold(
      body: Column(children: [
        ZnoTopHeaderSmall(
          backgroundColor: Colors.black,
          child: Container(
            margin: EdgeInsets.fromLTRB(7.w, 0, 0, 0),
            child: Align(
              alignment: Alignment.centerLeft,
              child: GestureDetector(
                onTap: () => context.pop(),
                child: Icon(
                  Icons.west,
                  size: 45.sp,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: PhotoView(imageProvider: dto.imageProvider),
        )
      ]),
    );
  }
}
