import 'package:app27/StoryDetailPage.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter/services.dart';

// Story List Page
class StoryListPage extends StatefulWidget {
  final String level;

  StoryListPage({required this.level});

  @override
  _StoryListPageState createState() => _StoryListPageState();
}

class _StoryListPageState extends State<StoryListPage> {
  bool isLoading = true;
  List stories = [];

  @override
  void initState() {
    super.initState();
    loadStories();
  }

  Future<void> loadStories() async {
    try {
      final String response =
          await rootBundle.loadString('assets/stories.json');
      final Map<String, dynamic> data = json.decode(response);
      setState(() {
        stories = data["Sheet1"]
            .where((story) => story['Level'] == widget.level)
            .toList();
        isLoading = false;
      });
    } catch (e) {
      print("Error loading stories: $e");
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "${widget.level} Stories",
          style: TextStyle(fontSize: 26, fontWeight: FontWeight.w600),
        ),
        backgroundColor: const Color.fromARGB(255, 224, 48, 255),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : Container(
              width: double.infinity,
              height: double.infinity,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xffa18cd1), Color(0xfffbc2eb)],
                ),
              ),
              child: Center(
                child: SizedBox(
                  width: 400,
                  child: ListView.builder(
                    padding: const EdgeInsets.all(16.0),
                    itemCount: stories.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 12.0),
                        child: Container(
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 249, 249, 249),
                            border: Border.all(
                              color: const Color.fromARGB(255, 223, 86, 250),
                            ),
                            borderRadius: BorderRadius.circular(17),
                          ),
                          child: ListTile(
                            // Story Image
                            leading: ClipRRect(
                              borderRadius: BorderRadius.circular(8.0),
                              child: Image.asset(
                                stories[index]['Image'],
                                width: 50,
                                height: 50,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) =>
                                    Icon(Icons.error, color: Colors.grey),
                              ),
                            ),
                            // Story Title
                            title: Text(
                              stories[index]['Title'],
                              style: TextStyle(
                                  fontSize: 22, fontWeight: FontWeight.w400),
                            ),
                            // Story Level
                            subtitle: Text(
                              "Level: ${stories[index]['Level']}",
                              style: TextStyle(color: Colors.grey[600]),
                            ),
                            // Navigate to Story Detail Page
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      StoryDetailPage(story: stories[index]),
                                ),
                              );
                            },
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
    );
  }
}
