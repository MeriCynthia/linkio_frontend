import 'package:flutter/material.dart';
import 'pop_up_change_image.dart';

class ProfileImage2 extends StatelessWidget {
  const ProfileImage2({super.key});

  // Fungsi untuk menampilkan pop-up profile picture
  void _showProfilePictureDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          child:
              const ProfilePictureWidget(), // Menampilkan ProfilePictureWidget di dalam Dialog
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        const CircleAvatar(
          radius: 50,
          backgroundImage: AssetImage(
            'assets/images/user_profile2.jpg', // Gambar default
          ),
        ),
        Positioned(
          bottom: 40,
          right: 20,
          child: GestureDetector(
            onTap: () {
              // Memanggil fungsi untuk menampilkan pop-up
              _showProfilePictureDialog(context);
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.6),
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Text(
                'Change',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 13,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
