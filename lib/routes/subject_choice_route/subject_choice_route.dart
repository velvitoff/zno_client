import 'package:client/routes/subject_choice_route/subject_choice_page.dart';
import 'package:client/widgets/hexagon_dots/hexagon_dots_loading.dart';
import 'package:client/widgets/zno_error.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'state/subject_choice_route_state_model.dart';

class SubjectChoiceRoute extends StatefulWidget {
  const SubjectChoiceRoute({super.key});

  @override
  State<SubjectChoiceRoute> createState() => _SubjectChoiceRouteState();
}

class _SubjectChoiceRouteState extends State<SubjectChoiceRoute> {
  late final Future<Map<String, bool>> futureData;

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
            return ChangeNotifierProvider(
              create: (context) =>
                  SubjectChoiceRouteStateModel(subjects: snapshot.data!),
              child: const SubjectChoicePage(),
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
