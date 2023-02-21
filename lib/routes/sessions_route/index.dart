import 'package:client/dto/sessions_route_data.dart';
import 'package:client/routes/sessions_route/sessions_list.dart';
import 'package:client/widgets/zno_bottom_navigation_bar.dart';
import 'package:client/widgets/zno_top_header_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../locator.dart';
import '../../services/interfaces/storage_service.dart';

//TODO: optimize stateful widget re-renders
class SessionsRoute extends StatefulWidget {
  final SessionsRouteData dto;

  const SessionsRoute({
    Key? key,
    required this.dto
  }) : super(key: key);

  @override
  _SessionsRouteState createState() => _SessionsRouteState();
}

class _SessionsRouteState extends State<SessionsRoute> {

  late final Future<List<String>> futureList;

  @override
  void initState(){
    super.initState();
    futureList = locator.get<StorageService>()
        .listSessions(widget.dto.folderName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder(
              future: futureList,
              builder: (BuildContext context, AsyncSnapshot<List<String>> snapshot) {
                if (snapshot.hasData) {
                  return CustomScrollView(
                    slivers: [
                      SliverAppBar(
                        flexibleSpace: ZnoTopHeaderText(text: widget.dto.subjectName),
                        backgroundColor: const Color(0xFFF5F5F5),
                        expandedHeight: 250.h,
                        collapsedHeight: 70.h,
                        pinned: true,
                        shadowColor: const Color(0x00000000),//no shadow
                      ),
                      SessionsList(
                          subjectName: widget.dto.subjectName,
                          folderName: widget.dto.folderName,
                          data: snapshot.data!
                      )
                    ],
                  );
                }
                else if (snapshot.hasError) {
                  return Column(
                    children: [
                      ZnoTopHeaderText(text: widget.dto.subjectName),
                      const Text('error')
                    ],
                  );
                }
                else {
                  return Column(
                    children: [
                      ZnoTopHeaderText(text: widget.dto.subjectName),
                      const Text('loading')
                    ],
                  );
                }
              },
            ),
          ),
          const ZnoBottomNavigationBar(activeIndex: 0)
        ],
      ),
    );
  }
}
