import 'package:flutter/material.dart';

class Utilities extends StatelessWidget {
  const Utilities({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("UTILITIES"),
        backgroundColor: Colors.red,
        centerTitle: true,
      ),
      body: const Center(child: Text("UTILITIES PAGE!")),
    );
  }
}