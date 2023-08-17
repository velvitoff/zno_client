import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

class ZnoLoading extends StatelessWidget {
  const ZnoLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: RiveAnimation.asset('assets/rive/loading.riv'),
    );
  }
}
