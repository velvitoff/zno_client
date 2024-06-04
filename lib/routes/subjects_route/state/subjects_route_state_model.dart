import 'package:client/all_subjects/zno_subject_interface.dart';
import 'package:client/locator.dart';
import 'package:client/models/personal_config_model.dart';
import 'package:client/routes.dart';
import 'package:client/routes/sessions_route/state/sessions_route_input_data.dart';
import 'package:client/routes/subjects_route/state/subjects_route_input_data.dart';
import 'package:client/services/storage_service.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SubjectsRouteStateModel extends ChangeNotifier {
  final SubjectsRouteInputData? input;
  late Future<PersonalConfigModel> futureConfig;

  SubjectsRouteStateModel({
    required this.input,
  }) {
    _updateFutureConfig();
  }

  Future<void> onTapSelectNewSubjects(BuildContext context) async {
    await context.push(Routes.subjectChoiceRoute);
    _updateFutureConfig(notify: true);
  }

  Future<void> onTapOpenSingleSubject(
    BuildContext context,
    ZnoSubjectInterface subject,
  ) async {
    if (subject.getChildren().isEmpty) {
      context.push(
        Routes.sessionsRoute,
        extra: SessionsRouteInputData(
          subjectName: subject.getName,
          folderName: subject.getId,
        ),
      );
      return;
    }

    final config = await futureConfig;
    if (!context.mounted) return;

    context.push(
      Routes.subjectsRoute,
      extra: SubjectsRouteInputData(
        subjectsList: subject
            .getChildren()
            .where((e) => config.selectedSubjects.contains(e.getId))
            .toList(),
      ),
    );
  }

  void _updateFutureConfig({bool notify = false}) {
    futureConfig = locator
        .isReady<StorageService>()
        .then((_) => locator.get<StorageService>().getPersonalConfigModel());
    if (!notify) return;
    notifyListeners();
  }
}
