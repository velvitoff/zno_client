import 'dart:convert';
import 'package:client/routes/testing_route/ui_creator/creators/image_creator.dart';
import 'package:client/routes/testing_route/ui_creator/creators/text_creator.dart';
import 'package:client/routes/testing_route/ui_creator/ui_creator.dart';
import 'package:client/routes/testing_route/ui_creator/widgets/horizontal_scroll_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TableCreator {
  final BuildContext context;
  final String data;
  final TextStyle? style;

  const TableCreator({
    required this.context,
    required this.data,
    this.style,
  });

  Widget create() {
    var tableMap = jsonDecode(data);
    var tableString = tableMap['data'] as String;
    String? tableType = tableMap['type'] as String?;

    final List<List<List<String>>> json = List<List<List<String>>>.from(
        jsonDecode(tableString).map((x) =>
            List<List<String>>.from(x.map((x) => List<String>.from(x)))));

    if (tableType == null) {
      return _textToTableDefaultStyle(json);
    }

    if (tableType == 'data_table') {
      return _textToTableDataStyle(json);
    }

    return Container();
  }

  Widget _textToTableDataStyle(List<List<List<String>>> data) {
    final List<DataColumn> columns = data[0]
        .map(
          (x) => DataColumn(
            label: UiCreator(
              data: x,
              allowRenderTables: false,
            ),
          ),
        )
        .toList();

    final List<DataRow> rows = data
        .sublist(1)
        .map((row) => DataRow(
            cells: row
                .map((cell) => DataCell(UiCreator(
                      data: cell,
                      allowRenderTables: false,
                    )))
                .toList()))
        .toList();

    return HorizontalScrollWrapper(
      child: DataTable(columns: columns, rows: rows),
    );
  }

  Widget _textToTableDefaultStyle(List<List<List<String>>> data) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: data
          .map(
            (row) => Container(
              width: 320.w,
              margin: EdgeInsets.fromLTRB(0, 5.h, 0, 5.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: row.map(
                  (data) {
                    if (data[0] == 'p') {
                      return _TextWrapped(text: data[1], style: style);
                    }
                    if (data[0] == 'img') {
                      return _ImageWrapped(fileName: data[1]);
                    } else {
                      return Container();
                    }
                  },
                ).toList(),
              ),
            ),
          )
          .toList(),
    );
  }
}

class _TextWrapped extends StatelessWidget {
  final String text;
  final TextStyle? style;
  const _TextWrapped({
    required this.text,
    this.style,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 194.w,
      margin: EdgeInsets.fromLTRB(3.w, 0, 3.w, 0),
      child: TextCreator(text: text, style: style).create(),
    );
  }
}

class _ImageWrapped extends StatelessWidget {
  final String fileName;
  const _ImageWrapped({
    required this.fileName,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(3.w, 0, 3.w, 0),
      child: LimitedBox(
        maxWidth: 114.w,
        child: ImageCreator(
          context: context,
          fileName: fileName,
        ).create(),
      ),
    );
  }
}
