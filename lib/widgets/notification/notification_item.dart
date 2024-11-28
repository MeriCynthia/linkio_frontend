import 'package:flutter/material.dart';
import 'package:linkio_frontend/widgets/notification/notification_detail.dart';

class NotificationHeader extends StatelessWidget {
  const NotificationHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          icon: const Icon(
            Icons.chevron_left,
            color: Color(0xFF023574),
            size: 28,
          ),
          onPressed: () {
            // Navigate back to the homepage when back button is pressed
            Navigator.popUntil(context, ModalRoute.withName('/home'));
          },
        ),
        // Centering the "Notifications" text
        Expanded(
          child: Text(
            'Notifications',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: 'Poppins', // Apply Poppins font
              color: const Color(0xFF023574),
              fontSize: 32,
              fontWeight: FontWeight.bold, // Make the text bold
              decoration: TextDecoration.none, // Remove underline
            ),
          ),
        ),
      ],
    );
  }
}

class NotificationItem extends StatelessWidget {
  final String title;
  final String? date;
  final bool showDate;

  const NotificationItem({
    Key? key,
    required this.title,
    this.date,
    this.showDate = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Show pop-up dialog with dark background
        showDialog(
          context: context,
          barrierDismissible: true, // Dialog can be dismissed by tapping outside
          barrierColor: Colors.black.withOpacity(0.5), // Semi-transparent dark background
          builder: (BuildContext context) {
            return NotificationDetail.buildFromTitle(title, date);
          },
        );
      },
      child: Container(
        padding: const EdgeInsets.fromLTRB(27, 4, 27, 14),
        decoration: BoxDecoration(
          color: const Color(0xFFF1F8FF),
          borderRadius: BorderRadius.circular(7),
          border: Border.all(color: const Color(0xFFF5F5F5)),
          boxShadow: const [
            BoxShadow(
              color: Color.fromRGBO(0, 0, 0, 0.25),
              blurRadius: 4,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Text(
                  title,
                  style: const TextStyle(
                    fontFamily: 'Poppins', // Apply Poppins font
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF323334),
                    decoration: TextDecoration.none, // Remove underline if any
                  ),
                ),
              ),
            ),
            if (showDate && date != null)
              Text(
                date!,
                style: const TextStyle(
                  fontFamily: 'Poppins', // Apply Poppins font
                  fontSize: 8,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFFA2A2A2),
                  decoration: TextDecoration.none, // Remove underline if any
                ),
              ),
          ],
        ),
      ),
    );
  }
}
