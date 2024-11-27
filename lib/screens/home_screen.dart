import 'package:flutter/material.dart';
import '../widgets/bottom_nav.dart';
import '../widgets/home/profile_section.dart';
import '../widgets/home/stats_section.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

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
              // Header dengan tulisan "Home" di tengah dan ikon notifikasi di kanan
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const SizedBox(
                    width: 48, // Placeholder untuk keseimbangan layout
                  ),
                  const Text(
                    'Home',
                    style: TextStyle(
                      color: Color(0xFF133E87),
                      fontSize: 32,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(
                      Icons.notifications,
                      color: Color(0xFF133E87),
                    ),
                    onPressed: () {
                      // Tambahkan aksi untuk ikon notifikasi
                      debugPrint("Notifikasi ditekan");
                    },
                  ),
                ],
              ),
              const SizedBox(height: 22),
              // Bagian Profil
              const ProfileSection(),
              const SizedBox(height: 20),
              // Bagian Statistik
              const StatsSection(),
              const Spacer(),
              // Navigasi Bawah
              BottomNav(
                onItemTapped: (index) => 0,
                selectedIndex: 0,
              )
            ],
          ),
        ),
      ),
    );
  }
}
