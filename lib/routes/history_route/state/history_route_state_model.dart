import 'package:flutter/material.dart';
import '../../../models/previous_attempt_model.dart';

class HistoryRouteStateModel extends ChangeNotifier {
  List<PreviousAttemptModel> sessionsList;

  HistoryRouteStateModel({required this.sessionsList});
}
