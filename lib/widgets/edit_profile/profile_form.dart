import 'package:flutter/material.dart';

class ProfileForm extends StatefulWidget {
  const ProfileForm({super.key});

  @override
  State<ProfileForm> createState() => _ProfileFormState();
}

class _ProfileFormState extends State<ProfileForm> {
  final _formKey = GlobalKey<FormState>();
  bool _obscurePassword = true;
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildFormField(
            label: 'Name',
            initialValue: 'shafanabilah',
          ),
          const SizedBox(height: 10),
          _buildFormField(
            label: 'Username',
            initialValue: 'shafanabilah',
          ),
          const SizedBox(height: 10),
          _buildFormField(
            label: 'E-mail',
            initialValue: 'shafa.nabilah@gmail.com',
            keyboardType: TextInputType.emailAddress,
          ),
          const SizedBox(height: 10),
          _buildFormField(
            label: 'Phone Number',
            initialValue: '081234567890',
            keyboardType: TextInputType.phone,
          ),
          const SizedBox(height: 10),
          _buildPasswordField(),
          const SizedBox(height: 20),
          _buildSaveButton(context), // Pass context to save button
        ],
      ),
    );
  }

  Widget _buildFormField({
    required String label,
    required String initialValue,
    TextInputType? keyboardType,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 10,
            fontWeight: FontWeight.w400,
            color: Colors.black,
          ),
        ),
        const SizedBox(height: 5),
        TextFormField(
          initialValue: initialValue,
          keyboardType: keyboardType,
          decoration: InputDecoration(
            filled: true,
            fillColor: const Color(0xFFF5F5F5),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(7),
              borderSide: const BorderSide(color: Colors.black),
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 13,
              vertical: 12,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPasswordField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Password',
          style: TextStyle(
            fontSize: 10,
            fontWeight: FontWeight.w400,
            color: Colors.black,
          ),
        ),
        const SizedBox(height: 5),
        TextFormField(
          controller: _passwordController,
          obscureText: _obscurePassword,
          decoration: InputDecoration(
            filled: true,
            fillColor: const Color(0xFFF5F5F5),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(7),
              borderSide: const BorderSide(color: Colors.black),
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 13,
              vertical: 12,
            ),
            suffixIcon: IconButton(
              icon: Icon(
                _obscurePassword ? Icons.visibility_off : Icons.visibility,
                color: Colors.grey,
              ),
              onPressed: () {
                setState(() {
                  _obscurePassword = !_obscurePassword;
                });
              },
            ),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Password cannot be empty';
            }
            return null;
          },
        ),
      ],
    );
  }

  Widget _buildSaveButton(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        gradient: const LinearGradient(
          colors: [Color(0xFF133E87), Color(0xFF1C7B75)],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        boxShadow: const [
          BoxShadow(
            color: Colors.black26,
            offset: Offset(0, 4),
            blurRadius: 4,
          ),
        ],
      ),
      child: TextButton(
        onPressed: () {
          if (_formKey.currentState!.validate()) {
            // Tampilkan pop-up berhasil
            _showSuccessDialog(context);
          }
        },
        style: TextButton.styleFrom(
          foregroundColor: const Color(0xFFF5F5F5),
          padding: const EdgeInsets.symmetric(vertical: 10),
        ),
        child: const Text(
          'Save',
          style: TextStyle(fontSize: 13),
        ),
      ),
    );
  }

  // Fungsi untuk menampilkan dialog berhasil
  void _showSuccessDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Success'),
          content: const Text('Profile has been successfully saved!'),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop(); // Menutup dialog
                Navigator.of(context)
                    .pop(); // Kembali ke halaman sebelumnya (home screen)
              },
            ),
          ],
        );
      },
    );
  }
}
