import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart'; // Tambahkan import ini
import 'notification_detail.dart';

class NotificationHeader extends StatelessWidget {
  const NotificationHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          Icons.chevron_left,
          color: const Color(0xFF023574),
          size: 28,
        ),
        const SizedBox(width: 50),
        Text(
          'Notifications',
          style: GoogleFonts.poppins( // Gunakan font Poppins
            color: const Color(0xFF023574),
            fontSize: 32,
            fontWeight: FontWeight.w600,
            decoration: TextDecoration.none,
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
        showDialog(
          context: context,
          barrierDismissible: true,
          barrierColor: Colors.black.withOpacity(0.5),
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
                  style: GoogleFonts.poppins( // Gunakan font Poppins
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF323334),
                    decoration: TextDecoration.none,
                  ),
                ),
              ),
            ),
            if (showDate && date != null)
              Text(
                date!,
                style: GoogleFonts.poppins( // Gunakan font Poppins
                  fontSize: 8,
                  fontWeight: FontWeight.w500,
                  color: const Color(0xFFA2A2A2),
                  decoration: TextDecoration.none,
                ),
              ),
          ],
        ),
      ),
    );
  }
}