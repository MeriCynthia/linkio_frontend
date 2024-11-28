import 'package:flutter/material.dart';
import '../widgets/bottom_nav.dart'; // Import BottomNav widget

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  void _onItemTapped(int index) {
    // Logika navigasi sesuai indeks
    print("Item tapped: $index");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home"),
        backgroundColor: const Color(0xFF023574),
      ),
      body: Center(
        child: Text(
          "This is the Home Screen",
          style: TextStyle(fontSize: 20, color: const Color(0xFF023574)),
        ),
      ),
      bottomNavigationBar: BottomNav(
        selectedIndex: 0, // Set the selected index for Home
        onItemTapped: _onItemTapped,
      ),
    );
  }
}
