import 'package:client/models/personal_config_model.dart';
import 'package:client/locator.dart';
import 'package:client/routes/subjects_route/state/subjects_route_input_data.dart';
import 'package:client/routes/subjects_route/widgets/subjects_scroll_view.dart';
import 'package:client/services/storage_service.dart';
import 'package:client/widgets/hexagon_dots/hexagon_dots_loading.dart';
import 'package:client/widgets/zno_bottom_navigation_bar.dart';
import 'package:client/widgets/zno_error.dart';
import 'package:flutter/material.dart';

class SubjectsRoute extends StatefulWidget {
  // Is null on the main page
  // Is not null if someone opened a group of subjects
  final SubjectsRouteInputData? dto;

  const SubjectsRoute({super.key, this.dto});

  @override
  State<SubjectsRoute> createState() => _SubjectsRouteState();
}

class _SubjectsRouteState extends State<SubjectsRoute> {
  late final Future<PersonalConfigModel> futureConfig;

  @override
  void initState() {
    super.initState();

    futureConfig = locator
        .isReady<StorageService>()
        .then((_) => locator.get<StorageService>().getPersonalConfigModel());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: const ZnoBottomNavigationBar(
        activeRoute: ZnoBottomNavigationEnum.subjects,
      ),
      body: FutureBuilder(
        future: futureConfig,
        builder: (
          BuildContext context,
          AsyncSnapshot<PersonalConfigModel> snapshot,
        ) {
          if (snapshot.hasData) {
            final listToShow = widget.dto?.subjectsList ??
                snapshot.data!.selectedSubjectsAsZnoInterfaces;
            return SubjectsScrollView(
              list: listToShow,
              shouldHaveBackArrow: widget.dto != null,
            );
          } else if (snapshot.hasError) {
            return const ZnoError(text: 'Помилка завантаження даних');
          } else {
            return Center(
              child: HexagonDotsLoading.def(),
            );
          }
        },
      ),
    );
  }
}
