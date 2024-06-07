import 'dart:typed_data';
import 'package:client/routes/testing_route/state/testing_route_state_model.dart';
import 'package:client/widgets/hexagon_dots/hexagon_dots_loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class ImageInATestWrapper extends StatefulWidget {
  final Future<Uint8List> futureBytes;
  const ImageInATestWrapper({super.key, required this.futureBytes});

  @override
  State<ImageInATestWrapper> createState() => _ImageInATestWrapperState();
}

class _ImageInATestWrapperState extends State<ImageInATestWrapper> {
  late final Future<Uint8List> data = widget.futureBytes;

  void _onOpenImage(BuildContext context, Uint8List image) {
    context.read<TestingRouteStateModel>().onOpenImage(context, image);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: data,
      builder: (BuildContext context, AsyncSnapshot<Uint8List> snapshot) {
        if (snapshot.hasData) {
          return GestureDetector(
            onTap: () => _onOpenImage(
              context,
              snapshot.data!,
            ),
            child: Image.memory(snapshot.data!),
          );
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
