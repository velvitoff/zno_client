import 'package:client/locator.dart';
import 'package:client/models/questions/question.dart';
import 'package:client/routes/testing_route/state/testing_route_state_model.dart';
import 'package:client/routes/testing_route/state/testing_time_state_model.dart';
import 'package:client/routes/testing_route/widgets/testing_page/answer_widget.dart';
import 'package:client/routes/testing_route/widgets/testing_page/question_widget.dart';
import 'package:client/routes/testing_route/widgets/testing_page/testing_buttons.dart';
import 'package:client/routes/testing_route/widgets/testing_page/testing_page_timer.dart';
import 'package:client/services/dialog_service.dart';
import 'package:client/services/storage_service.dart';
import 'package:client/routes/testing_route/widgets/zno_divider.dart';
import 'package:client/routes/testing_route/widgets/zno_divider_for_review.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class TestingPage extends StatefulWidget {
  final int index;
  final Question question;
  final int questionsLength;

  const TestingPage({
    Key? key,
    required this.index,
    required this.question,
    required this.questionsLength,
  }) : super(key: key);

  @override
  State<TestingPage> createState() => _TestingPageState();
}

class _TestingPageState extends State<TestingPage> {
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      controller: _scrollController,
      child: ConstrainedBox(
        constraints: BoxConstraints(
          minHeight: 700.h - MediaQuery.of(context).padding.top,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _TestingAreaHeader(
              activeIndex: widget.index,
              questionsLength: widget.questionsLength,
            ),
            QuestionWidget(
              index: widget.index,
              question: widget.question,
            ),
            _TestingAreaFooter(
              activeIndex: widget.index,
              questionsLength: widget.questionsLength,
              question: widget.question,
            ),
          ],
        ),
      ),
    );
  }
}

class _TestingAreaHeader extends StatelessWidget {
  final int activeIndex;
  final int questionsLength;

  const _TestingAreaHeader({
    required this.activeIndex,
    required this.questionsLength,
  });

  @override
  Widget build(BuildContext context) {
    final isViewMode = context.read<TestingRouteStateModel>().isViewMode;
    final isTimerActivated = context
        .select<TestingTimeStateModel, bool>((value) => value.isTimerActivated);

    return Column(
      children: [
        isViewMode
            ? ZnoDividerForReview(
                activeIndex: activeIndex,
                itemCount: questionsLength,
              )
            : ZnoDivider(
                activeIndex: activeIndex,
                itemCount: questionsLength,
              ),
        isTimerActivated ? const TestingPageTimer() : Container(),
      ],
    );
  }
}

class _TestingAreaFooter extends StatelessWidget {
  final int activeIndex;
  final int questionsLength;
  final Question question;

  const _TestingAreaFooter({
    required this.activeIndex,
    required this.questionsLength,
    required this.question,
  });

  Future<void> _onEndSession(BuildContext context) async {
    final testingRouteStateModel = context.read<TestingRouteStateModel>();
    final testingTimeStateModel = context.read<TestingTimeStateModel>();
    final bool isViewMode = testingRouteStateModel.isViewMode;

    bool confirm = await locator.get<DialogService>().showConfirmDialog(
          context,
          isViewMode ? 'Завершити перегляд?' : 'Завершити спробу?',
        );

    if (!confirm) return;

    if (isViewMode) {
      if (!context.mounted) return;
      if (!context.canPop()) return;
      context.pop(false);
      return;
    }

    await locator.get<StorageService>().saveSessionEnd(
          testingRouteStateModel,
          testingTimeStateModel,
          true,
        );

    if (!context.mounted) return;
    if (!context.canPop()) return;
    context.pop(true);
  }

  void _onBack(BuildContext context) {
    context.read<TestingRouteStateModel>().decrementPage();
  }

  void _onForward(BuildContext context) {
    if (activeIndex == questionsLength - 1) {
      _onEndSession(context);
    } else {
      context.read<TestingRouteStateModel>().incrementPage();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(20.w, 0, 20.w, 0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          AnswerWidget(
            index: activeIndex,
            question: question,
          ),
          TestingButtons(
            onBack: () => _onBack(context),
            onForward: () => _onForward(context),
            isFirstPage: activeIndex == 0,
            isLastPage: activeIndex == questionsLength - 1,
          )
        ],
      ),
    );
  }
}
