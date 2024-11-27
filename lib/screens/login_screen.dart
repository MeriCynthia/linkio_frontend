import 'package:flutter/material.dart';
import '../widgets/login_form.dart';
import '../widgets/register_prompt.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(  // Allow scrolling when content overflows
        child: Column(
          children: [
            // Bagian gambar di atas
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.2, // 20% layar
              width: double.infinity, // Lebar penuh
              child: Image.asset(
                'assets/images/header.png',
                fit: BoxFit.contain, // Gambar tidak terpotong
              ),
            ),

            // Bagian konten (judul dan login form)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0), // Add padding on sides
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Linkio',
                    style: TextStyle(
                      fontSize: 80,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF323334),
                      fontFamily: 'Poppins',
                    ),
                    semanticsLabel: 'Application Name',
                  ),
                  const SizedBox(height: 32),
                  const LoginForm(), // Form login
                ],
              ),
            ),

            // Spacer is not needed when we use SingleChildScrollView
            const SizedBox(height: 16), // Just a little space before RegisterPrompt

            // Bagian Register Prompt di bawah
            const Padding(
              padding: EdgeInsets.only(bottom: 16), // Padding bawah
              child: RegisterPrompt(),
            ),
          ],
        ),
      ),
    );
  }
}