import 'package:flutter/material.dart';

class DishesPage extends StatelessWidget {
  const DishesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dishes'),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 170, 199, 213),
      ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Biryani'),
            Text('Paneer Butter Masala'),
            Text('Masala Dosa'),
          ],
        ),
      ),
    );
  }
}