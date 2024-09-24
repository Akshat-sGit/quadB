import 'package:flutter/material.dart';
import 'package:quadb/models/show_model.dart';

import '../screens/show_screen.dart';

class TopShowTile extends StatelessWidget {
  final ShowModel show;

  const TopShowTile({super.key, required this.show});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
      child: Container(
        width: double.infinity,
        height: 400, 
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(show.image ?? ''), 
            fit: BoxFit.cover,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      show.name ?? 'Unknown Show',
                      style: const TextStyle(
                        fontSize: 36,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  _buildGenreRow(),
                  _buildButtonRow(context),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildGenreRow() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: show.genres?.map((genre) {
              return Container(
                margin: const EdgeInsets.symmetric(horizontal: 4.0),
                padding: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(0.2), 
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  genre,
                  style: const TextStyle(color: Colors.white),
                ),
              );
            }).toList() ??
            [],
      ),
    );
  }

  Widget _buildButtonRow(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 24.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: ElevatedButton(
              onPressed: () {

              },
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4), 
                ),
                backgroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(
                  vertical: 8, 
                ),
              ),
              child: const Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment:
                    MainAxisAlignment.center, 
                children: [
                  Icon(Icons.play_arrow, color: Colors.black), 
                  SizedBox(width: 4), 
                  Text(
                    'Play',
                    style: TextStyle(color: Colors.black),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(width: 16), 
          Expanded(
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ShowScreen(show: show),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4), 
                ),
                backgroundColor: Colors.grey.withOpacity(0.2), 
                padding: const EdgeInsets.symmetric(
                  vertical: 8, 
                ),
              ),
              child: const Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment:
                    MainAxisAlignment.center, 
                children: [
                  Icon(Icons.info_outline_rounded,
                      color: Colors.white), 
                  SizedBox(width: 4), 
                  Text(
                    'Show Details',
                    style: TextStyle(color: Colors.white),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
