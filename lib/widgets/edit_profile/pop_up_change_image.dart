import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:linkio_frontend/screens/edit_profile_screen2.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';

class ProfilePictureWidget extends StatefulWidget {
  const ProfilePictureWidget({super.key});

  @override
  _ProfilePictureWidgetState createState() => _ProfilePictureWidgetState();
}

class _ProfilePictureWidgetState extends State<ProfilePictureWidget> {
  File? _image;
  final ImagePicker _picker = ImagePicker();
  bool _isRemoveButtonVisible =
      true; // Variabel untuk mengontrol visibilitas tombol Remove

  @override
  void initState() {
    super.initState();
    _loadProfileImage();
  }

  // Memuat gambar profil yang ada dari storage
  Future<void> _loadProfileImage() async {
    final directory = await getApplicationDocumentsDirectory();
    final path = join(directory.path, 'user_profile.png');
    final file = File(path);
    if (await file.exists()) {
      setState(() {
        _image = file;
      });
    }
  }

  // Memilih gambar dari galeri
  Future<void> _chooseFromDevice() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      await _saveImage(File(pickedFile.path));
    }
  }

  // Membuka kamera untuk mengambil gambar
  Future<void> _openCamera() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      await _saveImage(File(pickedFile.path));
    }
  }

  // Menyimpan gambar yang diambil atau dipilih ke direktori aplikasi
  Future<void> _saveImage(File image) async {
    final directory = await getApplicationDocumentsDirectory();
    final path = join(directory.path, 'user_profile.png');
    await image.copy(path);
    setState(() {
      _image = File(path);
      _isRemoveButtonVisible =
          true; // Tombol Remove muncul setelah gambar disimpan
    });
  }

  // Menghapus gambar profil
  void _removeImage() async {
    final directory = await getApplicationDocumentsDirectory();
    final path = join(directory.path, 'user_profile.png'); // Perbaiki nama file
    final file = File(path);
    if (await file.exists()) {
      await file.delete();
    }
    setState(() {
      _image = null;
      _isRemoveButtonVisible = false; // Sembunyikan tombol Remove
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(7),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Text(
                      'Change Profile Picture',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        fontFamily: 'Poppins',
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Container(
                width: 120,
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(50),
                  child: _image != null
                      ? Image.file(
                          _image!,
                          width: 100,
                          height: 100,
                          fit: BoxFit.cover,
                        )
                      : const Image(
                          image:
                              AssetImage('assets/images/default_profile.png'),
                          width: 100,
                          height: 100,
                          fit: BoxFit.cover,
                        ),
                ),
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    // Mengubah tombol Choose dari Container menjadi Expanded
                    child: _buildButton(
                      label: 'Choose from device',
                      color: const Color(0xFF1C7B75),
                      onTap: _chooseFromDevice,
                    ),
                  ),
                  const SizedBox(width: 10),
                  if (_isRemoveButtonVisible) // Menampilkan tombol Remove hanya jika _isRemoveButtonVisible true
                    _buildButton(
                      label: 'Remove',
                      color: const Color(0xFF9D0101),
                      onTap: _removeImage,
                    ),
                ],
              ),
              const SizedBox(height: 10),
              // Button Camera menjadi lebar penuh
              SizedBox(
                width: double.infinity,
                child: _buildButton(
                  label: 'Camera',
                  color: const Color(0xFF023574),
                  onTap: _openCamera,
                ),
              ),
              const SizedBox(height: 10),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const EditProfileScreen2(),
                    ),
                  );
                },
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFF133E87), Color(0xFF1C7B75)],
                    ),
                    borderRadius: BorderRadius.circular(7),
                  ),
                  child: const Text(
                    'Confirm',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Poppins',
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        // Tombol X untuk menutup popup
        Positioned(
          top: 10,
          right: 10,
          child: IconButton(
            icon: const Icon(Icons.close, color: Colors.grey, size: 24),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
      ],
    );
  }

  // Membuat tombol dengan style dan fungsi tertentu
  Widget _buildButton({
    required String label,
    required Color color,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
        decoration: BoxDecoration(
          border: Border.all(color: const Color(0xFFA2A2A2)),
          borderRadius: BorderRadius.circular(7),
        ),
        child: Text(
          label,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: color,
            fontSize: 12,
            fontWeight: FontWeight.w700,
            fontFamily: 'Poppins',
          ),
        ),
      ),
    );
  }
}
