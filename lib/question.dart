import 'package:flutter/material.dart';

class Question extends StatelessWidget {
  final String question;

  // Constructor of the Question class
  Question(this.question);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.all(10),
      child: Text(
        question,
        style: TextStyle(fontSize: 25),
        textAlign: TextAlign.center,
      ),
    );
  }
} 
