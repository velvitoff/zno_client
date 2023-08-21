import 'package:client/locator.dart';
import 'package:client/models/testing_route_model.dart';
import 'package:client/models/testing_time_model.dart';
import 'package:client/routes/testing_route/index.dart';
import 'package:client/routes/testing_route/testing_page/testing_page.dart';
import 'package:client/services/interfaces/storage_service_interface.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tuple/tuple.dart';
import '../../dto/previous_session_data.dart';
import '../../dto/question_data.dart';

class TestingPages extends StatefulWidget {
  final List<Question> questions;
  const TestingPages({super.key, required this.questions});

  @override
  State<TestingPages> createState() => _TestingPagesState();
}

class _TestingPagesState extends State<TestingPages>
    with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  //Saving test attempt if user pauses/closes the app
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);

    if (state == AppLifecycleState.inactive ||
        state == AppLifecycleState.detached) {
      return;
    }
    if (state == AppLifecycleState.paused) {
      final testingRouteModel = context.read<TestingRouteModel>();
      locator
          .get<StorageServiceInterface>()
          .saveSessionEnd(
              testingRouteModel,
              context.read<TestingTimeModel>(),
              testingRouteModel.prevSessionData == null
                  ? false
                  : testingRouteModel.prevSessionData!.completed)
          .then((PreviousSessionData? data) {
        if (data != null) {
          context.read<TestingRouteModel>().prevSessionData = data;
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Selector<TestingRouteModel, Tuple2<PageController, List<Question>>>(
      selector: (_, model) => Tuple2(model.pageController, model.questions),
      builder: (_, data, __) {
        return PageView.builder(
          physics: const NeverScrollableScrollPhysics(),
          controller: data.item1,
          scrollDirection: Axis.vertical,
          itemCount: data.item2.length,
          itemBuilder: (context, position) {
            return TestingPage(
                index: position,
                question: data.item2[position],
                questionsLength: data.item2.length);
          },
        );
      },
    );
  }
}
