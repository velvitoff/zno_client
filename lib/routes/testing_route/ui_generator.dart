import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:html/parser.dart' as html_parser;

class UiGenerator{
  UiGenerator._();

  static Widget textToWidget(String text, {TextStyle? style}) {
    final doc = html_parser.parseFragment(text);
    if (doc.nodes.isEmpty) {
      return Container();
    }

    var textSpans = <TextSpan>[];
    for (var node in doc.nodes) {
      //nodeType 3 - text, 1 - html
      if (node.nodeType == 1) {
        var nodeString = node.toString();
        if (nodeString.contains('em>') || nodeString.contains('i>')) {
          textSpans.add(TextSpan(text: node.text,
              style: style ?? TextStyle(fontSize: 22.sp, fontStyle: FontStyle.italic)));
        }
        else if (nodeString.contains('b>') || nodeString.contains('strong>')) {
          textSpans.add(TextSpan(text: node.text,
              style: style ?? TextStyle(fontSize: 22.sp, fontWeight: FontWeight.w700)));
        }
        else {
          print('unknown tag: $node');
          textSpans.add(
              TextSpan(text: node.text, style: style ?? TextStyle(fontSize: 22.sp)));
        }
      }
      else {
        textSpans.add(
            TextSpan(text: node.text, style: style ?? TextStyle(fontSize: 22.sp)));
      }
    }

    return Text.rich(
      TextSpan(
          children: textSpans
      ),
    );
  }
}