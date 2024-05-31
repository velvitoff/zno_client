import 'package:client/all_subjects/zno_subject_interface.dart';
import 'package:client/routes/subjects_route/widgets/subjects_list.dart';
import 'package:flutter/material.dart';
import 'package:client/widgets/zno_top_header_text.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SubjectsScrollView extends StatelessWidget {
  final List<ZnoSubjectInterface> list;
  const SubjectsScrollView({super.key, required this.list});

  @override
  Widget build(BuildContext context) {
    final double topPadding = MediaQuery.of(context).padding.top;
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          flexibleSpace: const ZnoTopHeaderText(
            text: 'Оберіть предмет зі списку, щоб пройти тест',
          ),
          expandedHeight: 150.h - topPadding,
          backgroundColor: const Color(0xFFF5F5F5),
        ),
        SliverToBoxAdapter(
          child: SizedBox(height: 20.h),
        ),
        SubjectsList(list: list)
      ],
    );
  }
}
