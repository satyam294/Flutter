import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ProfilePage(),
    );
  }
}

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My First App"),
      ),

      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            Icon(
              Icons.person,
              size: 100,
            ),

            SizedBox(height: 20),

            Text(
              "Satyam Chand",
              style: TextStyle(
                fontSize: 24,
              ),
            ),

            Text(
              "Student",
              style: TextStyle(
                fontSize: 18,
              ),
            ),

            SizedBox(height: 20),

            Text("satyam@email.com"),

            Text("1234567890"),
          ],
        ),
      ),
    );
  }
}

