import 'package:client/dto/image_view_route_data.dart';
import 'package:client/dto/sessions_route_data.dart';
import 'package:client/routes/history_route/index.dart';
import 'package:client/routes/image_view_route/index.dart';
import 'package:client/routes/session_route/index.dart';
import 'package:client/routes/storage_route/index.dart';
import 'package:client/routes/testing_route/index.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:client/routes/subjects_route/index.dart';
import 'package:client/routes/sessions_route/index.dart';

import 'dto/session_data.dart';
import 'dto/testing_route_data.dart';

class Routes {
  Routes._();

  static const subjectsRoute = '/';
  static const historyRoute = '/history';
  static const storageRoute = '/storage';
  static const sessionsRoute = '/sessions';
  static const sessionRoute = '/session';
  static const testingRoute = '/testing';
  static const imageViewRoute = '/image_view';

  static GoRouter get router => _router;

  static final _router = GoRouter(
      debugLogDiagnostics: kDebugMode,
      initialLocation: subjectsRoute,
      routes: [
        GoRoute(
            path: subjectsRoute,
            pageBuilder: (context, state) {
              return CustomTransitionPage(
                  key: state.pageKey,
                  child: const SubjectsRoute(),
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
              SessionsRouteData dto = state.extra as SessionsRouteData;
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
              SessionData dto = state.extra as SessionData;
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
            }),
        GoRoute(
            path: testingRoute,
            pageBuilder: (context, state) {
              TestingRouteData dto = state.extra as TestingRouteData;
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
              ImageViewRouteData dto = state.extra as ImageViewRouteData;
              return ImageViewRoute(dto: dto);
            })
      ]);
}
