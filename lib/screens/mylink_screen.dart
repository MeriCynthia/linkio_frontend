// import 'package:flutter/material.dart';
// import '../widgets/profile_header.dart';
// import '../widgets/link_blocks.dart';
// import '../widgets/bottom_nav.dart';

// class MylinkScreen extends StatefulWidget {
//   const MylinkScreen({Key? key}) : super(key: key);

//   @override
//   _MylinkScreenState createState() => _MylinkScreenState();
// }

// class _MylinkScreenState extends State<MylinkScreen> {
//   int _selectedIndex = 3; // Default index for the Search screen

//   void _onItemTapped(int index) {
//     setState(() {
//       _selectedIndex = index;
//     });

//     // Perform navigation logic
//     switch (index) {
//       case 0:
//         Navigator.pushNamed(context, '/home'); // Navigate to Home
//         break;
//       case 1:
//         Navigator.pushNamed(context, '/custom'); // Navigate to Custom screen
//         break;
//       case 2:
//         // Stay on Search screen (or navigate to another screen)
//         Navigator.pushNamed(context, '/search'); // Navigate to Search screen
//         break;
//       case 3:
//         Navigator.pushNamed(context, '/my-link'); // Navigate to My Link screen
//         break;
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: SafeArea(
//         child: Center(
//           child: Container(
//             constraints: const BoxConstraints(maxWidth: 480),
//             margin: const EdgeInsets.symmetric(horizontal: 16),
//               child: Column(
//                 children: [
//                   const ProfileHeader(),
//                   const SizedBox(height: 17),
//                   Text(
//                     'Follow me on social media',
//                     style: TextStyle(
//                       color: Color(0xFF023574),
//                       fontSize: 20,
//                       fontFamily: 'Poppins',
//                     ),
//                   ),
//                   SizedBox(height: 36),
//                   LinkBlocksList(),
//                   const Spacer(),
//                   BottomNav(
//                     selectedIndex: _selectedIndex,
//                     onItemTapped: _onItemTapped,
//                   ),
//                   const SizedBox(height: 20),
//                 ],
//               ),
//             ),
//           ),
//         ));
//   }
// }
