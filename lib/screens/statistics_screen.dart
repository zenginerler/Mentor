import 'package:flutter/material.dart';

class StatisticsPage extends StatefulWidget {
  const StatisticsPage({Key? key}) : super(key: key);

  @override
  _StatisticsPageState createState() => _StatisticsPageState();
}

class _StatisticsPageState extends State<StatisticsPage> {
  int num1 = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Statistics"),
        backgroundColor: Colors.green,
        centerTitle: true,
      ),
      body: Center(child: Text("Statistics Page! $num1")),
      floatingActionButton: FloatingActionButton(
        heroTag: 'statistics_button',
        onPressed: () => setState(() {
          num1++;
        }),
        tooltip: 'Increment',
        child: const Icon(Icons.add),
        backgroundColor: Colors.green,
      ),
    );
  }
}