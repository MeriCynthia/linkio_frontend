import 'package:flutter/material.dart';
import '../widgets/home/profile_section2.dart';
import '../widgets/bottom_nav.dart';
import '../widgets/home/stats_section.dart';
import 'notification_screen.dart';

class HomeScreen2 extends StatefulWidget {
  const HomeScreen2({Key? key}) : super(key: key);

  @override
  _HomeScreen2State createState() => _HomeScreen2State();
}

class _HomeScreen2State extends State<HomeScreen2> {
  int _selectedIndex = 0;

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(17, 46, 17, 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Stack(
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: const Text(
                      'Home',
                      style: TextStyle(
                        color: Color(0xFF133E87),
                        fontSize: 32,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  Positioned(
                    right: 0,
                    child: IconButton(
                      icon: const Icon(
                        Icons.notifications,
                        color: Color(0xFF133E87),
                        size: 35,
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const NotificationScreen(),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 22),
              // Bagian Profil dengan foto tetap dipertahankan
              const ProfileSection2(), 
              const SizedBox(height: 30),
              // Bagian Statistik
              const StatsSection(),
              const Spacer(),
              // Navigasi Bawah
              BottomNav(
                onItemTapped: _onItemTapped,
                selectedIndex: _selectedIndex,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
