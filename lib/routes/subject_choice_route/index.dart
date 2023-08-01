import 'package:client/routes/subject_choice_route/subject_choice_header.dart';
import 'package:client/routes/subject_choice_route/subject_choice_list.dart';
import 'package:client/routes/subject_choice_route/subject_choice_route_provider.dart';
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
    return Scaffold(
      body: FutureBuilder(
        future: futureData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return SubjectChoiceRouteProvider(
              data: snapshot.data!,
              child: Column(
                children: const [
                  SubjectChoiceHeader(),
                  Expanded(child: SubjectChoiceList())
                ],
              ),
            );
          } else if (snapshot.hasError) {
            return const Text("error");
          } else {
            return const Text("Loading");
          }
        },
      ),
    );
  }
}
