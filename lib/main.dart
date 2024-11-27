import 'package:flutter/material.dart';
import 'package:provider/provider.dart'; // Import provider
import 'notifications/notification_model.dart'; // Import model notifikasi
import 'notifications/notification_screen.dart'; // Import layar notifikasi

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
      debugShowCheckedModeBanner: false,
      title: 'Flutter Notification App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const NotificationScreen(),
    );
  }
}
