import 'package:flutter/material.dart';
// import 'package:mentor/utils/basic_navigation.dart';
import 'package:mentor/screens/login_screen.dart';

// FIX: Add Firebase Initialization
void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // FIX: Connect Firebase with a stream
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      // FIX: Add proper routing !
      home: const LoginPage(), //const MainNavigation(),
      debugShowCheckedModeBanner: false,
    );
  }
}
