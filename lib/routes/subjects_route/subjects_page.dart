import 'package:client/models/personal_config_model.dart';
import 'package:client/routes/subjects_route/state/subjects_route_state_model.dart';
import 'package:flutter/material.dart';
import 'package:client/routes/subjects_route/widgets/subjects_scroll_view.dart';
import 'package:client/widgets/hexagon_dots/hexagon_dots_loading.dart';
import 'package:client/widgets/zno_error.dart';
import 'package:provider/provider.dart';

class SubjectsPage extends StatelessWidget {
  const SubjectsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final model = context.watch<SubjectsRouteStateModel>();

    return FutureBuilder(
      future: model.futureConfig,
      builder: (
        BuildContext context,
        AsyncSnapshot<PersonalConfigModel> snapshot,
      ) {
        if (snapshot.hasData) {
          final listToShow = model.input?.subjectsList ??
              snapshot.data!.selectedSubjectsAsZnoInterfaces;
          return SubjectsScrollView(
            list: listToShow,
            shouldHaveBackArrow: model.input != null,
          );
        } else if (snapshot.hasError) {
          return const ZnoError(text: 'Помилка завантаження даних');
        } else {
          return Center(
            child: HexagonDotsLoading.def(),
          );
        }
      },
    );
  }
}
