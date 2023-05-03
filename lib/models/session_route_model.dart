import 'package:client/dto/session_data.dart';
import 'package:flutter/material.dart';

class SessionRouteModel extends ChangeNotifier {
  final SessionData sessionData;

  SessionRouteModel({
    required this.sessionData
  });
}