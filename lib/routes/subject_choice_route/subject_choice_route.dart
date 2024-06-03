import 'package:client/routes/subject_choice_route/widgets/subject_choice_header.dart';
import 'package:client/routes/subject_choice_route/state/subject_choice_route_provider.dart';
import 'package:client/routes/subject_choice_route/widgets/subject_choice_list.dart';
import 'package:client/widgets/hexagon_dots/hexagon_dots_loading.dart';
import 'package:client/widgets/zno_error.dart';
import 'package:flutter/material.dart';
import 'state/subject_choice_route_state_model.dart';

class SubjectChoiceRoute extends StatefulWidget {
  const SubjectChoiceRoute({super.key});

  @override
  State<SubjectChoiceRoute> createState() => _SubjectChoiceRouteState();
}

class _SubjectChoiceRouteState extends State<SubjectChoiceRoute> {
  late final Future<SubjectChoiceRouteStateModel> futureData;

  @override
  void initState() {
    super.initState();
    futureData = SubjectChoiceRouteStateModel.pullSubjectsFromConfig();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: futureData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return SubjectChoiceRouteProvider(
              data: snapshot.data!,
              child: const Column(
                children: [
                  SubjectChoiceHeader(),
                  Expanded(
                    child: SubjectChoiceList(),
                  ),
                ],
              ),
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
    );
  }
}
