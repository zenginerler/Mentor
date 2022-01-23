import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int num1 = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home"),
        backgroundColor: Colors.blue,
        centerTitle: true,
      ),
      body: Center(child: Text("Home Page! $num1")),
      floatingActionButton: FloatingActionButton(
        heroTag: 'home_button',
        onPressed: () => setState(() {
          num1++;
        }),
        tooltip: 'Increment',
        child: const Icon(Icons.add),
        backgroundColor: Colors.blue,
      ),
    );
  }
}
