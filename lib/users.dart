import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class users extends StatefulWidget {
  const users({super.key});

  @override
  State<users> createState() => _usersState();
}

class _usersState extends State<users> {
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: const Text("users"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: screenHeight,
              child: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection("users")
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.active) {
                    if (snapshot.hasData) {
                      return ListView.builder(
                        itemBuilder: (context, index) {
                          return ListTile(
                            leading: CircleAvatar(
                              child: Text("${index + 1}"),
                            ),
                            title:
                                Text("${snapshot.data!.docs[index]["username"]}"),
                            subtitle:
                                Text("${snapshot.data!.docs[index]["password"]}"),
                          );
                        },
                        itemCount: snapshot.data!.docs.length,
                      );
                    } else if (snapshot.hasError) {
                      return Center(
                        child: Text("${snapshot.hasError.toString()}"),
                      );
                    } else {
                      return const Center(
                        child: Text("No Data Found"),
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
          ],
        ),
      ),
    );
  }
}
