import 'package:flutter/material.dart';

class AuthHeader extends StatelessWidget {
  const AuthHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(7),
        topRight: Radius.circular(7),
      ),
      child: Container(
        height: 120, // Menyesuaikan tinggi kontainer
        width: double.infinity, // Menyesuaikan lebar kontainer
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
                'assets/images/background_header.png'), // Pastikan path gambar benar
            fit: BoxFit.cover, // Memastikan gambar mengisi kontainer
          ),
        ),
        child: Stack(
          children: [
            // Menambahkan gradien dengan efek pencampuran
            Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                      'assets/images/background_header.png'), // Ganti dengan path gambar yang sesuai
                  fit: BoxFit
                      .cover, // Menyesuaikan gambar agar memenuhi area container
                ),
              ),
            ),
            // Menambahkan teks "Linkio" dengan latar belakang gradien
            const Center(
              child: Text(
                'Linkio',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 40,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            // Menambahkan teks "Please fill in all the mandatory fields below"
            const Positioned(
              bottom: 10, // Menempatkan teks di bawah "Linkio"
              left: 20,
              right: 20,
              child: Center(
                child: Text(
                  'Please fill in all the mandatory fields below',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontFamily: 'Poppins',
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
