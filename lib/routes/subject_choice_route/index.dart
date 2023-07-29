import 'package:client/dto/personal_config_data.dart';
import 'package:client/locator.dart';
import 'package:client/routes.dart';
import 'package:client/routes/subject_choice_route/subject_choice_route_provider.dart';
import 'package:client/services/interfaces/storage_service_interface.dart';
import 'package:client/widgets/zno_bottom_navigation_bar.dart';
import 'package:client/widgets/zno_top_header_small.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

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
      body: Column(
        children: [
          ZnoTopHeaderSmall(
            backgroundColor: const Color(0xFFF5F5F5),
            child: Container(
              margin: EdgeInsets.fromLTRB(7.w, 0, 0, 0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: GestureDetector(
                  onTap: () => context.go(Routes.subjectsRoute),
                  child: Icon(
                    Icons.arrow_back,
                    size: 45.sp,
                    color: const Color(0xFFF5F5F5),
                  ),
                ),
              ),
            ),
          ),
          Expanded(
              child: FutureBuilder(
            future: futureData,
            builder: ((context, snapshot) {
              if (snapshot.hasData) {
                return SubjectChoiceRouteProvider(
                  data: snapshot.data!,
                  child: Text("data"),
                );
              } else if (snapshot.hasError) {
                return const Text("error");
              } else {
                return const Text("Loading");
              }
            }),
          )),
          const ZnoBottomNavigationBar(activeIndex: 0)
        ],
      ),
    );
  }
}
