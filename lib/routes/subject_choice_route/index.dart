import 'package:client/routes/subject_choice_route/subject_choice_layout.dart';
import 'package:client/providers/subject_choice_route_provider.dart';
import 'package:client/widgets/hexagon_dots/hexagon_dots_loading.dart';
import 'package:client/widgets/zno_error.dart';
import 'package:flutter/material.dart';
import '../../models/subject_choice_route_model.dart';

class SubjectChoiceRoute extends StatefulWidget {
  const SubjectChoiceRoute({super.key});

  @override
  State<SubjectChoiceRoute> createState() => _SubjectChoiceRouteState();
}

class _SubjectChoiceRouteState extends State<SubjectChoiceRoute> {
  late final Future<SubjectChoiceRouteModel> futureData;

  @override
  void initState() {
    super.initState();
    futureData = SubjectChoiceRouteModel.pullSubjectsFromConfig();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        body: FutureBuilder(
          future: futureData,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return SubjectChoiceRouteProvider(
                data: snapshot.data!,
                child: const SubjectChoiceLayout(),
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
