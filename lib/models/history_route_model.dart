import 'package:flutter/material.dart';
import '../dto/previous_session_data.dart';

class HistoryRouteModel extends ChangeNotifier {
  List<PreviousSessionData> sessionsList;

  HistoryRouteModel({required this.sessionsList});
}
