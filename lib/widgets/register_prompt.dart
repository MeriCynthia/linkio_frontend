import 'package:flutter/material.dart';

class RegisterPrompt extends StatelessWidget {
  const RegisterPrompt({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center, // Centering the prompt
      children: [
        const Text(
          "Don't have an account?",
          style: TextStyle(
            color: Color(0xFF6E6F70),
            fontSize: 13,
            fontWeight: FontWeight.w600,
            fontFamily: 'Poppins',
          ),
        ),
        const SizedBox(width: 2),
        TextButton(
          onPressed: () {
            // Handle registration navigation
            Navigator.pushNamed(context, '/register'); // Example navigation
          },
          child: const Text(
            'Register',
            style: TextStyle(
              color: Color(0xFF1C7B75),
              fontSize: 13,
              fontWeight: FontWeight.w600,
              fontFamily: 'Poppins',
            ),
          ),
        ),
      ],
    );
  }
}