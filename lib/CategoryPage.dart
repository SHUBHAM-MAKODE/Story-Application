import 'package:app27/StoryListPage.dart';
import 'package:flutter/material.dart';

class CategoryPage extends StatelessWidget {
  final List<String> categories = ["Beginner", "Intermediate", "Advance"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text("Lets start learning",
              style: TextStyle(fontSize: 26, fontWeight: FontWeight.w600)),
          backgroundColor: const Color.fromARGB(255, 224, 48, 255)),
      body: Container(
        decoration: BoxDecoration(
            gradient:
                LinearGradient(colors: [Color(0xffa18cd1), Color(0xfffbc2eb)])),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Container(
                  height: 400, child: Image.asset("assets/kartikslag.jpg")),
              Container(
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(16)),
                child: Text(
                  "Options available to practice",
                  textAlign: TextAlign.left,
                  style: TextStyle(fontSize: 24),
                ),
              ),
              SizedBox(
                height: 25,
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: categories.length,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        Container(
                          width: 300,
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 249, 249, 249),
                            border: Border.all(
                                color: const Color.fromARGB(255, 223, 86, 250)),
                            borderRadius: BorderRadius.circular(17),
                          ),
                          child: ListTile(
                            title: Text(categories[index]),
                            trailing: Icon(Icons.arrow_forward),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      StoryListPage(level: categories[index]),
                                ),
                              );
                            },
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        )
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
