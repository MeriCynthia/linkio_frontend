import 'package:flutter/material.dart';

class BottomNav extends StatelessWidget {
  final int selectedIndex;
  final void Function(int index) onItemTapped;

  const BottomNav({Key? key, required this.selectedIndex, required this.onItemTapped}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: const Color(0xFFF5F5F5),
        borderRadius: BorderRadius.circular(25),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            spreadRadius: 2,
            offset: const Offset(0, -2), // Shadow position
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildNavItem(
            icon: Icons.home_rounded,
            label: 'Home',
            isActive: selectedIndex == 0,
            onTap: () => _onNavItemTapped(context, 0),
          ),
          _buildNavItem(
            icon: Icons.dashboard_customize_rounded, // Ikon kotak grid 3 + tanda "+"
            label: 'Custom',
            isActive: selectedIndex == 1,
            onTap: () => _onNavItemTapped(context, 1),
          ),
          _buildNavItem(
            icon: Icons.search_rounded,
            label: 'Search',
            isActive: selectedIndex == 2,
            onTap: () => _onNavItemTapped(context, 2),
          ),
          _buildNavItem(
            icon: Icons.link_rounded, // Ikon link
            label: 'My Link',
            isActive: selectedIndex == 3,
            onTap: () => _onNavItemTapped(context, 3),
          ),
        ],
      ),
    );
  }

  void _onNavItemTapped(BuildContext context, int index) {
    switch (index) {
      case 0:
        Navigator.pushNamed(context, '/home'); // Halaman Home
        break;
      case 1:
        Navigator.pushNamed(context, '/custom'); // Halaman Custom
        break;
      case 2:
        Navigator.pushNamed(context, '/search'); // Halaman Search
        break;
      case 3:
        Navigator.pushNamed(context, '/my-link'); // Halaman My Link
        break;
    }
  }

  Widget _buildNavItem({
    required IconData icon,
    required String label,
    bool isActive = false,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 24,
            color: isActive ? const Color(0xFF133E87) : const Color(0xFF323334),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              color: isActive ? const Color(0xFF133E87) : const Color(0xFF323334),
              fontSize: 12,
              fontFamily: 'Poppins',
              fontWeight: isActive ? FontWeight.w600 : FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}