import 'package:flutter/material.dart';

import 'movies_page.dart';
import 'books_page.dart';
import 'dishes_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  void goToMovies(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const MoviesPage(),
      ),
    );
  }

  void goToBooks(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const BooksPage(),
      ),
    );
  }

  void goToDishes(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const DishesPage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Recommendations'),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 170, 199, 213),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [

            ElevatedButton(
              onPressed: () => goToMovies(context),
              child: const Text('Movie Recommendations'),
            ),

            ElevatedButton(
              onPressed: () => goToBooks(context),
              child: const Text('Book Recommendations'),
            ),

            ElevatedButton(
              onPressed: () => goToDishes(context),
              child: const Text('Dish Recommendations'),
            ),
          ],
        ),
      ),
    );
  }
}