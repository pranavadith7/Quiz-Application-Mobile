import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// ignore: camel_case_types
class Questions extends StatefulWidget {
  const Questions({super.key});

  @override
  State<Questions> createState() => _questionsState();
}

class _questionsState extends State<Questions> {
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: const Text("questions"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: screenHeight,
              child: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection("questions")
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.active) {
                    if (snapshot.hasData) {
                      return ListView.builder(
                        itemBuilder: (context, index) {
                          final questionData = snapshot.data!.docs[index];
                          final questionId = snapshot.data!.docs[index].id;
                          final question = questionData["question"];
                          final answer = questionData["answer"];
                          final options =
                              questionData["options"] as List<dynamic>;
                          final optionsWidgets =
                              options.asMap().entries.map<Widget>((entry) {
                            final optionNumber = entry.key + 1;
                            final optionText = entry.value as String;
                            return ListTile(
                              title: Text("$optionNumber. $optionText"),
                            );
                          }).toList();
                          return Card(
                            margin: EdgeInsets.symmetric(
                                vertical: screenHeight * 0.03,
                                horizontal: screenHeight * 0.02),
                            elevation: 3,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ListTile(
                                  leading: CircleAvatar(
                                    child: Text("${index + 1}"),
                                  ),
                                  title: Text(
                                    question,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold),
                                  ),
                                  trailing: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      // IconButton(
                                      //   icon: Icon(Icons.edit),
                                      //   onPressed: () {
                                      //     // Handle edit functionality
                                      //     // You can navigate to another screen for editing or show a dialog
                                      //     // Here, let's print the question ID for demonstration
                                      //     print(
                                      //         "Edit question with ID: $questionId");
                                      //   },
                                      // ),
                                      IconButton(
                                        icon: const Icon(Icons.delete),
                                        onPressed: () {
                                          showDialog(
                                            context: context,
                                            builder: (context) => AlertDialog(
                                              title: const Text("Confirm Delete"),
                                              content: const Text(
                                                  "Are you sure you want to delete this question?"),
                                              actions: [
                                                TextButton(
                                                  onPressed: () {
                                                    Navigator.pop(
                                                        context); // Close the dialog
                                                  },
                                                  child: const Text("Cancel"),
                                                ),
                                                TextButton(
                                                  onPressed: () {
                                                    // Handle delete functionality
                                                    FirebaseFirestore.instance
                                                        .collection("questions")
                                                        .doc(questionId)
                                                        .delete()
                                                        .then((value) {
                                                      Navigator.pop(
                                                          context); // Close the dialog
                                                    }).catchError((error) {
                                                    });
                                                  },
                                                  child: const Text("Delete"),
                                                ),
                                              ],
                                            ),
                                          );
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                                ...optionsWidgets,
                                Text(
                                  "\t\t\tAnswer: $answer",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: screenWidth * 0.042),
                                )
                              ],
                            ),
                          );
                        },
                        itemCount: snapshot.data!.docs.length,
                      );
                    } else if (snapshot.hasError) {
                      return Center(
                        child: Text(snapshot.error.toString()),
                      );
                    } else {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  } else {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
              ),
            ),
            SizedBox(height: screenHeight*0.05,),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).popUntil((route) {
                  return route.isFirst || route.settings.name == '/login';
                });
              },
              style: ElevatedButton.styleFrom(
                  minimumSize: Size(screenWidth * 0.7, screenHeight * 0.1),
                  textStyle: TextStyle(
                      fontSize: screenWidth * 0.05,
                      fontWeight: FontWeight.bold),
                  backgroundColor: Colors.red,
                  foregroundColor: Colors.white),
              child: const Text("Logout"),
            ),
          ],
        ),
      ),
    );
  }
}
