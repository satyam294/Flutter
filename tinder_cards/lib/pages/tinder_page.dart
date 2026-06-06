import 'package:flutter/material.dart';
import 'package:appinio_swiper/appinio_swiper.dart';

import '../models/recommendation.dart';

class TinderPage extends StatefulWidget {
  const TinderPage({super.key});

  @override
  State<TinderPage> createState() => _TinderPageState();
}

class _TinderPageState extends State<TinderPage> {

  final List<Recommendation> items = [
    Recommendation(
      title: "Interstellar",
      category: "Movie",
      color: const Color.fromARGB(255, 118, 150, 214),
    ),

    Recommendation(
      title: "Atomic Habits",
      category: "Book",
      color: const Color.fromARGB(255, 186, 243, 153),
    ),

    Recommendation(
      title: "Biryani",
      category: "Dish",
      color: const Color.fromARGB(255, 252, 180, 128),
    ),

    Recommendation(
      title: "Inception",
      category: "Movie",
      color: const Color.fromARGB(255, 247, 236, 132),
    ),

    Recommendation(
      title: "Deep Work",
      category: "Book",
      color: const Color.fromARGB(255, 236, 161, 233),
    ),
  ];

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text("Swipe Recommendations"),
      ),

      body: Padding(
        padding: const EdgeInsets.all(16),

        child: AppinioSwiper(
          cardCount: items.length,

          cardBuilder: (
            context,
            index,
          ) {
            final item = items[index];

            return Card(
              color: item.color,
              child: Center(
                child: Column(
                  mainAxisAlignment:
                      MainAxisAlignment.center,

                  children: [

                    Text(
                      item.category,
                      style: const TextStyle(
                        fontSize: 18,
                      ),
                    ),

                    const SizedBox(height: 10),

                    Text(
                      item.title,
                      style: const TextStyle(
                        fontSize: 28,
                        fontWeight:
                            FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}