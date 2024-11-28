import 'package:flutter/material.dart';
import '../../screens/edit_profile_screen.dart';

// Function to simulate user logout
void logout(BuildContext context) {
  // Perform logout actions here, like clearing user data, authentication token, etc.
  // For example, if you are using shared preferences, clear it here.

  // After logout, navigate to the login or welcome screen
  Navigator.pushReplacementNamed(context, '/login'); // Example route to login
}

Widget profileSection(BuildContext context, VoidCallback onLogout, String s) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        'My Account',
        style: const TextStyle(
          color: Color(0xFF023574),
          fontSize: 13,
          fontFamily: 'Poppins',
          fontWeight: FontWeight.w600,
        ),
      ),
      const SizedBox(height: 10),
      Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: const Color(0xFFF5F5F5),
          borderRadius: BorderRadius.circular(13),
        ),
        child: Row(
          children: [
            // Profile Picture - Always use the asset 'profil.png'
            CircleAvatar(
              radius: 25,
              backgroundImage: const AssetImage('assets/images/profil.png'),  // Use asset profile picture
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'shafanabilah',  // You can replace this with dynamic data if needed
                    style: const TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    'username: shafanabilah',  // You can replace this with dynamic data if needed
                    style: const TextStyle(
                      fontFamily: 'Poppins',
                      color: Color(0xFFA2A2A2),
                      fontSize: 8,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            // Edit Button
            ElevatedButton(
              onPressed: () {
                // Navigate to the Edit Profile Screen
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const EditProfileScreen(),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF023574),
                padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(7),
                ),
              ),
              child: const Text(
                'Edit',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 10,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(width: 10),
            // Log Out Button
            ElevatedButton(
              onPressed: onLogout,  // Trigger the logout action
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF9D0101),
                padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(7),
                ),
              ),
              child: const Text(
                'Log Out',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 10,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    ],
  );
}