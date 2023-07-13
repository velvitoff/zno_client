import 'package:flutter/material.dart';

class HorizontalScrollWrapper extends StatefulWidget {
  final Widget? child;

  const HorizontalScrollWrapper({super.key, this.child});

  @override
  State<HorizontalScrollWrapper> createState() =>
      _HorizontalScrollWrapperState();
}

class _HorizontalScrollWrapperState extends State<HorizontalScrollWrapper> {
  late final ScrollController _controller;

  @override
  void initState() {
    super.initState();
    _controller = ScrollController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scrollbar(
      thumbVisibility: true,
      controller: _controller,
      child: SingleChildScrollView(
        controller: _controller,
        scrollDirection: Axis.horizontal,
        child: widget.child,
      ),
    );
  }
}
