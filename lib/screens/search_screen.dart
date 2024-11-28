import 'package:flutter/material.dart';
import '../models/User.dart';
import '../services/api_service.dart';
import '../models/ApiResponse.dart';
import '../widgets/search_input.dart';
import '../widgets/bottom_nav.dart';
import '../widgets/search_header.dart';
import 'link_page.dart'; // Import halaman MyLink

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  int _selectedIndex = 2;
  late Future<ApiResponse> _searchResults;
  final TextEditingController _searchController = TextEditingController();

  Future<void> _searchUserByUsername() async {
    final query = _searchController.text.trim();
    if (query.isEmpty) {
      setState(() {
        _searchResults = Future.value(ApiResponse()); // Clear results
      });
    } else {
      ApiResponse apiResponse = await searchUserByUsername(query);
      setState(() {
        _searchResults = Future.value(apiResponse);
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _searchResults = Future.value(ApiResponse());
    _searchController.addListener(_searchUserByUsername);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    switch (index) {
      case 0:
        Navigator.pushNamed(context, '/home');
        break;
      case 1:
        Navigator.pushNamed(context, '/custom');
        break;
      case 2:
        break; // Stay on the search screen
      case 3:
        Navigator.pushNamed(context, '/my-link');
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: Container(
            constraints: const BoxConstraints(maxWidth: 480),
            margin: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                const SizedBox(height: 48),
                const SearchHeader(),
                const SizedBox(height: 24),
                SearchInput(
                  controller: _searchController,
                  onSearch: _searchUserByUsername,
                ),
                const SizedBox(height: 20),
                Expanded(
                  child: FutureBuilder<ApiResponse>(
                    future: _searchResults,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasError ||
                          snapshot.data?.error != null) {
                        return Center(
                          child: Text(
                              'Error: ${snapshot.data?.error ?? "Unknown error"}'),
                        );
                      } else if (snapshot.data?.data == null) {
                        return const Center(child: Text('No user found.'));
                      } else {
                        final user = snapshot.data!.data as User;
                        return ListTile(
                          title: Text(user.name ?? "No name"),
                          subtitle: Text(user.username ?? "No username"),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => MyLinkScreen(
                                  username: user.username!,
                                ),
                              ),
                            );
                          },
                        );
                      }
                    },
                  ),
                ),
                const SizedBox(height: 20),
                BottomNav(
                  selectedIndex: _selectedIndex,
                  onItemTapped: _onItemTapped,
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
