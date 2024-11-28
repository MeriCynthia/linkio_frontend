import 'package:flutter/material.dart';
import '../models/User.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({Key? key}) : super(key: key);

  // Fetch user data from the API
  Future<User> fetchUser() async {
    final response = await http.get(Uri.parse(
        'https://8aa8-180-242-214-35.ngrok-free.app/api/user/search?username=janesmith'));

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      // Return the User object from the API response
      return User.fromJson(jsonData['user']);
    } else {
      throw Exception('Failed to fetch user data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<User>(
      future: fetchUser(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // Show loading indicator while waiting for data
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          // Display error message if something goes wrong
          return Center(
            child: Text(
              'Error: ${snapshot.error}',
              style: const TextStyle(color: Colors.red),
            ),
          );
        } else if (snapshot.hasData) {
          final user = snapshot.data!;  // Get the user data
          return _buildProfile(user);
        } else {
          return const Center(child: Text('No user data available'));
        }
      },
    );
  }

  // Widget to display the profile information
  Widget _buildProfile(User user) {
    return Column(
      children: [
        Container(
          width: double.infinity,
          color: Colors.black,
          padding: const EdgeInsets.symmetric(vertical: 71, horizontal: 17),
          child: Column(
            children: [
              Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.25),
                      blurRadius: 4,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: ClipOval(
                  child: Image.network(
                    'https://cdn.builder.io/api/v1/image/assets/TEMP/63d2d14edf8ef8a1e43cac232050c32b7466ca345a0ab33d7b873c112eb9c2d6?placeholderIfAbsent=true&apiKey=b465f8ed536247f9b4a77bf3b8c6fbbc', // Static URL for profile picture
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return const Icon(
                        Icons.person,
                        size: 50,
                        color: Colors.white,
                      );
                    },
                  ),
                ),
              ),
              const SizedBox(height: 12),
              Text(
                user.username ?? 'janesmith', // Fallback username
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                user.name ?? 'Jane Smith', // Fallback name
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}