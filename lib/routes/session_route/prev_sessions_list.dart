import 'package:client/models/previous_attempt_model.dart';
import 'package:client/locator.dart';
import 'package:client/services/storage_service/main_storage_service.dart';
import 'package:client/widgets/hexagon_dots/hexagon_dots_loading.dart';
import 'package:client/widgets/prev_session_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../widgets/zno_error.dart';

class PrevSessionsList extends StatefulWidget {
  final String subjectName;
  final String sessionName;

  const PrevSessionsList(
      {Key? key, required this.subjectName, required this.sessionName})
      : super(key: key);

  @override
  State<PrevSessionsList> createState() => _PastSessionsListState();
}

class _PastSessionsListState extends State<PrevSessionsList> {
  late final Future<List<PreviousAttemptModel>> dataList;

  @override
  void initState() {
    super.initState();
    dataList = locator
        .get<MainStorageService>()
        .getPreviousSessionsList(widget.subjectName, widget.sessionName);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 320.w,
      height: 300.h,
      child: Center(
        child: FutureBuilder(
          future: dataList,
          builder: (BuildContext context,
              AsyncSnapshot<List<PreviousAttemptModel>> snapshot) {
            if (snapshot.hasError) {
              return const ZnoError(
                text: 'Помилка завантаження попередніх спроб',
                textColor: Color.fromARGB(255, 58, 58, 58),
              );
            }
            if (snapshot.hasData) {
              if (snapshot.data!.isEmpty) {
                return Text('Немає попередніх спроб',
                    style: TextStyle(
                        color: const Color(0xFF5F5F5F),
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w400));
              }

              List<PreviousAttemptModel> sessionsList =
                  List.from(snapshot.data!);
              sessionsList.sort((a, b) => b.date.compareTo(a.date));
              return Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Flexible(
                    flex: 4,
                    child: Text('Попередні спроби',
                        style: TextStyle(
                            color: const Color(0xFF5F5F5F),
                            fontSize: 20.sp,
                            fontWeight: FontWeight.w400)),
                  ),
                  const Spacer(flex: 1),
                  Flexible(
                    flex: 20,
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                          color: const Color(0xFFFAFAFA),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(5)),
                          border: Border.all(
                              color: const Color(0xFF787878).withOpacity(0.3))),
                      child: ListView(
                        padding: EdgeInsets.only(top: 12.h),
                        children: sessionsList.map((item) {
                          return PrevSessionItem(
                            data: item,
                          );
                        }).toList(),
                      ),
                    ),
                  )
                ],
              );
            } else {
              return Center(
                child: HexagonDotsLoading.def(),
              );
            }
          },
        ),
      ),
    );
  }
}
