import 'package:client/all_subjects/zno_subject.dart';
import 'package:client/all_subjects/zno_subject_group.dart';
import 'package:client/all_subjects/zno_subject_interface.dart';
import 'package:client/dto/personal_config_data.dart';
import 'package:client/locator.dart';
import 'package:client/routes.dart';
import 'package:client/services/storage_service/personal_config_service.dart';
import 'package:client/widgets/zno_bottom_navigation_bar.dart';
import 'package:client/widgets/zno_button.dart';
import 'package:client/widgets/zno_list.dart';
import 'package:client/widgets/zno_loading.dart';
import 'package:client/widgets/zno_top_header_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../all_subjects/all_subjects.dart';
import '../../dto/sessions_route_data.dart';
import '../../dto/subjects_route_data.dart';
import '../../widgets/zno_error.dart';

bool globalHasAskedForPermissions = false;

class SubjectsRoute extends StatefulWidget {
  final SubjectsRouteData? dto;

  const SubjectsRoute({super.key, this.dto});

  @override
  State<SubjectsRoute> createState() => _SubjectsRouteState();
}

class _SubjectsRouteState extends State<SubjectsRoute> {
  late final Future<(PersonalConfigData, List<ZnoSubjectInterface>)> futureData;

  @override
  void initState() {
    super.initState();

    //init Future data
    futureData = locator
        .isReady<PersonalConfigService>()
        .then(
            (_) => locator.get<PersonalConfigService>().getPersonalConfigData())
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
  Widget build(BuildContext context) {
    final double topPadding = MediaQuery.of(context).padding.top;
    return Scaffold(
      bottomNavigationBar: const ZnoBottomNavigationBar(
          activeRoute: ZnoBottomNavigationEnum.subjects),
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
                      listToShow.isEmpty
                          ? SliverToBoxAdapter(
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: 50.h,
                                  ),
                                  Text(
                                    'Наразі у списку немає предметів',
                                    style: TextStyle(fontSize: 22.sp),
                                  ),
                                  SizedBox(
                                    height: 30.h,
                                  ),
                                  ZnoButton(
                                      width: 260.w,
                                      height: 60.h,
                                      text: 'Обрати предмети',
                                      onTap: () =>
                                          context.go(Routes.subjectChoiceRoute),
                                      fontSize: 22.sp)
                                ],
                              ),
                            )
                          : ZnoList(
                              list:
                                  listToShow.map((ZnoSubjectInterface subject) {
                              return (
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
                                                .where((e) =>
                                                    (snapshot.data!.$1)
                                                        .selectedSubjects
                                                        .contains(e.getId))
                                                .toList()))
                              );
                            }).toList())
                    ],
                  ),
                ),
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
