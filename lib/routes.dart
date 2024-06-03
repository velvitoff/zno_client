import 'package:client/models/exam_file_adress_model.dart';
import 'package:client/routes/image_view_route/state/image_view_route_input_data.dart';
import 'package:client/routes/sessions_route/state/sessions_route_input_data.dart';
import 'package:client/routes/history_route/history_route.dart';
import 'package:client/routes/image_view_route/image_view_route.dart';
import 'package:client/routes/premium_route/premium_route.dart';
import 'package:client/routes/session_route/session_route.dart';
import 'package:client/routes/settings_route/settings_route.dart';
import 'package:client/routes/storage_route/storage_route.dart';
import 'package:client/routes/subject_choice_route/subject_choice_route.dart';
import 'package:client/routes/subjects_route/state/subjects_route_input_data.dart';
import 'package:client/routes/testing_route/testing_route.dart';
import 'package:client/routes/testing_route/state/testing_route_input_data.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:client/routes/subjects_route/subjects_route.dart';
import 'package:client/routes/sessions_route/sessions_route.dart';

class Routes {
  Routes._();

  static const subjectsRoute = '/';
  static const historyRoute = '/history';
  static const storageRoute = '/storage';
  static const sessionsRoute = '/sessions';
  static const sessionRoute = '/session';
  static const testingRoute = '/testing';
  static const imageViewRoute = '/image_view';
  static const subjectChoiceRoute = '/subject_choice';
  static const settingsRoute = '/settings';
  static const premiumRoute = '/premium';

  static GoRouter get router => _router;

  static final _router = GoRouter(
      debugLogDiagnostics: kDebugMode,
      initialLocation: subjectsRoute,
      routes: [
        GoRoute(
            path: subjectsRoute,
            pageBuilder: (context, state) {
              SubjectsRouteInputData? dto =
                  state.extra as SubjectsRouteInputData?;
              return CustomTransitionPage(
                  key: state.pageKey,
                  child: SubjectsRoute(
                    dto: dto,
                  ),
                  transitionDuration: const Duration(milliseconds: 250),
                  transitionsBuilder:
                      (context, animation, secondaryAnimation, child) {
                    return FadeTransition(
                      opacity: CurveTween(curve: Curves.easeInOutCirc)
                          .animate(animation),
                      child: child,
                    );
                  });
            }),
        GoRoute(
            path: historyRoute,
            pageBuilder: (context, state) {
              return CustomTransitionPage(
                  key: state.pageKey,
                  transitionDuration: const Duration(milliseconds: 250),
                  child: const HistoryRoute(),
                  transitionsBuilder:
                      (context, animation, secondaryAnimation, child) {
                    return FadeTransition(
                      opacity: CurveTween(curve: Curves.easeInOutCirc)
                          .animate(animation),
                      child: child,
                    );
                  });
            }),
        GoRoute(
            path: storageRoute,
            pageBuilder: (context, state) {
              return CustomTransitionPage(
                  key: state.pageKey,
                  transitionDuration: const Duration(milliseconds: 250),
                  child: const StorageRoute(),
                  transitionsBuilder:
                      (context, animation, secondaryAnimation, child) {
                    return FadeTransition(
                      opacity: CurveTween(curve: Curves.easeInOutCirc)
                          .animate(animation),
                      child: child,
                    );
                  });
            }),
        GoRoute(
            path: sessionsRoute,
            pageBuilder: (context, state) {
              SessionsRouteInputData dto =
                  state.extra as SessionsRouteInputData;
              return CustomTransitionPage(
                  key: state.pageKey,
                  transitionDuration: const Duration(milliseconds: 250),
                  child: SessionsRoute(dto: dto),
                  transitionsBuilder:
                      (context, animation, secondaryAnimation, child) {
                    return FadeTransition(
                      opacity: CurveTween(curve: Curves.easeInOutCirc)
                          .animate(animation),
                      child: child,
                    );
                  });
            }),
        GoRoute(
          path: sessionRoute,
          pageBuilder: (context, state) {
            ExamFileAddressModel dto = state.extra as ExamFileAddressModel;
            return CustomTransitionPage(
                key: state.pageKey,
                transitionDuration: const Duration(milliseconds: 250),
                child: SessionRoute(dto: dto),
                transitionsBuilder:
                    (context, animation, secondaryAnimation, child) {
                  return FadeTransition(
                    opacity: CurveTween(curve: Curves.easeInOutCirc)
                        .animate(animation),
                    child: child,
                  );
                });
          },
        ),
        GoRoute(
            path: testingRoute,
            pageBuilder: (context, state) {
              TestingRouteInputData dto = state.extra as TestingRouteInputData;
              return CustomTransitionPage(
                  key: state.pageKey,
                  transitionDuration: const Duration(milliseconds: 250),
                  child: TestingRoute(dto: dto),
                  transitionsBuilder:
                      (context, animation, secondaryAnimation, child) {
                    return FadeTransition(
                      opacity: CurveTween(curve: Curves.easeInOutCirc)
                          .animate(animation),
                      child: child,
                    );
                  });
            }),
        GoRoute(
            path: imageViewRoute,
            builder: (context, state) {
              ImageViewRouteInputData dto =
                  state.extra as ImageViewRouteInputData;
              return ImageViewRoute(dto: dto);
            }),
        GoRoute(
            path: subjectChoiceRoute,
            pageBuilder: (context, state) {
              return CustomTransitionPage(
                  key: state.pageKey,
                  transitionDuration: const Duration(milliseconds: 250),
                  child: const SubjectChoiceRoute(),
                  transitionsBuilder:
                      (context, animation, secondaryAnimation, child) {
                    return FadeTransition(
                      opacity: CurveTween(curve: Curves.easeInOutCirc)
                          .animate(animation),
                      child: child,
                    );
                  });
            }),
        GoRoute(
            path: settingsRoute,
            pageBuilder: (context, state) {
              return CustomTransitionPage(
                  key: state.pageKey,
                  transitionDuration: const Duration(milliseconds: 250),
                  child: const SettingsRoute(),
                  transitionsBuilder:
                      (context, animation, secondaryAnimation, child) {
                    return FadeTransition(
                      opacity: CurveTween(curve: Curves.easeInOutCirc)
                          .animate(animation),
                      child: child,
                    );
                  });
            }),
        GoRoute(
            path: premiumRoute,
            pageBuilder: (context, state) {
              return CustomTransitionPage(
                  key: state.pageKey,
                  transitionDuration: const Duration(milliseconds: 250),
                  child: const PremiumRoute(),
                  transitionsBuilder:
                      (context, animation, secondaryAnimation, child) {
                    return FadeTransition(
                      opacity: CurveTween(curve: Curves.easeInOutCirc)
                          .animate(animation),
                      child: child,
                    );
                  });
            })
      ]);
}
