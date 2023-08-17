import 'package:client/all_subjects/zno_subject.dart';
import 'package:client/all_subjects/zno_subject_group.dart';
import 'package:client/all_subjects/zno_subject_interface.dart';
import 'package:client/dto/personal_config_data.dart';
import 'package:client/locator.dart';
import 'package:client/routes.dart';
import 'package:client/services/interfaces/storage_service_interface.dart';
import 'package:client/widgets/zno_bottom_navigation_bar.dart';
import 'package:client/widgets/zno_icon_button.dart';
import 'package:client/widgets/zno_list.dart';
import 'package:client/widgets/zno_loading.dart';
import 'package:client/widgets/zno_top_header_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:tuple/tuple.dart';

import '../../all_subjects/all_subjects.dart';
import '../../dto/sessions_route_data.dart';
import '../../dto/subjects_route_data.dart';
import '../../widgets/zno_error.dart';

class SubjectsRoute extends StatefulWidget {
  final SubjectsRouteData? dto;

  const SubjectsRoute({super.key, this.dto});

  @override
  State<SubjectsRoute> createState() => _SubjectsRouteState();
}

class _SubjectsRouteState extends State<SubjectsRoute> {
  late final Future<(PersonalConfigData, List<ZnoSubjectInterface>)> futureData;
  late final ScrollController scrollController;
  bool isScrollAtTop = true;

  @override
  void initState() {
    super.initState();

    //init scrollController
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

    //init Future data
    futureData = locator
        .allReady()
        .then((_) =>
            locator.get<StorageServiceInterface>().getPersonalConfigData())
        .then((config) {
      if (widget.dto != null) {
        return Future.value((config, List<ZnoSubjectInterface>.empty()));
      } else {
        //if no subjectsList provided by arguments(props), then fetch it from personal config
        List<ZnoSubjectInterface> result = [];
        for (final selectedSubject in config.selectedSubjects) {
          for (final subject in allSubjects) {
            //add subject if it's contained in the list of all subjects
            if (subject is ZnoSubject && subject.getId == selectedSubject) {
              result.add(subject);
              break;
              //add a group if a subject is a part of a group
            } else if (subject is ZnoSubjectGroup) {
              for (final childSubject in subject.children) {
                if (childSubject.getId == selectedSubject &&
                    !result.contains(subject)) {
                  result.add(subject);
                }
              }
            }
          }
        }

        //edit result
        if (result.length == 1 && result[0] is ZnoSubjectGroup) {
          final group = result[0];
          result = [];
          result.addAll(group
              .getChildren()
              .where((e) => config.selectedSubjects.contains(e.getId))
              .toList());
        }
        return Future.value((config, result));
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
        future: futureData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final listToShow = widget.dto == null
                ? snapshot.data!.$2
                : widget.dto!.subjectsList;
            return Column(
              children: [
                Expanded(
                  child: CustomScrollView(
                    controller: scrollController,
                    slivers: [
                      SliverAppBar(
                        flexibleSpace: ZnoTopHeaderText(
                          text: 'Оберіть предмет зі списку, щоб пройти тест',
                          topRightWidget: isScrollAtTop
                              ? ZnoIconButton(
                                  icon: Icons.format_list_bulleted,
                                  onTap: () =>
                                      context.go(Routes.subjectChoiceRoute),
                                )
                              : Container(),
                        ),
                        expandedHeight: 250.h,
                        backgroundColor: const Color(0xFFF5F5F5),
                      ),
                      ZnoList(
                          list: listToShow.map((ZnoSubjectInterface subject) {
                        return Tuple2(
                            subject.getName,
                            subject.getChildren().isEmpty
                                ? () => context.go(Routes.sessionsRoute,
                                    extra: SessionsRouteData(
                                        subjectName: subject.getName,
                                        folderName: subject.getId))
                                : () => context.go(Routes.subjectsRoute,
                                    extra: SubjectsRouteData(
                                        subjectsList: subject
                                            .getChildren()
                                            .where((e) => (snapshot.data!.$1)
                                                .selectedSubjects
                                                .contains(e.getId))
                                            .toList())));
                      }).toList())
                    ],
                  ),
                ),
                const ZnoBottomNavigationBar(activeIndex: 0)
              ],
            );
          } else if (snapshot.hasError) {
            return const ZnoError(text: 'Помилка завантаження даних');
          } else {
            return const Center(
              child: FractionallySizedBox(
                widthFactor: 0.6,
                heightFactor: 0.6,
                child: ZnoLoading(),
              ),
            );
          }
        },
      ),
    );
  }
}
