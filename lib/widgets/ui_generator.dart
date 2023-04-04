import 'dart:typed_data';
import 'package:client/locator.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:html/dom.dart' as html;
import 'package:html/parser.dart' as html_parser;
import 'dart:convert';
import '../models/testing_route_model.dart';
import '../services/interfaces/storage_service.dart';

class UiGenerator{
  UiGenerator._();

  static Set<String> _getStylesFromNodeTree(html.Node node) {
    Set<String> result = {};

    final activeNodeString = node.toString();
    //print('$activeNodeString : ${node.text}');
    if (activeNodeString.contains('em>') || activeNodeString.contains('i>')){
      result.add('i');
    }
    else if (activeNodeString.contains('b>') || activeNodeString.contains('strong>')){
      result.add('b');
    }
    else if (activeNodeString.contains(' u>')) {
      result.add('u');
    }

    return result;
  }

  static TextStyle _getStyleFromNode(html.Node node, TextStyle? style) {
    var fontStyle = style?.fontStyle ?? FontStyle.normal;
    var fontWeight = style?.fontWeight ?? FontWeight.w400;
    var textDecoration = style?.decoration ?? TextDecoration.none;

    Set<String> styles = _getStylesFromNodeTree(node);
    for (var style in styles) {
      switch(style){
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
      decoration: textDecoration
    );
  }

  static List<TextSpan> _textToSpans(String text, {TextStyle? style}) {
    final doc = html_parser.parseFragment(text);
    if (doc.nodes.isEmpty) {
      return [];
    }

    var textSpans = <TextSpan>[];
    for (var node in doc.nodes) {
      //nodeType 3 - text, 1 - html
      if (node.nodeType != 1) {
        textSpans.add(TextSpan(text: node.text, style: style ?? TextStyle(fontSize: 22.sp)));
      }
      else {
        if (node.nodes.isEmpty) {
          textSpans.add(TextSpan(text: node.text, style: _getStyleFromNode(node, style)));
        }
        else {
          for(var innerNode in node.nodes) {
            textSpans.addAll(
              _textToSpans(innerNode.text ?? "",
              style: _getStyleFromNode(innerNode, _getStyleFromNode(node, style)))
            );
          }
        }
      }
    }

    return textSpans;

  }

  static Widget textToWidget(String text, {TextStyle? style}) {
    return Text.rich(
      TextSpan(
          children: _textToSpans(text, style: style)
      ),
    );
  }

  //TODO: add error/loading render
  static Widget imageToWidget(String subjectFolderName, String sessionName, String fileName) {
    return FutureBuilder(
      future: locator.get<StorageService>().getImage(subjectFolderName, sessionName, fileName),
      builder: (BuildContext context, AsyncSnapshot<Uint8List> snapshot) {
        if (snapshot.hasData) {
          return Image.memory(snapshot.data!);
        }
        else if (snapshot.hasError) {
          return const Text('Error loading image');
        }
        else {
          return const Text('Loading image');
        }
      },
    );
  }


  static Widget textToTable(BuildContext context, String data) {
    final List<List<List<String>>> json = List<List<List<String>>>.from(
        jsonDecode(data).map((x) => List<List<String>>.from(
          x.map((x) => List<String>.from(x))
        ))
    );

    return Column(
      children: json.map((row) =>
          Container(
            width: 320.w,
            margin: EdgeInsets.fromLTRB(0, 5.h, 0, 5.h),
            child: Row(
              children: row.map((data) {
                switch (data[0]) {
                  case 'p':
                    return Container(
                      width: 194.w,
                      margin: EdgeInsets.fromLTRB(3.w, 0, 3.w, 0),
                      child: textToWidget(data[1]),
                    );
                  case 'img':
                    var model = context.read<TestingRouteModel>();
                    return Container(
                      margin: EdgeInsets.fromLTRB(3.w, 0, 3.w, 0),
                      child: LimitedBox(
                        maxWidth: 114.w,
                        child: UiGenerator.imageToWidget(model.subjectFolderName, model.sessionFileName, data[1]),
                      ),
                    );
                  default:
                    return Container();
                }
              }
              ).toList(),
            ),
          )
      ).toList(),
    );
  }

}