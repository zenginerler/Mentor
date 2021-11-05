import 'package:flutter/material.dart';

class Statistics extends StatelessWidget {
  const Statistics({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("STATISTICS"),
        backgroundColor: Colors.green,
        centerTitle: true,
      ),
      body: const Center(child: Text("STATISTICS PAGE!")),
    );
  }
}