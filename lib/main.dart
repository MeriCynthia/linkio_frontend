import 'package:flutter/material.dart';
import '../screens/edit_profile_screen.dart';
import '../screens/home_screen.dart';
import '../screens/notification_screen.dart';
import 'package:provider/provider.dart';
import 'notification_model.dart';
import 'screens/search_screen.dart';
import 'screens/mylink_screen.dart';
import '../screens/custom_screen.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => NotificationModel(), // Menyediakan model notifikasi
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Linkio',
      initialRoute: '/home', // Rute awal saat aplikasi dibuka
      routes: {
        '/home': (context) => const HomeScreen(), // Rute untuk halaman Home
        '/notification': (context) => const NotificationScreen(), // Rute untuk halaman Search
        '/editprofile': (context) => const EditProfileScreen(),
        '/search': (context) => SearchScreen(), 
        '/my-link': (context) => const MylinkScreen(),
        '/custom': (context) => CustomScreen()    
      },
      debugShowCheckedModeBanner: false, // Menyembunyikan banner debug
    );
  }
}
