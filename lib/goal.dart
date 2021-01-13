import 'package:flutter/material.dart';

class Goal extends StatelessWidget {
  final String goalName;
  final int goalAmount;

  // Constructor of the Goal class
  Goal(this.goalName, {this.goalAmount = 0});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.all(10),
      child: Text(
        goalName,
        style: TextStyle(fontSize: 25),
        textAlign: TextAlign.center,
      ),
    );
  }
}
