import 'package:flutter/material.dart';
import '../widgets/notification/notification_item.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(17, 48, 17, 20), // Mengurangi padding bawah
          child: SingleChildScrollView( // Menambahkan widget scroll
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header with custom font
                const NotificationHeader(),
                const SizedBox(height: 24),
                // Title 'Notifications' with Poppins fon
                
                // Notification items
                NotificationItem(
                  title: 'New Lynk.id Feature Update!',
                  date: '18 Jan 2023 - 11:18',
                ),
                const SizedBox(height: 25),
                NotificationItem(
                  title: '[IMPORTANT] Balance Settlement policy update',
                  date: '18 Jan 2023 - 11:18',
                ),
                const SizedBox(height: 25),
                NotificationItem(
                  title: 'New notification feature!',
                  date: '11 Oct 2022 - 10:45',
                ),
                const SizedBox(height: 25),
                NotificationItem(
                  title: 'New feature - custom favicon',
                  date: '08 Nov 2021 - 19:14',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
