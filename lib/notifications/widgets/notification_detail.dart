import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart'; // Tambahkan import ini

class NotificationDetail extends StatelessWidget {
  final String title;
  final String date;
  final String description;

  const NotificationDetail({
    Key? key,
    required this.title,
    required this.date,
    required this.description,
  }) : super(key: key);

  // Fungsi helper untuk membangun detail berdasarkan judul
  static NotificationDetail buildFromTitle(String title, String? date) {
    final String description;
    switch (title) {
      case 'New Lynk.id Feature Update!':
        description = 'We are happy to announce the launch of Appointment feature '
            'where creator can create and sell online / physical appointment. '
            'Some use case: 1:1 consultation meeting, private tutor, '
            'and many more.\n\n'
            'We have also upgraded our e-course video playback that '
            'enable auto scaling video quality up to 1080p. This enables '
            'smoother experience for the audiences.\n\n'
            'Let the team know if you have any suggestion. Cheers!';
        break;
      case '[IMPORTANT] Balance Settlement policy update':
        description = 'We have updated our Balance Settlement policy. Please review the new terms carefully to understand how this impacts your account.';
        break;
      case 'New notification feature!':
        description = 'Introducing the ability to get real-time updates directly on your device. Stay informed with the latest updates!';
        break;
      case 'New feature - custom favicon':
        description = 'You can now customize the favicon for your profile. Upload your custom icon and stand out!';
        break;
      default:
        description = 'Details for this notification are currently unavailable.';
    }

    return NotificationDetail(
      title: title,
      date: date ?? 'Unknown date',
      description: description,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: ConstrainedBox(
        constraints: const BoxConstraints(
          maxWidth: 1000, // Lebar maksimal kotak
        ),
        child: Stack(
          children: [
            // Konten utama
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Header dengan judul dan tanggal
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(
                      vertical: 16,
                      horizontal: 16,
                    ),
                    decoration: const BoxDecoration(
                      color: Color.fromARGB(255, 4, 139, 125), // Warna header
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          title,
                          style: GoogleFonts.poppins( // Gunakan font Poppins
                            color: Colors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center, // Pusatkan teks judul
                          overflow: TextOverflow.ellipsis, // Hindari overflow
                        ),
                        const SizedBox(height: 8),
                        Text(
                          date,
                          style: GoogleFonts.poppins( // Gunakan font Poppins
                            color: Colors.white70,
                            fontSize: 14,
                          ),
                          textAlign: TextAlign.center, // Pusatkan teks tanggal
                        ),
                      ],
                    ),
                  ),
                  // Isi deskripsi
                  Padding(
                    padding: const EdgeInsets.all(24),
                    child: Text(
                      description,
                      style: GoogleFonts.poppins( // Gunakan font Poppins
                        color: Colors.black87,
                        fontSize: 14,
                      ),
                      textAlign: TextAlign.center, // Pusatkan teks deskripsi
                    ),
                  ),
                ],
              ),
            ),
            // Tombol close
            Positioned(
              top: 8, // Jarak dari atas
              right: 8, // Jarak dari kanan
              child: GestureDetector(
                onTap: () => Navigator.of(context).pop(),
                child: const Icon(
                  Icons.close,
                  color: Colors.white,
                  size: 20, // Ukuran ikon close
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
