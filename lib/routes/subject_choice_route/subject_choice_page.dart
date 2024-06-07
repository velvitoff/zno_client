import 'package:client/routes/subject_choice_route/state/subject_choice_route_state_model.dart';
import 'package:client/routes/subject_choice_route/widgets/subject_choice_header.dart';
import 'package:client/routes/subject_choice_route/widgets/subject_choice_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:client/widgets/hexagon_dots/hexagon_dots_loading.dart';
import 'package:client/widgets/zno_error.dart';

class SubjectChoicePage extends StatelessWidget {
  const SubjectChoicePage({super.key});

  void _onPop(BuildContext context, bool didPop) {
    if (!didPop) return;
    context.read<SubjectChoiceRouteStateModel>().onPop();
  }

  @override
  Widget build(BuildContext context) {
    final futureData =
        context.watch<SubjectChoiceRouteStateModel>().subjectsFuture;

    return PopScope(
      onPopInvoked: (didPop) => _onPop(context, didPop),
      child: Scaffold(
        body: FutureBuilder(
          future: futureData,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return const Column(
                children: [
                  SubjectChoiceHeader(),
                  Expanded(
                    child: SubjectChoiceList(),
                  ),
                ],
              );
            } else if (snapshot.hasError) {
              return const ZnoError(text: 'Помилка зчитування даних');
            } else {
              return Center(
                child: HexagonDotsLoading.def(),
              );
            }
          },
        ),
      ),
    );
  }
}
