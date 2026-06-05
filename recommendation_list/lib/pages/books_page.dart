import 'package:flutter/material.dart';

class BooksPage extends StatelessWidget {
  const BooksPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Books'),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 170, 199, 213),
      ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Atomic Habits'),
            Text('Deep Work'),
            Text('Clean Code'),
          ],
        ),
      ),
    );
  }
}