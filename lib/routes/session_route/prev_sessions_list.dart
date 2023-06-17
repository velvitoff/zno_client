import 'package:client/dto/previous_session_data.dart';
import 'package:client/locator.dart';
import 'package:client/widgets/prev_session_item.dart';
import 'package:client/services/interfaces/storage_service_interface.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
  late final Future<List<PreviousSessionData>> dataList;

  @override
  void initState() {
    super.initState();
    dataList = locator
        .get<StorageServiceInterface>()
        .getPreviousSessionsList(widget.subjectName, widget.sessionName);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 320.w,
      height: 200.h,
      child: Center(
        child: FutureBuilder(
          future: dataList,
          builder: (BuildContext context,
              AsyncSnapshot<List<PreviousSessionData>> snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data!.isEmpty) {
                return Text('Немає попередніх спроб',
                    style: TextStyle(
                        color: const Color(0xFF5F5F5F),
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w400));
              }

              List<PreviousSessionData> sessionsList =
                  List.from(snapshot.data!);
              sessionsList.sort((a, b) => b.date.compareTo(a.date));
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Попередні спроби',
                      style: TextStyle(
                          color: const Color(0xFF5F5F5F),
                          fontSize: 20.sp,
                          fontWeight: FontWeight.w400)),
                  SizedBox(
                    height: 10.h,
                  ),
                  Container(
                    width: 320.w,
                    height: 165.h,
                    padding: EdgeInsets.fromLTRB(0, 7.5.h, 0, 7.5.h),
                    decoration: BoxDecoration(
                        color: const Color(0xFFFAFAFA),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(5)),
                        border: Border.all(
                            color: const Color(0xFF787878).withOpacity(0.3))),
                    child: ListView(
                      children: sessionsList.map((item) {
                        return PrevSessionItem(
                          data: item,
                        );
                      }).toList(),
                    ),
                  )
                ],
              );
            } else if (snapshot.hasError) {
              return Text('Помилка завантаження попередніх спроб',
                  style: TextStyle(
                      color: const Color(0xFF5F5F5F),
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w400));
            } else {
              return Text('Завантаження попередніх спроб...',
                  style: TextStyle(
                      color: const Color(0xFF5F5F5F),
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w400));
            }
          },
        ),
      ),
    );
  }
}
