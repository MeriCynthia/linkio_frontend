import 'package:flutter/material.dart';
import '../models/LinkBlock.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class ProfileWithLinks extends StatefulWidget {
  const ProfileWithLinks({Key? key}) : super(key: key);

  @override
  _ProfileWithLinksState createState() => _ProfileWithLinksState();
}

class _ProfileWithLinksState extends State<ProfileWithLinks> {
  // To store the fetched LinkBlock data
  late Future<List<LinkBlock>> _linkBlocks;

  // Function to fetch LinkBlock data from the API
  Future<List<LinkBlock>> fetchLinkBlocks() async {
    final response = await http.get(Uri.parse(
        'https://8aa8-180-242-214-35.ngrok-free.app/api/link-blocks/mylink/2'));  // API to fetch link blocks with mylink_id=2

    if (response.statusCode == 200) {
      final List<dynamic> jsonData = json.decode(response.body)["data"];
      return jsonData.map((data) => LinkBlock.fromJson(data)).toList();
    } else {
      throw Exception('Failed to load links');
    }
  }

  @override
  void initState() {
    super.initState();
    _linkBlocks = fetchLinkBlocks();  // Fetch the data when the widget is initialized
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Profile with Links")),
      body: FutureBuilder<List<LinkBlock>>(
        future: _linkBlocks,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());  // Show loading spinner
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}', style: const TextStyle(color: Colors.red)),
            );  // Show error message
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No links available.'));
          } else {
            final linkBlocks = snapshot.data!;
            return ListView.builder(  // Removed Expanded here
              itemCount: linkBlocks.length,
              itemBuilder: (context, index) {
                final linkBlock = linkBlocks[index];
                return Card(
                  margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  child: ListTile(
                    title: Text(linkBlock.linkTitle ?? 'No title'),
                    subtitle: Text(linkBlock.url ?? 'No URL'),
                    onTap: () {
                      if (linkBlock.url != null && linkBlock.url!.isNotEmpty) {
                        // Open the link URL when tapped
                        _launchURL(linkBlock.url!);
                      }
                    },
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }

  // Method to launch the URL (use URL launcher package)
  void _launchURL(String url) {
    // Add url_launcher dependency for launching URLs in browser
    // e.g., https://pub.dev/packages/url_launcher
  }
}
