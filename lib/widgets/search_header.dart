import 'package:flutter/material.dart';

class SearchHeader extends StatelessWidget {
  const SearchHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const SizedBox(width: 48), // Placeholder untuk menjaga keseimbangan
          const Text(
            'Search',
            style: TextStyle(
              color: Color(0xFF133E87),
              fontSize: 32,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w600,
            ),
          ),
          IconButton(
            icon: const Icon(
              Icons.notifications_none_rounded,
              color: Color(0xFF133E87),
            ),
            onPressed: () {
              // Tambahkan aksi untuk ikon notifikasi
              print("Notifikasi ditekan");
            },
          ),
        ],
      ),
    );
  }
}
