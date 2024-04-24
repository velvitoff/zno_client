import 'package:flutter/material.dart';
import '../dto/previous_session_data.dart';

class HistoryRouteStateModel extends ChangeNotifier {
  List<PreviousSessionData> sessionsList;

  HistoryRouteStateModel({required this.sessionsList});
}
