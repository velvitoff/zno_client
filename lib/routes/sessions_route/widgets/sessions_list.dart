import 'package:client/models/exam_file_adress_model.dart';
import 'package:client/routes.dart';
import 'package:client/widgets/zno_list_item.dart';
import 'package:client/routes/sessions_route/widgets/zno_year_line.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SessionsList extends StatefulWidget {
  final List<MapEntry<String, List<ExamFileAddressModel>>> list;
  const SessionsList({super.key, required this.list});

  @override
  State<SessionsList> createState() => _SessionsListState();
}

class _SessionsListState extends State<SessionsList> {
  late final List<Widget> children;

  @override
  void initState() {
    super.initState();
    List<Widget> result = [];
    for (final mapEntry in widget.list) {
      result.add(ZnoYearLine(text: mapEntry.key));
      result.addAll(mapEntry.value.map((e) => ZnoListItem(
            text: e.sessionName,
            onTap: () => _onItemTap(e),
            colorType: ZnoListColorType.normal,
          )));
    }
    children = result;
  }

  void _onItemTap(ExamFileAddressModel examFileAddress) {
    context.push(Routes.sessionRoute, extra: examFileAddress);
  }

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (BuildContext context, int position) {
          return Align(
            alignment: Alignment.center,
            child: children[position],
          );
        },
        childCount: children.length,
      ),
    );
  }
}
