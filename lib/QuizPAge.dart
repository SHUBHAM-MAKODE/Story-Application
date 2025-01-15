import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter/services.dart';

class QuizPage extends StatefulWidget {
  final String storyId;

  QuizPage({required this.storyId});

  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  bool isLoading = true;
  List questions = [];
  int currentQuestion = 0;
  int score = 0;

  @override
  void initState() {
    super.initState();
    loadQuestions();
  }

  Future<void> loadQuestions() async {
    try {
      final String response =
          await rootBundle.loadString('assets/questions.json');
      final Map<String, dynamic> data = json.decode(response);
      setState(() {
        questions = data["Sheet1"]
            .where((question) => question['StoryID'] == widget.storyId)
            .toList();
        isLoading = false;
      });
    } catch (e) {
      print("Error loading questions: $e");
      setState(() {
        isLoading = false;
      });
    }
  }

  void answerQuestion(String selectedOption) {
    if (questions[currentQuestion]['CorrectAnswer'] == selectedOption) {
      score++;
    }
    if (currentQuestion + 1 < questions.length) {
      setState(() {
        currentQuestion++;
      });
    } else {
      showResult();
    }
  }

  void showResult() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Quiz Completed"),
        content: Text("Your score is $score out of ${questions.length}"),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context); // Close dialog
              Navigator.pop(context); // Return to story detail
            },
            child: Text("OK"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Quiz",
          style: TextStyle(fontSize: 26, fontWeight: FontWeight.w600),
        ),
        backgroundColor: Color.fromARGB(255, 224, 48, 255),
      ),
      body: Container(
        decoration: BoxDecoration(
            gradient:
                LinearGradient(colors: [Color(0xffa18cd1), Color(0xfffbc2eb)])),
        child: isLoading
            ? Center(child: CircularProgressIndicator())
            : questions.isEmpty
                ? Center(child: Text("No questions available for this story."))
                : Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Question ${currentQuestion + 1}/${questions.length}",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 20),
                        Container(
                          padding: EdgeInsets.all(16.0),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.black12,
                                  blurRadius: 8,
                                  spreadRadius: 2),
                            ],
                          ),
                          child: Text(
                            questions[currentQuestion]['Question'],
                            style: TextStyle(fontSize: 18),
                          ),
                        ),
                        SizedBox(height: 20),
                        ...["OptionA", "OptionB", "OptionC", "OptionD"]
                            .map<Widget>((option) => ListTile(
                                  title: Text(
                                    questions[currentQuestion][option],
                                    style: TextStyle(fontSize: 18),
                                  ),
                                  onTap: () => answerQuestion(
                                      questions[currentQuestion][option]),
                                ))
                            .toList(),
                      ],
                    ),
                  ),
      ),
    );
  }
}
