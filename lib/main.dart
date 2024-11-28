import 'package:flutter/material.dart';
import 'screens/search_screen.dart';
import 'screens/home_screen.dart'; // Import HomeScreen
import 'screens/custom_screen.dart'; // Import CustomScreen
import 'screens/mylink_screen.dart'; // Import MyLinkScreen

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/search',
      routes: {
        '/search': (context) => SearchScreen(),
        '/home': (context) => const HomeScreen(), // Route for Home
        '/custom': (context) => const CustomScreen(), // Route for Custom
        // '/my-link': (context) => const MylinkScreen(), // Route for My Link
      },
    );
  }
}
