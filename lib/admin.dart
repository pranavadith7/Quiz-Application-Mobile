import 'package:flutter/material.dart';
import 'users.dart';
import 'questions.dart';
import 'add_question.dart';

class Admin extends StatelessWidget {
  const Admin({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("admin"),
        ),
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const AddQuestion(),
                    ));
                  },
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(screenWidth * 0.8, screenHeight * 0.1),
                    textStyle: TextStyle(fontSize: screenWidth * 0.05, fontWeight: FontWeight.bold),
                  ),
                  child: const Text("Add Question"),
                ),
                SizedBox(
                  height: screenHeight * 0.03,
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const Questions(),
                    ));
                  },
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(screenWidth * 0.8, screenHeight * 0.1),
                    textStyle: TextStyle(fontSize: screenWidth * 0.05, fontWeight: FontWeight.bold),
                  ),
                  child: const Text("View Questions"),
                ),
                SizedBox(
                  height: screenHeight * 0.03,
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const users(),
                    ));
                  },
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(screenWidth * 0.8, screenHeight * 0.1),
                    textStyle: TextStyle(fontSize: screenWidth * 0.05, fontWeight: FontWeight.bold),
                  ),
                  child: const Text("View Users"),
                ),
                SizedBox(
                  height: screenHeight * 0.03,
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  style: ElevatedButton.styleFrom(
                      minimumSize: Size(screenWidth * 0.8, screenHeight * 0.1),
                      textStyle: TextStyle(fontSize: screenWidth * 0.05, fontWeight: FontWeight.bold),
                      backgroundColor: Colors.red,
                      foregroundColor: Colors.white),
                  child: const Text("Logout"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
