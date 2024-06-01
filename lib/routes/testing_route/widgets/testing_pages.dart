import 'package:client/locator.dart';
import 'package:client/routes/testing_route/state/testing_route_state_model.dart';
import 'package:client/routes/testing_route/state/testing_time_state_model.dart';
import 'package:client/routes/testing_route/widgets/testing_page/testing_page.dart';
import 'package:client/services/storage_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../models/questions/question.dart';

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
      _handleOnPause();
    }
  }

  void _handleOnPause() {
    //should be saveSessionEndSync for correct behaviour in case of detached event
    final testingRouteModel = context.read<TestingRouteStateModel>();
    if (testingRouteModel.isViewMode) return;

    final data = locator.get<StorageService>().saveSessionEndSync(
        testingRouteModel,
        context.read<TestingTimeStateModel>(),
        testingRouteModel.prevSessionData?.completed ?? false);
    context.read<TestingRouteStateModel>().prevSessionData = data;
  }

  @override
  Widget build(BuildContext context) {
    return Selector<TestingRouteStateModel, PageController>(
      selector: (_, model) => model.pageController,
      builder: (_, pageController, __) {
        return PageView.builder(
          physics: const NeverScrollableScrollPhysics(),
          controller: pageController,
          scrollDirection: Axis.vertical,
          itemCount: widget.questions.length,
          itemBuilder: (context, position) {
            return TestingPage(
              index: position,
              question: widget.questions[position],
              questionsLength: widget.questions.length,
            );
          },
        );
      },
    );
  }
}
