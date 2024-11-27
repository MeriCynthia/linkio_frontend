import 'package:flutter/material.dart';
import 'package:provider/provider.dart'; 
import 'notification_model.dart'; 
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
                const SizedBox(height: 25),
                // Menggunakan Consumer untuk mendengarkan perubahan pada state
                Consumer<NotificationModel>(
                  builder: (context, notificationModel, child) {
                    return Column(
                      children: notificationModel.notifications
                          .map((notification) {
                            // Untuk setiap item, tambahkan SizedBox sebagai jarak
                            return Column(
                              children: [
                                NotificationItem(
                                  title: notification['title']!,
                                  date: notification['date']!,
                                ),
                                const SizedBox(height: 25), // Jarak antar notifikasi
                              ],
                            );
                          })
                          .toList(),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
