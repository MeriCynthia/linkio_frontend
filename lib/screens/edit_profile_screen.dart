import 'package:flutter/material.dart';
import '../widgets/edit_profile/profile_form.dart';
import '../widgets/edit_profile/profile_image.dart';

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(100.0), // Height adjusted for proper spacing
        child: AppBar(
          backgroundColor: Colors.white,
          elevation: 0, // No shadow under the AppBar
          leading: Padding(
            padding: const EdgeInsets.only(left: 10, top: 15), // Adjust padding for back button
            child: IconButton(
              icon: const Icon(
                Icons.chevron_left,
                color: Color(0xFF023574),
                size: 40, // Icon size to ensure it's visible properly
              ),
              onPressed: () {
                Navigator.popUntil(context, ModalRoute.withName('/home'));
              },
            ),
          ),
          title: Align(
            child: Padding(
              padding: const EdgeInsets.only(right: 30, top: 25), // Lowered the title further for proper alignment
              child: Text(
                'Edit Profile',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  color: const Color(0xFF023574),
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  decoration: TextDecoration.none,
                ),
              ),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.fromLTRB(17, 20, 17, 206),
          constraints: const BoxConstraints(maxWidth: 480),
          child: const Column(
            children: [
              SizedBox(height: 44),
              ProfileImage(imagePath: '',),
              SizedBox(height: 20),
              ProfileForm(),
            ],
          ),
        ),
      ),
    );
  }
}
