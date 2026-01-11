import 'dart:typed_data';

import 'package:client/routes/testing_route/state/testing_route_state_model.dart';
import 'package:client/widgets/hexagon_dots/hexagon_dots_loading.dart';
import 'package:client/widgets/zno_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class ImageInATestWrapper extends StatefulWidget {
  final Future<Uint8List> Function() getFutureBytes;
  const ImageInATestWrapper({super.key, required this.getFutureBytes});

  @override
  State<ImageInATestWrapper> createState() => _ImageInATestWrapperState();
}

class _ImageInATestWrapperState extends State<ImageInATestWrapper> {
  late Future<Uint8List> data;

  @override
  void initState() {
    super.initState();
    data = widget.getFutureBytes();
  }

  void _onOpenImage(BuildContext context, Uint8List image) {
    context.read<TestingRouteStateModel>().onOpenImage(context, image);
  }

  void _onRetry() {
    final newValue = widget.getFutureBytes();
    setState(() {
      data = newValue;
    });
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
          return _ErrorView(_onRetry);
        } else {
          return Center(
            child: HexagonDotsLoading.size(80.r),
          );
        }
      },
    );
  }
}

class _ErrorView extends StatelessWidget {
  final VoidCallback onRetry;
  const _ErrorView(this.onRetry);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey, width: 2),
        borderRadius: BorderRadius.circular(16),
      ),
      margin: EdgeInsets.symmetric(vertical: 8.h),
      padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 8.w),
      child: Column(
        spacing: 12.h,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'Помилка завантаження\nзображення',
            style: TextStyle(fontSize: 16.sp),
            textAlign: TextAlign.center,
          ),
          ZnoButton(
            onTap: onRetry,
            width: 145.w,
            height: 50.h,
            text: 'Спробувати ще раз',
            fontSize: 20.sp,
          ),
        ],
      ),
    );
  }
}
