import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'notifications/notification_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Notification App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        textTheme: GoogleFonts.poppinsTextTheme(), // Gunakan Poppins sebagai font utama
      ),
      home: const NotificationScreen(),
    );
  }
}
