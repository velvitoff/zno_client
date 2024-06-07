import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:html/dom.dart' as html;
import 'package:html/parser.dart' as html_parser;
import 'package:flutter_math_fork/flutter_math.dart';

class TextCreator {
  final String text;
  final TextStyle? style;

  const TextCreator({required this.text, this.style});

  Widget create() {
    return Container(
      margin: EdgeInsets.only(top: 3.h, bottom: 3.h),
      child: Text.rich(
        TextSpan(
          children: _textToSpans(text, style: style),
        ),
      ),
    );
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

  static List<InlineSpan> _nodeToSpans(html.Node node, {TextStyle? style}) {
    var textSpans = <InlineSpan>[];
    //nodeType 3 - text, 1 - html
    if (node.nodeType != 1) {
      textSpans.add(
        TextSpan(
          text: node.text,
          style: style ?? TextStyle(fontSize: 22.sp),
        ),
      );

      return textSpans;
    }

    if (node.nodes.isEmpty) {
      textSpans.add(
        TextSpan(
          text: node.text,
          style: _getStyleFromNode(node, style),
        ),
      );

      return textSpans;
    }

    if (node.toString().startsWith("<math") && node.text != null) {
      textSpans.add(
        WidgetSpan(
          child: Container(
            constraints: BoxConstraints(maxWidth: 340.w),
            margin: EdgeInsets.only(top: 2.h, bottom: 1.h),
            child: FittedBox(
              fit: BoxFit.contain,
              child:
                  Math.tex(node.text!, textStyle: TextStyle(fontSize: 24.sp)),
            ),
          ),
        ),
      );

      return textSpans;
    }

    for (var innerNode in node.nodes) {
      textSpans.addAll(
        _nodeToSpans(
          innerNode,
          style: _getStyleFromNode(
            innerNode,
            _getStyleFromNode(node, style),
          ),
        ),
      );
    }

    return textSpans;
  }

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
      decoration: textDecoration,
    );
  }
}
