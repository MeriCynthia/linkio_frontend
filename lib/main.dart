import 'package:flutter/material.dart';
import 'package:linkio_frontend/screens/edit_profile_screen.dart';
import 'package:linkio_frontend/screens/home_screen.dart';
import 'package:linkio_frontend/screens/notification_screen.dart';

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
        '/notification': (context) => NotificationScreen(), // Rute untuk halaman Search
        '/editprofile': (context) => const EditProfileScreen(), // Rute untuk halaman Search        
      },
      debugShowCheckedModeBanner: false, // Menyembunyikan banner debug
    );
  }
}
