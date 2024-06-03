import 'package:client/models/exam_file_adress_model.dart';
import 'package:client/routes/sessions_route/state/sessions_route_input_data.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SessionsRouteStateModel extends ChangeNotifier {
  final SessionsRouteInputData inputData;
  final Future<List<MapEntry<String, List<ExamFileAddressModel>>>> futureList;

  SessionsRouteStateModel({
    required this.inputData,
    required this.futureList,
  });

  void onBack(BuildContext context) {
    if (!context.canPop()) return;
    context.pop();
  }
}
