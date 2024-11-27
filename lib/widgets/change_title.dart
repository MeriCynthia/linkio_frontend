import 'package:flutter/material.dart';
import 'package:flutter_material_color_picker/flutter_material_color_picker.dart';

class ChangeTitleDialog extends StatefulWidget {
  final String? initialTitle;
  final Function(String) onTitleChanged;
  final Function(bool, bool, TextAlign, Color, String?) onStyleChanged;

  const ChangeTitleDialog({
    Key? key,
    required this.initialTitle,
    required this.onTitleChanged,
    required this.onStyleChanged,
  }) : super(key: key);

  @override
  _ChangeTitleDialogState createState() => _ChangeTitleDialogState();
}

class _ChangeTitleDialogState extends State<ChangeTitleDialog> {
  late TextEditingController _controller;
  bool _isBold = false;
  bool _isItalic = false;
  TextAlign _textAlign = TextAlign.left;
  Color _textColor = Colors.black;
  String? _fontFamily;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.initialTitle);
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: const EdgeInsets.all(20),
      backgroundColor: Colors.transparent,
      child: Center(
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Change Title",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  GestureDetector(
                    onTap: () => Navigator.of(context).pop(),
                    child: const Icon(Icons.close, color: Colors.black),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _controller,
                maxLines: 3,
                decoration: InputDecoration(
                  hintText: "Enter your title",
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 8,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.all(8),
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  _controller.text.isEmpty ? "Preview Text" : _controller.text,
                  style: TextStyle(
                    fontWeight: _isBold ? FontWeight.bold : FontWeight.normal,
                    fontStyle: _isItalic ? FontStyle.italic : FontStyle.normal,
                    color: _textColor,
                    fontFamily: _fontFamily,
                  ),
                  textAlign: _textAlign,
                ),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildOptionButton(
                    icon: Icons.format_bold,
                    isActive: _isBold,
                    onTap: () {
                      setState(() {
                        _isBold = !_isBold;
                      });
                    },
                  ),
                  _buildOptionButton(
                    icon: Icons.format_italic,
                    isActive: _isItalic,
                    onTap: () {
                      setState(() {
                        _isItalic = !_isItalic;
                      });
                    },
                  ),
                  _buildAlignButton(Icons.format_align_left, TextAlign.left),
                  _buildAlignButton(Icons.format_align_center, TextAlign.center),
                  _buildAlignButton(Icons.format_align_right, TextAlign.right),
                  GestureDetector(
                    onTap: () async {
                      Color? newColor = await showDialog(
                        context: context,
                        builder: (context) {
                          Color tempColor = _textColor;
                          return AlertDialog(
                            title: const Text("Pick Text Color"),
                            content: MaterialColorPicker(
                              selectedColor: tempColor,
                              onColorChange: (color) {
                                tempColor = color;
                              },
                            ),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context, tempColor);
                                },
                                child: const Text("Select"),
                              ),
                            ],
                          );
                        },
                      );
                      if (newColor != null) {
                        setState(() {
                          _textColor = newColor;
                        });
                      }
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 3, vertical: 4),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            width: 16,
                            height: 16,
                            decoration: BoxDecoration(
                              color: _textColor,
                              borderRadius: BorderRadius.circular(4),
                              border: Border.all(color: Colors.black),
                            ),
                          ),
                          const SizedBox(width: 6),
                          Text(
                            '${_textColor.value.toRadixString(16).padLeft(8, '0').substring(2).toUpperCase()}',
                            style: const TextStyle(fontSize: 13),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value: _fontFamily ?? 'Poppins', // Provide a default value
                    hint: const Text("Select Font"),
                    isExpanded: true,
                    onChanged: (String? newValue) {
                      setState(() {
                        _fontFamily = newValue;
                      });
                    },
                    items: [
                      'Poppins',
                      'Roboto',
                      'Open Sans',
                      'Arial',
                      'Times New Roman'
                    ].map<DropdownMenuItem<String>>((String font) {
                      return DropdownMenuItem<String>(
                        value: font,
                        child: Text(
                          font,
                          style: TextStyle(fontFamily: font),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: GestureDetector(
                  onTap: () {
                    widget.onTitleChanged(_controller.text);
                    widget.onStyleChanged(_isBold, _isItalic, _textAlign, _textColor, _fontFamily);
                    Navigator.of(context).pop();
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [
                          Color(0xFF023574),
                          Color(0xFF1C7B75),
                        ],
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    alignment: Alignment.center,
                    child: const Text(
                      "Confirm",
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.white,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildOptionButton({
    required IconData icon,
    required bool isActive,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(6),
        decoration: BoxDecoration(
          color: isActive ? Color(0xFF023574) : Colors.grey.shade200,
          shape: BoxShape.circle,
          border: Border.all(
            color: isActive ? Color(0xFF023574) : Colors.grey,
            width: 2,
          ),
        ),
        child: Icon(
          icon,
          color: isActive ? Colors.white : Colors.black,
          size: 16,
        ),
      ),
    );
  }

  Widget _buildAlignButton(IconData icon, TextAlign align) {
  return GestureDetector(
    onTap: () {
      setState(() {
        _textAlign = align;
      });
    },
    child: Container(
      padding: const EdgeInsets.all(6), // Padding untuk meniru gaya OptionButton
      decoration: BoxDecoration(
        color: _textAlign == align ? Color(0xFF023574) : Colors.grey.shade200, // Warna background
        shape: BoxShape.circle, // Bentuk bulat
        border: Border.all(
          color: _textAlign == align ? Color(0xFF023574) : Colors.grey, // Border sesuai status
          width: 2,
        ),
      ),
      child: Icon(
        icon,
        color: _textAlign == align ? Colors.white : Colors.black, // Warna ikon
        size: 16, // Ukuran ikon serupa
      ),
    ),
  );
}
}