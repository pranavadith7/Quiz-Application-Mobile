import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'quiz.dart';
import 'admin.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  LoginState createState() => LoginState();
}

class LoginState extends State<Login> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool isPasswordVisible = false;
  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    usernameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Quiz Application"),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SvgPicture.asset(
                "assets/images/login.svg",
                height: screenHeight * 0.3,
                width: screenWidth,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: TextField(
                  controller: usernameController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(screenWidth * 0.06),
                    ),
                    labelText: 'Username',
                    prefixIcon: const Icon(Icons.person),
                    labelStyle: TextStyle(
                      fontSize: screenWidth * 0.04,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey,
                    ),
                  ),
                  style: TextStyle(
                    fontSize: screenWidth * 0.05,
                  ),
                ),
              ),
              const SizedBox(height: 15),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: TextField(
                  controller: passwordController,
                  obscureText: !isPasswordVisible,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(screenWidth * 0.06),
                    ),
                    labelText: 'Password',
                    prefixIcon: const Icon(Icons.lock),
                    suffixIcon: IconButton(icon: Icon(isPasswordVisible ? Icons.visibility : Icons.visibility_off),
                    onPressed: (){
                      setState(() {
                        isPasswordVisible = !isPasswordVisible;
                      });
                    },),
                    labelStyle: TextStyle(
                      fontSize: screenWidth * 0.04,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey,
                    ),
                  ),
                  style: TextStyle(
                    fontSize: screenWidth * 0.05,
                  ),
                ),
              ),
              SizedBox(
                height: screenHeight * 0.05,
              ),
              ElevatedButton(
                onPressed: () {
                  _performLogin();
                },
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(screenWidth * 0.8, screenHeight * 0.08),
                  textStyle: TextStyle(
                    fontSize: screenWidth * 0.07,
                    fontWeight: FontWeight.bold,
                  ),
                  backgroundColor: Colors.green,
                  foregroundColor: Colors.white,
                ),
                child: const Text("Login"),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _performLogin() {
    String username = usernameController.text.trim();
    String password = passwordController.text.trim();

    if (username.isEmpty || password.isEmpty) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text("Error"),
          content: const Text("Please enter username and password."),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text("OK"),
            ),
          ],
        ),
      );
      return;
    }

    if (username == "admin" && password == "admin") {
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => const Admin()));
    } else {
      // Add username and password to Firestore
      FirebaseFirestore.instance.collection("users").add({
        "username": username,
        "password": password,
      });
      // Navigate to the quiz page
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => const Quiz()));
    }
  }
}
