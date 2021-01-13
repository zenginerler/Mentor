import 'package:flutter/material.dart';

class Choice extends StatelessWidget {
  final Function choiceHandler;
  final String goalChoice;

  Choice(this.choiceHandler, this.goalChoice);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(left: 40, right: 40),
      child: RaisedButton(
        child: Text(goalChoice),
        onPressed: choiceHandler,
        color: Colors.green,
      ),
    );
  }

}
