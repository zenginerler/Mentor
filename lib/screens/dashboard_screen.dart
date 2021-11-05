import 'package:flutter/material.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({Key? key}) : super(key: key);

  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  int num1 = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Dashboard"),
        backgroundColor: Colors.orange,
        centerTitle: true,
      ),
      body: Center(child: Text("Dashboard Page! $num1")),
      floatingActionButton: FloatingActionButton(
        onPressed: () => setState(() {
          num1++;
        }),
        tooltip: 'Increment',
        child: const Icon(Icons.add),
        backgroundColor: Colors.orange,
      ),
    );
  }
}