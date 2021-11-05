import 'package:flutter/material.dart';
import 'package:mentor/screens/home_screen.dart';
import 'package:mentor/screens/utilities_screen.dart';
import 'package:mentor/screens/dashboard_screen.dart';
import 'package:mentor/screens/statistics_screen.dart';
import 'package:mentor/screens/profile_screen.dart';

class MainNavigation extends StatefulWidget {
  const MainNavigation({Key? key}) : super(key: key);

  @override
  _MainNavigationState createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  int currentIndex = 2; // Start with the middle screen
  final screens = [
    Home(),
    Utilities(),
    Dashboard(),
    Statistics(),
    Profile()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[currentIndex], // Unpack the selected screen
      bottomNavigationBar: BottomNavigationBar(
        // type: BottomNavigationBarType.fixed,

        // Handle the navigation bar taps:
        currentIndex: currentIndex,
        onTap: (index) => setState(() {
          currentIndex = index;
        }),
        items: const [
          // Bottom Navigation Icon Settings:
          BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: "Home",
              backgroundColor: Colors.blue),
          BottomNavigationBarItem(
              icon: Icon(Icons.lock_outlined),
              label: "Utilities",
              backgroundColor: Colors.red),
          BottomNavigationBarItem(
              icon: Icon(Icons.dashboard_rounded),
              label: "Dashboard",
              backgroundColor: Colors.orange),
          BottomNavigationBarItem(
              icon: Icon(Icons.show_chart_sharp),
              label: "Statistics",
              backgroundColor: Colors.green),
          BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: "Profile",
              backgroundColor: Colors.purple),
        ],
      ),
    );
  }
}
