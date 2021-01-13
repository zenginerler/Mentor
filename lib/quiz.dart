import 'package:flutter/material.dart';

import './question.dart';
import './choice.dart';

class Quiz extends StatelessWidget {
  final List<Map<String, Object>> goalList;
  final Function testFunction;
  final int goalIndex;

  Quiz(
      {@required this.goalList,
      @required this.testFunction,
      @required this.goalIndex});

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Question(goalList[goalIndex]['questionText']),
      ...(goalList[goalIndex]['choiceTexts'] as List<String>).map((goal) {
        return Choice(testFunction, goal);
      }).toList()
    ]);
  }
}
