import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../widgets/change_title.dart';
import '../widgets/change_background.dart';
import '../widgets/bottom_nav.dart';  // Add this import
import 'manage_link.dart';

// Controller for managing state
class CustomScreenController extends GetxController {
  var title = Rxn<String>();
  var isBold = false.obs;
  var isItalic = false.obs;
  var textAlign = TextAlign.left.obs;
  var textColor = Colors.black.obs;
  var selectedFontFamily = "Poppins".obs;
  var backgroundImage = Rxn<String>();
  var currentIndex = 1.obs;  // Add this for bottom nav

  List<String> fontFamilies = [
    'Poppins',
    'Roboto',
    'Open Sans',
    'Arial',
    'Times New Roman'
  ];

  void updateTitle(String? newTitle) => title.value = newTitle;

  void updateStyle({
    required bool bold,
    required bool italic,
    required TextAlign align,
    required Color color,
    required String fontFamily,
  }) {
    isBold.value = bold;
    isItalic.value = italic;
    textAlign.value = align;
    textColor.value = color;
    selectedFontFamily.value = fontFamily;
  }

  void updateBackground(String? selectedImage) {
    backgroundImage.value = selectedImage;
  }

  void updateIndex(int index) {
    currentIndex.value = index;
  }
}

class CustomScreen extends StatelessWidget {
  CustomScreen({super.key});

  final controller = Get.put(CustomScreenController());

  void _showChangeBackgroundPopup(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return ChangeBackgroundDialog(
          currentImage: controller.backgroundImage.value,
          onConfirm: (String? selectedImage) {
            controller.updateBackground(selectedImage);
          },
        );
      },
    );
  }

  void _showChangeTitlePopup(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return ChangeTitleDialog(
          initialTitle: controller.title.value,
          onTitleChanged: controller.updateTitle,
          onStyleChanged: (bold, italic, align, color, fontFamily) {
            // Menggunakan null check pada fontFamily
            controller.updateStyle(
              bold: bold,
              italic: italic,
              align: align,
              color: color,
              fontFamily: fontFamily ?? 'Poppins', // Menggunakan nilai default jika null
            );
          },
        );
      },
    );
  }

  Widget _buildPreviewSection() {
    return Obx(() {
      return Container(
        height: 150,
        width: double.infinity,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(8),
          color: Colors.grey[300],
          image: controller.backgroundImage.value != null
              ? DecorationImage(
                  image: AssetImage(controller.backgroundImage.value!),
                  fit: BoxFit.cover,
                )
              : null,
        ),
        child: controller.backgroundImage.value == null
            ? const Center(
                child: Text(
                  "No Background Image",
                  style: TextStyle(color: Colors.grey),
                ),
              )
            : null,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Custom',
          style: TextStyle(
            fontSize: 25,
            color: Color(0xFF023574),
            fontWeight: FontWeight.w900,
          ),
        ),
        centerTitle: true,
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 16.0),
            child: Icon(
              Icons.notifications_none,
              color: Color(0xFF023574),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(  // Wrap with SingleChildScrollView
        child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "All your links, in one place!",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Color(0xFF023574),
              ),
            ),
            const SizedBox(height: 20),
            _buildButton(
              icon: Icons.image,
              label: "Change Background",
              onPressed: () => _showChangeBackgroundPopup(context),
            ),
            const SizedBox(height: 10),
            _buildButton(
              icon: Icons.title,
              label: "Change Title",
              onPressed: () => _showChangeTitlePopup(context),
            ),
            const SizedBox(height: 10),
            _buildButton(
              icon: Icons.link,
              label: "Manage Link",
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ManageLinkPage(),
                  ),
                );
              },
            ),
            const SizedBox(height: 20),
            const Text(
              "Let's take a look at your page...",
              style: TextStyle(
                fontSize: 13,
                color: Color(0xFF023574),
                fontWeight: FontWeight.w900,
              ),
            ),
            const SizedBox(height: 10),
            Container(
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF023574), Color(0xFF1C7B75)],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                ),
                borderRadius: BorderRadius.circular(8),
              ),
              child: ElevatedButton(
                onPressed: null, // Disabled
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  shadowColor: Colors.transparent,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular( 8),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    SizedBox(width: 8),
                    Text(
                      "Preview Page",
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            _buildPreviewSection(),
            Obx(() {
              return Container(
                width: double.infinity,
                child: controller.title.value != null
                    ? Text(
                        "Current Title: ${controller.title.value}",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: controller.isBold.value
                              ? FontWeight.bold
                              : FontWeight.normal,
                          fontStyle: controller.isItalic.value
                              ? FontStyle.italic
                              : FontStyle.normal,
                          color: controller.textColor.value,
                          fontFamily: controller.selectedFontFamily.value,
                        ),
                        textAlign: controller.textAlign.value,
                      )
                    : const Text(
                        "No Title Set",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Colors.grey,
                        ),
                      ),
              );
            })
          ],
        ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(bottom: 10.0, left: 10.0, right: 10.0),
        child: Obx(() => BottomNav(
          selectedIndex: controller.currentIndex.value,
          onItemTapped: (index) {
            controller.updateIndex(index);
            switch (index) {
              case 0:
                Navigator.pushNamed(context, '/home');
                break;
              case 1:
                Navigator.pushNamed(context, '/custom');
                break;
              case 2:
                Navigator.pushNamed(context, '/search');
                break;
              case 3:
                Navigator.pushNamed(context, '/my-link');
                break;
            }
          },
        )),
      ),
    );
  }

  Widget _buildButton({
    required IconData icon,
    required String label,
    required VoidCallback onPressed,
  }) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF023574),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: Colors.white, size: 20),
          const SizedBox(width: 10),
          Text(
            label,
            style: const TextStyle(
              fontSize: 13,
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}