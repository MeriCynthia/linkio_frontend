import 'package:flutter/material.dart';
import '../widgets/edit_profile/profile_form.dart';
import '../widgets/edit_profile/profile_image.dart';

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Mengatur latar belakang putih
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0, //Menghapus bayangan di bawah AppBar
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF133E87)),
          onPressed: () =>
              Navigator.pop(context), // Kembali ke halaman sebelumnya
        ),
        centerTitle: true, // Menempatkan judul di  tengah
        title: const Text(
          'Edit Profil',
          style: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: Color(0xFF133E87),
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
              ProfileImage(),
              SizedBox(height: 20),
              ProfileForm(),
            ],
          ),
        ),
      ),
    );
  }
}
