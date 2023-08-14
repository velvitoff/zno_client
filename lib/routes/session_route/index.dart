import 'package:client/dto/session_data.dart';
import 'package:client/dto/sessions_route_data.dart';
import 'package:client/routes.dart';
import 'package:client/routes/session_route/session_display.dart';
import 'package:client/routes/session_route/session_route_provider.dart';
import 'package:client/widgets/zno_icon_button.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../widgets/zno_bottom_navigation_bar.dart';
import '../../widgets/zno_top_header_text.dart';

class SessionRoute extends StatelessWidget {
  final SessionData dto;

  const SessionRoute({Key? key, required this.dto}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SessionRouteProvider(
      sessionData: dto,
      child: Column(
        children: [
          ZnoTopHeaderText(
              text: dto.subjectName,
              topLeftWidget: ZnoIconButton(
                icon: Icons.arrow_back,
                onTap: () => context.go(Routes.sessionsRoute,
                    extra: SessionsRouteData(
                        subjectName: dto.subjectName,
                        folderName: dto.folderName)),
              )),
          const Expanded(
            child: Center(
              child: SessionDisplay(),
            ),
          ),
          const ZnoBottomNavigationBar(activeIndex: 0),
        ],
      ),
    ));
  }
}
