import 'package:flutter/material.dart';
import 'package:palette_generator/palette_generator.dart';
import 'package:quadb/constants.dart';
import 'package:quadb/models/show_model.dart';
import 'package:quadb/presentation/widgets/genre_box.dart';

class ShowScreen extends StatefulWidget {
  const ShowScreen({super.key, required this.show});

  final ShowModel show;

  @override
  State<ShowScreen> createState() => _ShowScreenState();
}

class _ShowScreenState extends State<ShowScreen> {
  Color dominantColor = Colors.black;

  void extractDominantColor() async {
    PaletteGenerator paletteGenerator =
        await PaletteGenerator.fromImageProvider(
      NetworkImage(widget.show.image ?? ''),
    );

    setState(() {
      dominantColor = paletteGenerator.dominantColor?.color ?? Colors.black;
    });
  }

  String cleanSummary(String rawSummary) {
    String cleanedSummary = rawSummary.replaceAll(RegExp(r'<\/?p>'), '');

    cleanedSummary = cleanedSummary.replaceAllMapped(
      RegExp(r'<b>(.*?)<\/b>'),
      (match) =>
          '**${match.group(1)}**', 
    );

    return cleanedSummary;
  }

  @override
  void initState() {
    super.initState();
    extractDominantColor();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              dominantColor.withOpacity(0.6), 
              Colors.black, 
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: MediaQuery.of(context).padding.top,
                color: dominantColor,
              ),
              Container(
                height: MediaQuery.of(context).size.height * 0.7,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(
                        widget.show.image ?? 'https://via.placeholder.com/150'),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Stack(
                  children: [

                    Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Colors.black.withOpacity(
                                0.5), 
                            Colors.transparent,
                          ],
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                        ),
                      ),
                    ),
                    // Back button
                    Positioned(
                      top: 16,
                      child: IconButton(
                        padding: EdgeInsets.zero,
                        icon: const Icon(
                          Icons.chevron_left,
                          color: Colors.white, 
                          size: 30, 
                        ),
                        onPressed: () {
                          Navigator.pop(context); 
                        },
                      ),
                    ),
                    
                    Positioned(
                      bottom: 16, 
                      left: 16,
                      right: 16,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.show.name ?? 'Show Name',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 36,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(
                              height: 8), 
                          Row(
                            children: [
                              Expanded(
                                child: ElevatedButton(
                                  onPressed: () {

                                  },
                                  style: ElevatedButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(
                                          4), // Rounded corners
                                    ),
                                    backgroundColor: primaryRed,
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 8,
                                    ),
                                  ),
                                  child: const Row(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment
                                        .center, 
                                    children: [
                                      Icon(Icons.play_arrow,
                                          color: Colors.white), 
                                      SizedBox(
                                          width: 4), 
                                      Text(
                                        'Play',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: ElevatedButton(
                                  onPressed: () {
                                  },
                                  style: ElevatedButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(
                                          4), 
                                    ),
                                    backgroundColor: Colors.white,
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 8, 
                                    ),
                                  ),
                                  child: const Row(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment
                                        .center,
                                    children: [
                                      Icon(Icons.download,
                                          color: Colors.black),
                                      SizedBox(
                                          width:
                                              4), 
                                      Text(
                                        'Download',
                                        style: TextStyle(color: Colors.black),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 16.0, vertical: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: widget.show.genres!
                          .map((genre) => GenreBox(genre: genre))
                          .toList(),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        const Icon(
                          Icons.access_time,
                          color: Colors.white,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          '${widget.show.runtime} mins',
                          style: const TextStyle(
                              color: Colors.white, fontSize: 16),
                        ),
                        const Text(
                          '  |  ',
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                        Text(
                          'IMDb ${widget.show.rating}', 
                          style: const TextStyle(
                              color: Colors.white, fontSize: 16),
                        ),
                        const Text(
                          '  |  ',
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                        Text('${widget.show.language}',
                            style: const TextStyle(
                                color: Colors.white, fontSize: 16)),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Text(
                      cleanSummary(widget.show.summary ??
                          'No summary available'), 
                      style: const TextStyle(color: Colors.white, fontSize: 16),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).padding.bottom,
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

