import 'package:flutter/material.dart';
import 'package:linkio_frontend/widgets/bottom_nav.dart';
import 'package:linkio_frontend/widgets/home/log_out_dialogue.dart';
import 'package:linkio_frontend/widgets/home/profile_section.dart';
import 'package:linkio_frontend/widgets/home/stats_section.dart';
import 'notification_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  // Handle navigation between different sections
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    switch (index) {
      case 0:
        break;
      case 1:
        Navigator.pushNamed(context, '/custom');
        break;
      case 2:
        Navigator.pushNamed(context, '/search');
        break;
      case 3:
        Navigator.pushNamed(context, '/my-link');
        break;
    }
  }

  // Show the logout dialog
  void _showLogoutDialog() {
    showDialog(
      context: context,
      barrierDismissible: false, // To prevent closing dialog by tapping outside
      builder: (BuildContext context) {
        return LogoutDialog(
          onConfirm: _logout, // Logout if confirmed
          onCancel: () => Navigator.pop(context), // Close dialog if canceled
        );
      },
    );
  }

  // Logout action (navigate to login screen)
  void _logout() {
    // Replace the current screen with the login screen
    Navigator.pushReplacementNamed(context, '/login');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(100),
        child: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.white,
          elevation: 0,
          flexibleSpace: Padding(
            padding: const EdgeInsets.only(top: 40),
            child: Stack(
              children: [
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    'Home', // This text remains as it is
                    style: const TextStyle(
                      color: Color(0xFF133E87),
                      fontSize: 32,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Positioned(
                  top: 25,  // Menurunkan posisi ikon lebih jauh untuk sejajar dengan teks "Home"
                  right: 16,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const NotificationScreen(),
                        ),
                      );
                    },
                    child: const Icon(
                      Icons.notifications, // Icon notifikasi
                      color: Colors.black,
                      size: 35,  // Memperbesar ukuran ikon
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0), // Padding kiri dan kanan
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 'Welcome' text now aligns with the other sections
              Padding(
                padding: const EdgeInsets.only(top: 20), // Padding top untuk menjaga jarak dari AppBar
                child: Text(
                  'Welcome, shafanabilah!',
                  style: const TextStyle(
                    color: Color(0xFF023574),
                    fontSize: 20,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              profileSection(context, _showLogoutDialog, 'shafanabilah'),  // Pass the username as well
              const SizedBox(height: 30),
              const StatsSection(),
              const Spacer(),
            ],
          ),
        ),
      ),
      // Floating Navbar at the bottom
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0), // Padding kiri dan kanan
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),  // Optional: Round corners for the floating nav
          child: Container(
            color: Colors.white,  // Background color for the bottom navbar
            child: Padding(
              padding: const EdgeInsets.only(bottom: 20), // Add some space above the BottomNav
              child: BottomNav(
                selectedIndex: _selectedIndex,  // Change this from 'currentIndex' to 'selectedIndex'
                onItemTapped: _onItemTapped,   // Pass the function to handle taps
              ),
            ),
          ),
        ),
      ),
    );
  }
}