import 'package:client/dto/session_data.dart';
import 'package:client/routes/session_route/session_route_provider.dart';
import 'package:flutter/material.dart';

class SessionRoute extends StatelessWidget {
  final SessionData dto;

  const SessionRoute({
    Key? key,
    required this.dto
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SessionRouteProvider(
        sessionData: dto,
      )
    );
  }
}
