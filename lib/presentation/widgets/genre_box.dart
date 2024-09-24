import 'package:flutter/material.dart';

class GenreBox extends StatelessWidget {
  const GenreBox({super.key, required this.genre});

  final String genre;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 8.0),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
        decoration: BoxDecoration(
          color: Colors.grey[800],
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          genre,
          style: const TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
