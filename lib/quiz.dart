import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'answers.dart';

class Quiz extends StatefulWidget {
  const Quiz({Key? key}) : super(key: key);

  @override
  State<Quiz> createState() => QuizState();
}

class QuizState extends State<Quiz> {
  late Stream<QuerySnapshot> _questionsStream;
  late List<QueryDocumentSnapshot> _questions = [];
  late int _currentQuestionIndex = 0;
  String? _selectedOption;
  int _correctAnswersCount = 0; // Track correct answers count

  @override
  void initState() {
    super.initState();
    _questionsStream =
        FirebaseFirestore.instance.collection("questions").snapshots();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(title: const Text("quiz")),
      body: StreamBuilder(
        stream: _questionsStream,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            if (snapshot.hasData) {
              _questions = snapshot.data!.docs;
              return Column(
                children: [
                  ListTile(
                    leading: CircleAvatar(
                      child: Text("${_currentQuestionIndex + 1}"),
                    ),
                    title: Text(
                        "${_questions[_currentQuestionIndex]["question"]}",style: TextStyle(fontSize: screenWidth*0.055),),
                  ),
                  SizedBox(
                    height: screenHeight * 0.03,
                  ),
                  Column(
                    children: _buildOptions(),
                  ),
                  SizedBox(
                    height: screenHeight * 0.05,
                  ),
                  ElevatedButton(
                    onPressed: _goToNextQuestion,
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size(screenWidth * 0.8, screenHeight * 0.075),
                      backgroundColor: Colors.green,
                      foregroundColor: Colors.white,
                      textStyle: TextStyle(
                          fontSize: screenWidth * 0.05,
                          fontWeight: FontWeight.bold),
                    ),
                    child: const Text("Next"),
                  ),
                  SizedBox(height: screenHeight*0.05,),
                  ElevatedButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: const Text("Exit Quiz"),
                          content: const Text("Are you sure you want to exit?"),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop(); // Close the dialog
                              },
                              child: const Text("Cancel"),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop(); // Close the dialog
                                Navigator.of(context).pop(); // Pop the quiz screen
                              },
                              child: const Text("Exit"),
                            ),
                          ],
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size(screenWidth * 0.8, screenHeight * 0.075),
                      backgroundColor: Colors.red,
                      foregroundColor: Colors.white,
                    ),
                    child: Text("Exit",style: TextStyle(fontSize: screenWidth*0.05,fontWeight: FontWeight.bold),),
                  ),

                ],
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text("${snapshot.error}"),
              );
            }
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }

  List<Widget> _buildOptions() {
    final screenWidth = MediaQuery.of(context).size.width;
    List<Widget> options = [];
    List<dynamic> rawOptions = _questions[_currentQuestionIndex]["options"];
    for (int i = 0; i < rawOptions.length; i++) {
      options.add(
        Card(
          elevation: 3,
          margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          child: InkWell(
            onTap: () {
              setState(() {
                _selectedOption = rawOptions[i];
              });
            },
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Row(
                children: [
                  Radio<String>(
                    value: rawOptions[i],
                    groupValue: _selectedOption,
                    onChanged: (String? value) {
                      setState(() {
                        _selectedOption = value;
                      });
                    },
                  ),
                  Expanded(
                    child: Text(rawOptions[i],style: TextStyle(fontSize: screenWidth*0.04),),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    }
    return options;
  }

  void _goToNextQuestion() {
    // Get the correct answer from Firebase
    String correctAnswer = _questions[_currentQuestionIndex]["answer"];

    // Check if the selected option matches the correct answer
    bool isCorrect = (_selectedOption == correctAnswer);

    // Increment correct answers count if the selected option is correct
    if (isCorrect) {
      _correctAnswersCount++;
    }

    // Proceed to the next question
    setState(() {
      if (_currentQuestionIndex < _questions.length - 1) {
        _currentQuestionIndex++;
        _selectedOption = null; // Clear selected option for the next question
      } else {
        // Display the score at the end of all questions
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text("Quiz Finished"),
            content: Text(
                "Your score: $_correctAnswersCount / ${_questions.length}"),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(); // Close the dialog
                  // Reset quiz state to play again
                  setState(() {
                    _currentQuestionIndex = 0;
                    _correctAnswersCount = 0;
                    _selectedOption = null;
                  });
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const Answers(),
                  ));
                },
                child: const Text("View Answers"),
              ),
            ],
          ),
        );
      }
    });
  }
}
