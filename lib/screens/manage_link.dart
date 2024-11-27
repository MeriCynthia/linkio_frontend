import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'custom_screen.dart';

// Model class for LinkItem with toJson and fromJson methods
class LinkItem {
  final String title;
  final String url;

  LinkItem({
    required this.title,
    required this.url,
  });

  // Convert LinkItem to JSON
  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'url': url,
    };
  }

  // Create LinkItem from JSON
  factory LinkItem.fromJson(Map<String, dynamic> json) {
    return LinkItem(
      title: json['title'],
      url: json['url'],
    );
  }
}

class ManageLinkPage extends StatefulWidget {
  const ManageLinkPage({Key? key}) : super(key: key);

  @override
  State<ManageLinkPage> createState() => _ManageLinkPageState();
}

class _ManageLinkPageState extends State<ManageLinkPage> {
  List<LinkItem> links = [];
  static const String LINKS_KEY = 'saved_links';

  @override
  void initState() {
    super.initState();
    _loadLinks();
  }

  // Load saved links from SharedPreferences
  Future<void> _loadLinks() async {
    final prefs = await SharedPreferences.getInstance();
    final String? linksJson = prefs.getString(LINKS_KEY);
    
    if (linksJson != null) {
      final List<dynamic> decodedList = jsonDecode(linksJson);
      setState(() {
        links = decodedList
            .map((item) => LinkItem.fromJson(item))
            .toList();
      });
    }
  }

  // Save links to SharedPreferences
  Future<void> _saveLinks() async {
    final prefs = await SharedPreferences.getInstance();
    final String linksJson = jsonEncode(
      links.map((link) => link.toJson()).toList(),
    );
    await prefs.setString(LINKS_KEY, linksJson);
  }

  void _showAddLinkDialog() {
    showDialog(
      context: context,
      builder: (context) => AddLinkDialog(
        onConfirm: (title, url) {
          if (url.isEmpty) {
            _showAlertDialog();
          } else if (links.length < 5) {
            setState(() {
              links.add(LinkItem(
                title: title,
                url: url,
              ));
            });
            _saveLinks(); // Save links after adding new one
          }
        },
      ),
    );
  }

  void _showEditLinkDialog(int index) {
    final link = links[index];
    showDialog(
      context: context,
      builder: (context) => AddLinkDialog(
        initialTitle: link.title,
        initialUrl: link.url,
        onConfirm: (title, url) {
          if (url.isEmpty) {
            _showAlertDialog();
          } else {
            setState(() {
              links[index] = LinkItem(
                title: title,
                url: url,
              );
            });
            _saveLinks(); // Save links after editing
          }
        },
      ),
    );
  }

    void _showSaveConfirmationDialog() {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: const Text('Are you sure you want to save this?'),
            actions: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center, // Untuk memusatkan tombol
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context); // Close the dialog
                    },
                    style: TextButton.styleFrom(
                      backgroundColor: Color.fromARGB(255, 191, 5, 5),
                    ),
                    child: const Text(
                      'No',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  const SizedBox(width: 16), // Memberi jarak antar tombol
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context); // Close the dialog
                      _saveLinks(); // Save the links
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CustomScreen(), // Halaman utama
                        ),
                      );
                    },
                    style: TextButton.styleFrom(
                      backgroundColor: Color(0xFF1C7B75),
                    ),
                    child: const Text(
                      'Yes',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ],
          );
        },
      );
    }

    void _deleteLink(int index) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: const Text('Are you sure you want to delete this link?'),
            actions: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center, // Untuk memusatkan tombol
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context); // Close the dialog
                    },
                    style: TextButton.styleFrom(
                      backgroundColor: Color.fromARGB(255, 191, 5, 5),
                    ),
                    child: const Text(
                      'No',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  const SizedBox(width: 16), // Memberi jarak antar tombol
                  TextButton(
                    onPressed: () {
                      setState(() {
                        links.removeAt(index);
                      });
                      _saveLinks(); // Save links after deletion
                      Navigator.pop(context); // Close the dialog
                    },
                    style: TextButton.styleFrom(
                      backgroundColor: Color(0xFF1C7B75),
                    ),
                    child: const Text(
                      'Yes',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ],
          );
        },
      );
    }


  // Rest of your existing build method and UI code remains the same
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.chevron_left, color: Color(0xFF023574)),
          onPressed: () => Navigator.pop(context),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Manage Link',
          style: TextStyle(
            fontSize: 25,
            color: Color(0xFF023574),
            fontWeight: FontWeight.w900,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Your Link",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: Color(0xFF023574),
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
    itemCount: links.length,
    itemBuilder: (context, index) {
      final link = links[index];
      return Padding(
  padding: const EdgeInsets.only(bottom: 8.0),
  child: Container(
    decoration: BoxDecoration(
      color: const Color(0xFF023574),
      borderRadius: BorderRadius.circular(8),
    ),
    child: Row(
      children: [
        const SizedBox(width: 12),
        const Icon(Icons.link, color: Colors.white),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            link.title,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        Container(
          color: Color(0xFF1C7B75), // Warna coklat untuk tombol Edit
          child: TextButton(
            onPressed: () => _showEditLinkDialog(index),
            child: const Text(
              'Edit',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
        Container(
          decoration: const BoxDecoration(
            color: Color.fromARGB(255, 191, 5, 5), // Warna merah untuk tombol Delete
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(8), // Sudut kanan atas melengkung
              bottomRight: Radius.circular(8), // Sudut kanan bawah melengkung
            ),
          ), // Warna merah untuk tombol Delete
          child: TextButton(
            onPressed: () => _deleteLink(index),
            child: const Text(
              'Delete',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
      ],
    ),
  ),
);
    },
  ),
            ),
            if (links.length < 5)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: "Add ",
                          style: GoogleFonts.poppins(
                            fontSize: 15,
                            color: Color(0xFF023574),
                          ),
                        ),
                        TextSpan(
                          text: "${5 - links.length} ",
                          style: GoogleFonts.poppins(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF023574),
                          ),
                        ),
                        TextSpan(
                          text: "more link",
                          style: GoogleFonts.poppins(
                            fontSize: 15,
                            color: Color(0xFF023574),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    "*You can only add 5 links.",
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.bold,
                      fontSize: 10,
                      color: Color.fromARGB(255, 191, 5, 5),
                    ),
                  ),
                ],
              ),
            const SizedBox(height: 13),
            if (links.length < 5)
              _buildCustomButton(
                onPressed: _showAddLinkDialog,
                text: "Add Link",
                gradient: const LinearGradient(
                  colors: [Color(0xFF023574), Color(0xFF1C7B75)],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                ),
              ),
            const SizedBox(height: 8),
            _buildCustomButton(
              onPressed: _showSaveConfirmationDialog,
              text: "Save",
              gradient: const LinearGradient(
                colors: [Color(0xFF023574), Color(0xFF1C7B75)],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showAlertDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Error'),
          content: const Text('Please fill in the URL.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Close the dialog
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  Widget _buildCustomButton({
    required VoidCallback onPressed,
    required String text,
    required Gradient gradient,
  }) {
    return Container(
      width: double.infinity,
      height: 45,
      decoration: BoxDecoration(
        gradient: gradient,
        borderRadius: BorderRadius.circular(8),
      ),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          padding: const EdgeInsets.symmetric(vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(width: 8),
            Text(
              text,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AddLinkDialog extends StatefulWidget {
  final Function(String title, String url) onConfirm;
  final String? initialTitle;
  final String? initialUrl;

  const AddLinkDialog({
    Key? key,
    required this.onConfirm,
    this.initialTitle,
    this.initialUrl,
  }) : super(key: key);

  @override
  _AddLinkDialogState createState() => _AddLinkDialogState();
}

class _AddLinkDialogState extends State<AddLinkDialog> {
  late final TextEditingController _titleController;
  late final TextEditingController _urlController;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.initialTitle ?? '');
    _urlController = TextEditingController(text: widget.initialUrl ?? '');
  }

  @override
  void dispose() {
    _titleController.dispose();
    _urlController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.initialTitle == null ? "Add Link" : "Edit Link",
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(
                labelText: "Link Title",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _urlController,
              decoration: const InputDecoration(
                labelText: "URL",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: Container(
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF023574), Color(0xFF1C7B75)],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: ElevatedButton(
                  onPressed: () {
                    if (_titleController.text.isNotEmpty &&
                        _urlController.text.isNotEmpty) {
                      widget.onConfirm(
                        _titleController.text,
                        _urlController.text,
                      );
                      Navigator.pop(context);
                    } else {
                      _showAlertDialog();
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    shadowColor: Colors.transparent,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text(
                    widget.initialTitle == null ? "Confirm" : "Save Changes",
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
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

  void _showAlertDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Error'),
          content: const Text('Please fill in both fields.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Close the dialog
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }
}