import 'package:client/widgets/zno_list_item.dart';
import 'package:flutter/material.dart';
import 'package:tuple/tuple.dart';

class ZnoList extends StatelessWidget {
  final List<Tuple2<String, void Function()>> list;

  const ZnoList({Key? key, required this.list}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate:
          SliverChildBuilderDelegate((BuildContext context, int position) {
        return Align(
          alignment: Alignment.center,
          child: ZnoListItem(
            text: list[position].item1,
            onTap: list[position].item2,
            colorType: ZnoListColorType.normal,
          ),
        );
      }, childCount: list.length),
    );
  }
}
