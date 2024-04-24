import 'package:client/locator.dart';
import 'package:client/state_models/testing_route_state_model.dart';
import 'package:client/state_models/testing_time_state_model.dart';
import 'package:client/routes/testing_route/testing_page/testing_page.dart';
import 'package:client/services/storage_service/main_storage_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../dto/questions/question.dart';

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
  Future<void> didChangeAppLifecycleState(AppLifecycleState state) async {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.inactive ||
        state == AppLifecycleState.detached) {
      return;
    }
    if (state == AppLifecycleState.paused) {
      handleOnPause();
    }
  }

  void handleOnPause() {
    //should be saveSessionEndSync for correct behaviour in case of detached event
    final testingRouteModel = context.read<TestingRouteStateModel>();
    if (testingRouteModel.isViewMode) return;

    final data = locator.get<MainStorageService>().saveSessionEndSync(
        testingRouteModel,
        context.read<TestingTimeStateModel>(),
        testingRouteModel.prevSessionData?.completed ?? false);
    context.read<TestingRouteStateModel>().prevSessionData = data;
  }

  @override
  Widget build(BuildContext context) {
    return Selector<TestingRouteStateModel, (PageController, List<Question>)>(
      selector: (_, model) => (model.pageController, model.questions),
      builder: (_, data, __) {
        return PageView.builder(
          physics: const NeverScrollableScrollPhysics(),
          controller: data.$1,
          scrollDirection: Axis.vertical,
          itemCount: data.$2.length,
          itemBuilder: (context, position) {
            return TestingPage(
                index: position,
                question: data.$2[position],
                questionsLength: data.$2.length);
          },
        );
      },
    );
  }
}
