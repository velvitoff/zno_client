import 'package:client/locator.dart';
import 'package:client/services/storage_service/main_storage_service.dart';
import 'package:client/widgets/audio_player_widget.dart';
import 'package:client/widgets/image_in_a_test_wrapper.dart';
import 'package:client/widgets/ui_gen_handler.dart';
import 'package:flutter_math_fork/flutter_math.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:html/dom.dart' as html;
import 'package:html/parser.dart' as html_parser;
import 'dart:convert';
import '../state_models/testing_route_state_model.dart';

import 'horizontal_scroll_wrapper.dart';

class UiGenerator {
  UiGenerator._();

  static Set<String> _getStylesFromNodeTree(html.Node node) {
    Set<String> result = {};

    var activeNodeString = node.toString();
    if (activeNodeString.contains('em>') || activeNodeString.contains('i>')) {
      result.add('i');
    } else if (activeNodeString.contains('b>') ||
        activeNodeString.contains('strong>')) {
      result.add('b');
    } else if (activeNodeString.contains('u>')) {
      result.add('u');
    }
    //print('$node - ${node.nodes}');

    return result;
  }

  static TextStyle _getStyleFromNode(html.Node node, TextStyle? style) {
    var fontStyle = style?.fontStyle ?? FontStyle.normal;
    var fontWeight = style?.fontWeight ?? FontWeight.w400;
    var textDecoration = style?.decoration ?? TextDecoration.none;

    Set<String> styles = _getStylesFromNodeTree(node);
    for (var style in styles) {
      switch (style) {
        case 'i':
          fontStyle = FontStyle.italic;
          break;
        case 'b':
          fontWeight = FontWeight.w700;
          break;
        case 'u':
          textDecoration = TextDecoration.underline;
          break;
      }
    }

    return TextStyle(
        fontSize: 22.sp,
        fontWeight: fontWeight,
        fontStyle: fontStyle,
        decoration: textDecoration);
  }

  static List<InlineSpan> _nodeToSpans(html.Node node, {TextStyle? style}) {
    var textSpans = <InlineSpan>[];
    //nodeType 3 - text, 1 - html
    if (node.nodeType != 1) {
      textSpans.add(TextSpan(
          text: node.text, style: style ?? TextStyle(fontSize: 22.sp)));
    } else {
      if (node.nodes.isEmpty) {
        textSpans.add(
            TextSpan(text: node.text, style: _getStyleFromNode(node, style)));
      } else if (node.toString().startsWith("<math") && node.text != null) {
        textSpans.add(WidgetSpan(
            child: Container(
                constraints: BoxConstraints(maxWidth: 340.w),
                margin: EdgeInsets.only(top: 2.h, bottom: 1.h),
                child: FittedBox(
                  fit: BoxFit.contain,
                  child: Math.tex(node.text!,
                      textStyle: TextStyle(fontSize: 24.sp)),
                ))));
      } else {
        for (var innerNode in node.nodes) {
          textSpans.addAll(_nodeToSpans(innerNode,
              style: _getStyleFromNode(
                  innerNode, _getStyleFromNode(node, style))));
        }
      }
    }
    return textSpans;
  }

  static List<InlineSpan> _textToSpans(String text, {TextStyle? style}) {
    final doc = html_parser.parseFragment(text);
    if (doc.nodes.isEmpty) {
      return [];
    }

    var textSpans = <InlineSpan>[];
    for (var node in doc.nodes) {
      textSpans.addAll(_nodeToSpans(node));
    }

    return textSpans;
  }

  static Widget textToWidget(String text, {TextStyle? style}) {
    return Container(
        margin: EdgeInsets.only(top: 3.h, bottom: 3.h),
        child: Text.rich(
          TextSpan(children: _textToSpans(text, style: style)),
        ));
  }

  static Widget imageToWidget(
      String subjectFolderName, String sessionName, String fileName) {
    return ImageInATestWrapper(
        futureBytes: locator
            .get<MainStorageService>()
            .getFileBytes(subjectFolderName, sessionName, fileName));
  }

  static Widget textToTable(BuildContext context, String data,
      {TextStyle? style}) {
    var tableMap = jsonDecode(data);
    var tableString = tableMap['data'] as String;
    String? tableType = tableMap['type'] as String?;

    final List<List<List<String>>> json = List<List<List<String>>>.from(
        jsonDecode(tableString).map((x) =>
            List<List<String>>.from(x.map((x) => List<String>.from(x)))));

    if (tableType == null) {
      return _textToTableDefaultStyle(context, json, style: style);
    } else {
      if (tableType == 'data_table') {
        return _textToTableDataStyle(context, json, style: style);
      }
    }
    return Container();
  }

  static Widget _textToTableDataStyle(
      BuildContext context, List<List<List<String>>> data,
      {TextStyle? style}) {
    final List<DataColumn> columns = data[0]
        .map((x) => DataColumn(
                label: UiGenHandler(
              data: x,
              allowRenderTables: false,
            )))
        .toList();

    final List<DataRow> rows = data
        .sublist(1)
        .map((row) => DataRow(
            cells: row
                .map((cell) => DataCell(UiGenHandler(
                      data: cell,
                      allowRenderTables: false,
                    )))
                .toList()))
        .toList();

    return HorizontalScrollWrapper(
      child: DataTable(columns: columns, rows: rows),
    );
  }

  static Widget _textToTableDefaultStyle(
      BuildContext context, List<List<List<String>>> data,
      {TextStyle? style}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: data
          .map((row) => Container(
                width: 320.w,
                margin: EdgeInsets.fromLTRB(0, 5.h, 0, 5.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: row.map((data) {
                    if (data[0] == 'p') {
                      return Container(
                        width: 194.w,
                        margin: EdgeInsets.fromLTRB(3.w, 0, 3.w, 0),
                        child: textToWidget(data[1], style: style),
                      );
                    } else if (data[0] == 'img') {
                      var model = context.read<TestingRouteStateModel>();
                      return Container(
                        margin: EdgeInsets.fromLTRB(3.w, 0, 3.w, 0),
                        child: LimitedBox(
                          maxWidth: 114.w,
                          child: UiGenerator.imageToWidget(
                              model.sessionData.folderName,
                              model.sessionData.fileNameNoExtension,
                              data[1]),
                        ),
                      );
                    } else {
                      return Container();
                    }
                  }).toList(),
                ),
              ))
          .toList(),
    );
  }

  static Widget audioPlayer(
      String folderName, String folderInnerName, String fileName) {
    return AudioPlayerWidget(
        folderName: folderName,
        folderInnerName: folderInnerName,
        fileName: fileName);
  }
}
