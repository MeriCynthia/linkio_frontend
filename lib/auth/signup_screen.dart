import 'package:flutter/material.dart';
import 'auth_form.dart';
import 'auth_header.dart';
import 'auth_footer.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Menambahkan warna latar belakang putih
      body: SingleChildScrollView(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 480),
          padding: const EdgeInsets.fromLTRB(17, 150, 17, 60),
          child: const Column(
            children: [
              AuthHeader(),
              AuthForm(),
              AuthFooter(),
            ],
          ),
        ),
      ),
    );
  }
}
