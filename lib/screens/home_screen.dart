import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentIndex = 0;
  final screens = [
    const Center(child: Text("HOME PAGE!")),
    const Center(child: Text("UTILITIES PAGE!")),
    const Center(child: Text("DASHBOARD PAGE!")),
    const Center(child: Text("STATISTICS PAGE!")),
    const Center(child: Text("PROFILE PAGE!"))
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Mentor Demo"),
        centerTitle: true,
      ),
      body: screens[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        // type: BottomNavigationBarType.fixed,

        // Handle the navigation bar taps:
        currentIndex: currentIndex,
        onTap: (index) => setState(() {
          currentIndex = index;
        }),
        items: const [
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
