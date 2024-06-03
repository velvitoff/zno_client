import 'package:client/models/exam_file_adress_model.dart';
import 'package:client/routes/sessions_route/state/sessions_route_state_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:client/widgets/hexagon_dots/hexagon_dots_loading.dart';
import 'package:client/widgets/zno_error.dart';
import 'package:client/widgets/zno_top_header_text.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:client/routes/sessions_route/widgets/sessions_list.dart';
import 'package:client/routes/sessions_route/widgets/sessions_scroll_wrapper.dart';

class SessionsPage extends StatelessWidget {
  const SessionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final model = context.read<SessionsRouteStateModel>();

    return FutureBuilder(
      future: model.futureList,
      builder: (BuildContext context,
          AsyncSnapshot<List<MapEntry<String, List<ExamFileAddressModel>>>>
              snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data!.isEmpty) {
            return SessionsScrollWrapper(
              subjectName: model.inputData.subjectName,
              child: SliverToBoxAdapter(
                child: ZnoError(
                  text: 'Немає доступних тестів',
                  textFontSize: 25.sp,
                ),
              ),
            );
          } else {
            return SessionsScrollWrapper(
              subjectName: model.inputData.subjectName,
              child: SessionsList(list: snapshot.data!),
            );
          }
        } else if (snapshot.hasError) {
          return Column(
            children: [
              ZnoTopHeaderText(text: model.inputData.subjectName),
              const ZnoError(text: 'Помилка завантаження даних')
            ],
          );
        } else {
          return SessionsScrollWrapper(
              subjectName: model.inputData.subjectName,
              child: SliverToBoxAdapter(
                child: Column(
                  children: [
                    SizedBox(height: 100.h),
                    SizedBox(
                      height: 300.h,
                      child: HexagonDotsLoading.def(),
                    )
                  ],
                ),
              ));
        }
      },
    );
  }
}
