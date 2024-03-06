import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AddQuestion extends StatefulWidget {
  const AddQuestion({Key? key}) : super(key: key);

  @override
  State<AddQuestion> createState() => _AddQuestionState();
}

class _AddQuestionState extends State<AddQuestion> {
  final TextEditingController _questionController = TextEditingController();
  final TextEditingController _option1Controller = TextEditingController();
  final TextEditingController _option2Controller = TextEditingController();
  final TextEditingController _option3Controller = TextEditingController();
  final TextEditingController _option4Controller = TextEditingController();
  String? _selectedAnswer;

  @override
  Widget build(BuildContext context) {
  final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Question"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextFormField(
              controller: _questionController,
              decoration: const InputDecoration(labelText: 'Question'),
            ),
            TextFormField(
              controller: _option1Controller,
              decoration: const InputDecoration(labelText: 'Option 1'),
            ),
            TextFormField(
              controller: _option2Controller,
              decoration: const InputDecoration(labelText: 'Option 2'),
            ),
            TextFormField(
              controller: _option3Controller,
              decoration: const InputDecoration(labelText: 'Option 3'),
            ),
            TextFormField(
              controller: _option4Controller,
              decoration: const InputDecoration(labelText: 'Option 4'),
            ),
            DropdownButtonFormField<String>(
              value: _selectedAnswer,
              onChanged: (String? value) {
                setState(() {
                  _selectedAnswer = value;
                });
              },
              items: const [
                DropdownMenuItem(
                    value: 'Option 1', child: Text('Option 1')),
                DropdownMenuItem(
                    value: 'Option 2', child: Text('Option 2')),
                DropdownMenuItem(
                    value: 'Option 3', child: Text('Option 3')),
                DropdownMenuItem(
                    value: 'Option 4', child: Text('Option 4')),
              ],
              decoration: const InputDecoration(labelText: 'Correct Answer'),
            ),
            SizedBox(height: screenHeight*0.05),
            ElevatedButton(
              onPressed: _addQuestion,
              child: const Text('Add Question'),
            ),
            SizedBox(height: screenHeight*0.05,),
            ElevatedButton(
              onPressed: (){Navigator.of(context).pop();},
              child: const Text('Back'),
            ),
          ],
        ),
      ),
    );
  }

  void _addQuestion() {
    final question = _questionController.text.trim();
    final option1 = _option1Controller.text.trim();
    final option2 = _option2Controller.text.trim();
    final option3 = _option3Controller.text.trim();
    final option4 = _option4Controller.text.trim();

    if (question.isNotEmpty &&
        option1.isNotEmpty &&
        option2.isNotEmpty &&
        option3.isNotEmpty &&
        option4.isNotEmpty &&
        _selectedAnswer != null) {
      // Determine the correct answer based on the selected option
      String correctAnswer;
      switch (_selectedAnswer) {
        case 'Option 1':
          correctAnswer = option1;
          break;
        case 'Option 2':
          correctAnswer = option2;
          break;
        case 'Option 3':
          correctAnswer = option3;
          break;
        case 'Option 4':
          correctAnswer = option4;
          break;
        default:
          correctAnswer = '';
      }

      FirebaseFirestore.instance.collection('questions').add({
        'question': question,
        'options': [option1, option2, option3, option4],
        'answer': correctAnswer, // Store the correct answer
      }).then((value) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Question added successfully')),
        );
        // Clear text fields
        _questionController.clear();
        _option1Controller.clear();
        _option2Controller.clear();
        _option3Controller.clear();
        _option4Controller.clear();
        setState(() {
          _selectedAnswer = null;
        });
      }).catchError((error) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to add question: $error')),
        );
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill in all fields')),
      );
    }
  }
}
