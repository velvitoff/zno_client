import 'dart:typed_data';
import 'package:client/locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:html/dom.dart' as html;
import 'package:html/parser.dart' as html_parser;

import '../services/interfaces/storage_service.dart';

class UiGenerator{
  UiGenerator._();

  static Set<String> _getStylesFromNodeTree(html.Node node) {
    Set<String> result = {};

    final activeNodeString = node.toString();
    if (activeNodeString.contains('em>') || activeNodeString.contains('i>')){
      result.add('i');
    }
    else if (activeNodeString.contains('b>') || activeNodeString.contains('strong>')){
      result.add('b');
    }

    for (var child in node.children) {
      result.addAll(_getStylesFromNodeTree(child));
    }

    return result;
  }

  static TextStyle _getStyleFromNode(html.Node node) {
    var fontStyle = FontStyle.normal;
    var fontWeight = FontWeight.w400;

    Set<String> styles = _getStylesFromNodeTree(node);
    for (var style in styles) {
      switch(style){
        case 'i':
          fontStyle = FontStyle.italic;
          break;
        case 'b':
          fontWeight = FontWeight.w700;
          break;
      }
    }

    return TextStyle(
      fontSize: 22.sp,
      fontWeight: fontWeight,
      fontStyle: fontStyle
    );
  }

  static Widget textToWidget(String text, {TextStyle? style}) {
    final doc = html_parser.parseFragment(text);
    if (doc.nodes.isEmpty) {
      return Container();
    }

    var textSpans = <TextSpan>[];
    for (var node in doc.nodes) {
      //nodeType 3 - text, 1 - html
      if (node.nodeType != 1) {
        textSpans.add(TextSpan(text: node.text, style: style ?? TextStyle(fontSize: 22.sp)));
      }
      else {
        textSpans.add(TextSpan(text: node.text,style: style ?? _getStyleFromNode(node)));
      }
    }

    return Text.rich(
      TextSpan(
          children: textSpans
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

}