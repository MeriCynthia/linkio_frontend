import 'package:flutter/material.dart';

class ChangeBackgroundDialog extends StatefulWidget {
  final Function(String?) onConfirm;
  final String? currentImage;

  const ChangeBackgroundDialog({
    Key? key, 
    required this.onConfirm,
    this.currentImage,
  }) : super(key: key);

  @override
  State<ChangeBackgroundDialog> createState() => _ChangeBackgroundDialogState();
}

class _ChangeBackgroundDialogState extends State<ChangeBackgroundDialog> {
  String? _selectedImage;
  final List<String> _images = [
    'assets/images/image1.png',
    'assets/images/image2.png',
    'assets/images/image3.png',
    'assets/images/image4.png',
    'assets/images/image5.png',
    'assets/images/image6.png',
  ];

  @override
  void initState() {
    super.initState();
    _selectedImage = widget.currentImage;
  }

  void _changeImage() {
    setState(() {
      int currentIndex = _selectedImage != null
          ? _images.indexOf(_selectedImage!)
          : -1;
      _selectedImage = _images[(currentIndex + 1) % _images.length];
    });
  }

  void _removeBackground() {
    setState(() {
      _selectedImage = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Container(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Header
            Stack(
              children: [
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Change Background",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                Positioned(
                  right: -10, 
                  top: -12,  // Adjust vertical position
                  child: IconButton(
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                    icon: const Icon(Icons.close, size: 20),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Preview Image
            Container(
              height: 150,
              width: double.infinity,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(8),
                color: Colors.grey[300],
                image: _selectedImage != null
                    ? DecorationImage(
                        image: AssetImage(_selectedImage!),
                        fit: BoxFit.cover,
                      )
                    : null,
              ),
              child: _selectedImage == null
                  ? const Center(
                      child: Text(
                        "No Image",
                        style: TextStyle(color: Colors.grey),
                      ),
                    )
                  : null,
            ),
            const SizedBox(height: 16),

            // Buttons Row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: SizedBox(
                    height: 40, // Reduced height
                    child: OutlinedButton(
                      onPressed: _changeImage,
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(horizontal: 4), // Reduced padding
                        side: const BorderSide(color: Colors.teal),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Text(
                        "Change Picture",
                        style: TextStyle(
                          color: Colors.teal,
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: SizedBox(
                    height: 40, // Reduced height
                    child: OutlinedButton(
                      onPressed: _removeBackground,
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(horizontal: 4), // Reduced padding
                        side: const BorderSide(color: Colors.red),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Text(
                        "Remove Picture",
                        style: TextStyle(
                          color: Colors.red,
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Confirm Button
            SizedBox(
              width: double.infinity,
              child: Ink(
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF023574), Color(0xFF1C7B75)],
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: InkWell(
                  onTap: () {
                    widget.onConfirm(_selectedImage);
                    Navigator.of(context).pop();
                  },
                  borderRadius: BorderRadius.circular(8),
                  child: Container(
                    height: 42,
                    alignment: Alignment.center,
                    child: const Text(
                      "Confirm",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 13,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}