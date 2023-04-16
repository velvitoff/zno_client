import 'package:client/routes/testing_route/testing_page/answer_variants_table.dart';
import 'package:flutter/material.dart';
import 'package:collection/collection.dart';

class AnswerVariantsComplex extends StatelessWidget {
  final List<String> titleList;
  final List<Map<String, List<String>>> tableList;

  const AnswerVariantsComplex({
    Key? key,
    required this.titleList,
    required this.tableList
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: tableList.mapIndexed((index, table) {
        return AnswerVariantsTable(
          title: titleList.length > index ? titleList[index] : null,
          answers: table,
        );
      }).toList(),
    );
  }
}
