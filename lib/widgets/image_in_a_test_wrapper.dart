import 'dart:typed_data';

import 'package:client/dto/image_view_route_data.dart';
import 'package:client/routes.dart';
import 'package:client/widgets/hexagon_dots/hexagon_dots_loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class ImageInATestWrapper extends StatefulWidget {
  final Future<Uint8List> futureBytes;
  const ImageInATestWrapper({super.key, required this.futureBytes});

  @override
  State<ImageInATestWrapper> createState() => _ImageInATestWrapperState();
}

class _ImageInATestWrapperState extends State<ImageInATestWrapper> {
  late final Future<Uint8List> data = widget.futureBytes;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: data,
      builder: (BuildContext context, AsyncSnapshot<Uint8List> snapshot) {
        if (snapshot.hasData) {
          return GestureDetector(
              onTap: () => context.push(Routes.imageViewRoute,
                  extra: ImageViewRouteData(
                      imageProvider: MemoryImage(snapshot.data!))),
              child: Image.memory(snapshot.data!));
        } else if (snapshot.hasError) {
          return const Text('Помилка завантаження зображення');
        } else {
          return Center(
            child: HexagonDotsLoading.size(80.r),
          );
        }
      },
    );
  }
}
