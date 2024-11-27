import 'package:flutter/material.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({Key? key}) : super(key: key);

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController(text: 'user@example.com'); // Static email data
  final _passwordController = TextEditingController(text: 'password123'); // Static password data
  bool _isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    // Get screen size for responsive UI
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: screenWidth * 0.05, // Horizontal padding (5% of screen width)
        vertical: screenHeight * 0.03, // Vertical padding (3% of screen height)
      ),
      margin: EdgeInsets.symmetric(horizontal: screenWidth * 0.05), // Margin adjusted for screen width
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(
            color: Color.fromRGBO(0, 0, 0, 0.1),
            blurRadius: 4,
            offset: Offset(0, 1),
          ),
        ],
      ),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Username / E-mail',
              style: TextStyle(
                color: Color(0xFF6E6F70),
                fontSize: 13,
                fontWeight: FontWeight.w600,
                fontFamily: 'Poppins',
              ),
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: _emailController, // Static email
              decoration: InputDecoration(
                hintText: 'Username / E-mail',
                hintStyle: const TextStyle(
                  color: Color(0xFFC9CACA),
                  fontSize: 12,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(
                    color: Color.fromRGBO(0, 0, 0, 0.08),
                  ),
                ),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your email';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),

            const Text(
              'Password',
              style: TextStyle(
                color: Color(0xFF6E6F70),
                fontSize: 13,
                fontWeight: FontWeight.w600,
                fontFamily: 'Poppins',
              ),
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: _passwordController, // Static password
              obscureText: !_isPasswordVisible, // Toggle password visibility
              decoration: InputDecoration(
                hintText: 'Password',
                hintStyle: const TextStyle(
                  color: Color(0xFFC9CACA),
                  fontSize: 12,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(
                    color: Color.fromRGBO(0, 0, 0, 0.08),
                  ),
                ),
                suffixIcon: IconButton(
                  icon: Icon(
                    _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                    color: const Color(0xFF6E6F70),
                  ),
                  onPressed: () {
                    setState(() {
                      _isPasswordVisible = !_isPasswordVisible;
                    });
                  },
                ),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your password';
                }
                return null;
              },
            ),
            const SizedBox(height: 32),

            // Sign In Button
            SizedBox(
              width: double.infinity, // Button fills available width
              child: ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState?.validate() ?? false) {
                    Navigator.pushReplacementNamed(context, '/home');
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF1C7B75),
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text(
                  'Sign In',
                  style: TextStyle(
                    color: Color(0xFFF5F5F5),
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'Poppins',
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
