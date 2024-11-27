import 'package:flutter/material.dart';
import 'widgets/notification_item.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(17, 48, 17, 20),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const NotificationHeader(),
                const SizedBox(height: 24),
                // Bagian 'Notifications' dihapus dari sini
                const SizedBox(height: 25),
                NotificationItem(
                  title: 'New Lynk.id Feature Update!',
                  date: '18 Jan 2023 - 11:18',
                ),
                const SizedBox(height: 25),
                NotificationItem(
                  title: '[IMPORTANT] Balance Settlement policy update',
                  date: '28 Feb 2024 - 15:20',
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
