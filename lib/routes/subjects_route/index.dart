import 'package:client/dto/personal_config_data.dart';
import 'package:client/locator.dart';
import 'package:client/routes.dart';
import 'package:client/services/interfaces/storage_service_interface.dart';
import 'package:client/widgets/zno_bottom_navigation_bar.dart';
import 'package:client/widgets/zno_list.dart';
import 'package:client/widgets/zno_top_header_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:tuple/tuple.dart';

import '../../dto/sessions_route_data.dart';

class SubjectsRoute extends StatefulWidget {
  const SubjectsRoute({super.key});

  @override
  State<SubjectsRoute> createState() => _SubjectsRouteState();
}

class _SubjectsRouteState extends State<SubjectsRoute> {
  late final Future<List<String>> subjectsList;
  late final ScrollController scrollController;
  bool isScrollAtTop = true;

  @override
  void initState() {
    super.initState();
    subjectsList = locator.allReady().then((value) => locator
        .get<StorageServiceInterface>()
        .getPersonalConfigData()
        .then((value) => value.selectedSubjects));

    scrollController = ScrollController();
    scrollController.addListener(() {
      if (scrollController.offset >= 20.h) {
        if (isScrollAtTop) {
          setState(() => isScrollAtTop = false);
        }
      } else {
        if (!isScrollAtTop) {
          setState(() => isScrollAtTop = true);
        }
      }
    });
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: subjectsList,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Column(
              children: [
                Expanded(
                  child: CustomScrollView(
                    controller: scrollController,
                    slivers: [
                      SliverAppBar(
                        flexibleSpace: ZnoTopHeaderText(
                          text: 'Оберіть предмет зі списку, щоб пройти тест',
                          isSettingsVisible: isScrollAtTop,
                        ),
                        expandedHeight: 250.h,
                        backgroundColor: const Color(0xFFF5F5F5),
                      ),
                      ZnoList(
                          list: snapshot.data!.map((String subject) {
                        return Tuple2(
                            PersonalConfigData.getSubjectFullName(subject),
                            () => context.go(Routes.sessionsRoute,
                                extra: SessionsRouteData(
                                    subjectName:
                                        PersonalConfigData.allSubjects[subject],
                                    folderName: subject)));
                      }).toList())
                    ],
                  ),
                ),
                const ZnoBottomNavigationBar(activeIndex: 0)
              ],
            );
          } else if (snapshot.hasError) {
            return const Text('Error');
          } else {
            return Text('Loading');
          }
        },
      ),
    );
  }
}
