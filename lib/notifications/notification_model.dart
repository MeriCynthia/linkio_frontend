import 'package:flutter/foundation.dart';

class NotificationModel extends ChangeNotifier {
  List<Map<String, String>> _notifications = [
    {'title': 'New Lynk.id Feature Update!', 'date': '18 Jan 2023 - 11:18'},
    {'title': '[IMPORTANT] Balance Settlement policy update', 'date': '28 Feb 2024 - 15:20'},
    {'title': 'New notification feature!', 'date': '11 Oct 2022 - 10:45'},
    {'title': 'New feature - custom favicon', 'date': '08 Nov 2021 - 19:14'},
  ];

  List<Map<String, String>> get notifications => _notifications;

  void addNotification(String title, String date) {
    _notifications.add({'title': title, 'date': date});
    notifyListeners(); // Memberitahu bahwa state telah berubah
  }
}
