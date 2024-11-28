import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/ApiResponse.dart';
import '../models/User.dart';
import '../models/MyLink.dart';
import '../models/LinkBlock.dart';
import '../constant.dart';

Future<ApiResponse> searchUserByUsername(String username) async {
  ApiResponse apiResponse = ApiResponse();
  try {
    final response = await http.get(
      Uri.parse('$userURL/search?username=$username'),
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
        'ngrok-skip-browser-warning': 'true',
      },
    );

    if (response.statusCode == 200) {
      var responseData = jsonDecode(response.body); // Parse the JSON response

      // Check if the 'user' key exists in the response
      if (responseData.containsKey('user')) {
        // Map the 'user' object into a User model
        var userJson = responseData['user'];
        apiResponse.data =
            User.fromJson(userJson); // Parse as a single User object
      } else {
        apiResponse.error = "User not found.";
      }
    } else {
      apiResponse.error = 'Error: ${response.statusCode}, ${response.body}';
    }
  } catch (e) {
    apiResponse.error = 'Server error: $e';
  }

  return apiResponse;
}

Future<User> fetchUserProfileByUsername(String username) async {
  final url =
      'https://8aa8-180-242-214-35.ngrok-free.app/api/user/search?username=$username'; // Ganti dengan URL API yang sesuai

  // Melakukan request HTTP untuk mendapatkan data profil
  final response = await http.get(
    Uri.parse(url),
    headers: {
      'Accept': 'application/json', // Setel header untuk menerima data JSON
    },
  );

  if (response.statusCode == 200) {
    // Jika status code 200, maka parse body JSON
    final Map<String, dynamic> data = jsonDecode(response.body);

    // Debugging log untuk melihat respons dari API
    print('Response data: $data'); // Check the raw response here

    // Pastikan data yang diperlukan tidak null
    if (data != null) {
      return User.fromJson(data); // Mengonversi data JSON ke objek User
    } else {
      throw Exception('User data is null');
    }
  } else {
    throw Exception('Failed to load user profile');
  }
}

Future<MyLink> fetchMyLinkByUsername(String username) async {
  final response = await http.get(
    Uri.parse('$mylinkURL/username/$username'),
    headers: {
      'Accept': 'application/json',
      'ngrok-skip-browser-warning': 'true',
    },
  );

  if (response.statusCode == 200) {
    return MyLink.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to load MyLink');
  }
}

// Fungsi untuk mengambil data LinkBlock berdasarkan mylinkId
Future<List<LinkBlock>> fetchLinkBlockById(int mylinkId) async {
  final url =
      'https://8aa8-180-242-214-35.ngrok-free.app/api/mylinks/$mylinkId/linkblocks'; // Ganti dengan URL yang sesuai

  // Melakukan HTTP GET request
  final response = await http.get(
    Uri.parse(url),
    headers: {
      'Accept': 'application/json', // Setel header untuk menerima data JSON
    },
  );

  if (response.statusCode == 200) {
    // Jika status code 200, parse body JSON menjadi list link blocks
    final List<dynamic> data = jsonDecode(response.body);
    print('Response data: $data'); // Debugging log

    // Mengonversi JSON menjadi List<LinkBlock>
    List<LinkBlock> linkBlocks =
        data.map((json) => LinkBlock.fromJson(json)).toList();

    return linkBlocks;
  } else {
    throw Exception('Failed to load link blocks');
  }
}
