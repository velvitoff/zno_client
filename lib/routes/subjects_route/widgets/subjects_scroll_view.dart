import 'package:client/all_subjects/zno_subject_interface.dart';
import 'package:client/routes/subjects_route/widgets/subjects_list.dart';
import 'package:client/widgets/zno_icon_button.dart';
import 'package:flutter/material.dart';
import 'package:client/widgets/zno_top_header_text.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class SubjectsScrollView extends StatelessWidget {
  final List<ZnoSubjectInterface> list;
  final bool shouldHaveBackArrow;
  const SubjectsScrollView({
    super.key,
    required this.list,
    required this.shouldHaveBackArrow,
  });

  void _goBack(BuildContext context) {
    if (!context.canPop()) return;
    context.pop();
  }

  @override
  Widget build(BuildContext context) {
    final double topPadding = MediaQuery.of(context).padding.top;
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          automaticallyImplyLeading: false,
          flexibleSpace: ZnoTopHeaderText(
            text: 'Оберіть предмет зі списку, щоб пройти тест',
            topLeftWidget: shouldHaveBackArrow
                ? Padding(
                    padding: EdgeInsets.only(top: 10.h),
                    child: ZnoIconButton(
                      icon: Icons.arrow_back,
                      onTap: () => _goBack(context),
                    ),
                  )
                : null,
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
