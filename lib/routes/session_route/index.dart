import 'package:client/dto/session_data.dart';
import 'package:client/routes/session_route/session_display.dart';
import 'package:client/widgets/zno_bottom_navigation_bar.dart';
import 'package:client/widgets/zno_top_header_text.dart';
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
      body: Column(
        children: [
          ZnoTopHeaderText(text: dto.subjectName),
          Expanded(
            child: Center(
              child: SessionDisplay(
                dto: dto,
              ),
            ),
          ),
          const ZnoBottomNavigationBar(activeIndex: 0),
        ],
      )
    );
  }
}
