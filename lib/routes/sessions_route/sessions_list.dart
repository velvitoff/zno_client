import 'package:flutter/material.dart';

class SessionsList extends StatelessWidget {
  final List<Widget> list;

  const SessionsList({Key? key, required this.list}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate:
          SliverChildBuilderDelegate((BuildContext context, int position) {
        return Align(
          alignment: Alignment.center,
          child: list[position],
        );
      }, childCount: list.length),
    );
  }
}
