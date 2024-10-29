import 'package:flutter/material.dart';

class MovieCategoriesInfo extends StatelessWidget {
  final List<String> categories;

  const MovieCategoriesInfo({super.key, required this.categories});

  @override
  Widget build(BuildContext context) {
    return Center( // Centering the widget
      child: SizedBox(
        width: 350,
        child: Card(
          color: Colors.white.withOpacity(0.25),
          elevation: 0,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: SizedBox(
              height: 40,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: categories.length, // Dynamically set the item count
                itemBuilder: (context, index) {
                  return Container(
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.25),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Center(
                      child: Text(
                        categories[index], // Access category dynamically
                        style: const TextStyle(
                          color: Colors.white, // Text color
                          fontWeight: FontWeight.bold, // Font weight
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
