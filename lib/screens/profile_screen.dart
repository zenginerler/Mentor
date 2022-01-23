import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  int num1 = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile"),
        backgroundColor: Colors.purple,
        centerTitle: true,
      ),
      body: Center(child: Text("Profile Page! $num1")),
      floatingActionButton: FloatingActionButton(
        heroTag: 'profile_button',
        onPressed: () => setState(() {
          num1++;
        }),
        tooltip: 'Increment',
        child: const Icon(Icons.add),
        backgroundColor: Colors.purple,
      ),
    );
  }
}