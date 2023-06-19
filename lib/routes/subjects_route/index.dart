import 'package:client/routes.dart';
import 'package:client/widgets/zno_bottom_navigation_bar.dart';
import 'package:client/widgets/zno_list.dart';
import 'package:client/widgets/zno_top_header_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:tuple/tuple.dart';

import '../../dto/sessions_route_data.dart';

class SubjectsRoute extends StatelessWidget {
  const SubjectsRoute({Key? key}) : super(key: key);

  static const List<Tuple2<String, String>> subjects = [
    Tuple2('Українська мова і література', 'ukrainian_lang_and_lit'),
    //Tuple2('Українська мова', 'ukrainian_lang'),
    //Tuple2('Математика','math'),
    //Tuple2('Національний мультитест','nmt'),
    //Tuple2('Історія України', 'ukraine_history'),
    //Tuple2('Фізика','physics'),
    //Tuple2('Хімія','chemistry'),
    Tuple2('Географія', 'geography'),
    Tuple2('Біологія', 'biology'),
    //Tuple2('Англійська мова', 'english_lang'),
    //Tuple2('Німецька мова','german_lang'),
    //Tuple2('Французька мова','french_lang'),
    //Tuple2('ЗНО для вчителів','zno_teachers'),
    //Tuple2('ЗНО в магістратуру','zno_master'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: CustomScrollView(
              slivers: [
                SliverAppBar(
                  flexibleSpace: const ZnoTopHeaderText(
                      text: 'Оберіть предмет зі списку, щоб пройти тест'),
                  expandedHeight: 250.h,
                  backgroundColor: const Color(0xFFF5F5F5),
                ),
                ZnoList(
                    list: subjects.map((subject) {
                  return Tuple2(
                      subject.item1,
                      () => context.go(Routes.sessionsRoute,
                          extra: SessionsRouteData(
                              subjectName: subject.item1,
                              folderName: subject.item2)));
                }).toList())
              ],
            ),
          ),
          const ZnoBottomNavigationBar(activeIndex: 0)
        ],
      ),
    );
  }
}
