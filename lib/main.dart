import 'package:flutter/material.dart';
import 'package:linkio_frontend/screens/home_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Navigation Example',
      initialRoute: '/home', // Rute awal saat aplikasi dibuka
      routes: {
        '/home': (context) => HomeScreen(), // Rute untuk halaman Home
      },
      debugShowCheckedModeBanner: false, // Menyembunyikan banner debug
    );
  }
}