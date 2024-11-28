import 'package:flutter/material.dart';
import '../models/MyLink.dart';
import '../services/api_service.dart';
import '../models/User.dart';

class MyLinkScreen extends StatefulWidget {
  final String username;

  const MyLinkScreen({Key? key, required this.username}) : super(key: key);

  @override
  _MyLinkScreenState createState() => _MyLinkScreenState();
}

class _MyLinkScreenState extends State<MyLinkScreen> {
  late Future<User> _userProfile;

  // Fungsi untuk mengambil data profil pengguna
  Future<User> _fetchUserProfile(String username) async {
    final response = await fetchUserProfileByUsername(
        username); // Fungsi API untuk mendapatkan profil
    return response;
  }

  @override
  void initState() {
    super.initState();
    _userProfile = _fetchUserProfile(
        widget.username); // Memanggil API untuk profil pengguna
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("${widget.username}'s Profile and Links")),
      body: FutureBuilder<User>(
        future: _userProfile,
        builder: (context, userSnapshot) {
          // Jika data profil pengguna sedang dimuat
          if (userSnapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (userSnapshot.hasError) {
            return Center(child: Text("Error: ${userSnapshot.error}"));
          } else if (!userSnapshot.hasData) {
            return const Center(child: Text("User not found."));
          } else {
            final user = userSnapshot.data! as User;

            // Setelah profil pengguna dimuat, tampilkan info pengguna
            return ListView(
              children: [
                // Tampilkan Profil Pengguna
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    children: [
                      const SizedBox(width: 16),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            user.name ??
                                'No name', // Menampilkan 'No name' jika nama null
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          Text(
                              user.username ??
                                  'No username', // Menampilkan 'No username' jika username null
                              style: TextStyle(color: Colors.grey)),
                          Text(
                              user.email ??
                                  'No email', // Menampilkan 'No username' jika username null
                              style: TextStyle(color: Colors.grey)),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            );
          }
        },
      ),
    );
  }
}
