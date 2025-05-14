import 'dart:io';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class ImageCarousel extends StatelessWidget {
  const ImageCarousel({
    super.key,
    required this.filePaths,
    this.maxHeight = 400,
  });
  final List<String> filePaths;
  final double maxHeight;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(14.0),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          spacing: 8,
          mainAxisAlignment: MainAxisAlignment.center,
          children: filePaths.mapIndexed((index, filePath) {
            return Material(
              elevation: 3,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(0),
                child: GestureDetector(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (context) => Stack(
                        children: [
                          Dialog(
                            backgroundColor: Colors.transparent,
                            shape: Border.all(),
                            child: SizedBox(
                              child: Image.file(
                                errorBuilder: (context, error, stackTrace) =>
                                    const Center(
                                  child: Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Text("Media error"),
                                  ),
                                ),
                                File(filePath),
                                fit: BoxFit.fitWidth,
                              ),
                            ),
                          ),
                          Positioned(
                            top: -5,
                            right: -5,
                            child: Padding(
                              padding: const EdgeInsets.all(24.0),
                              child: IconButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                icon: const Icon(
                                  Icons.close,
                                  color: Colors.red,
                                  size: 30,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                  child: ConstrainedBox(
                    constraints: BoxConstraints(maxHeight: maxHeight),
                    child: Image.file(
                      errorBuilder: (context, error, stackTrace) =>
                          const Center(
                        child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text("Media error"),
                        ),
                      ),
                      File(filePath),
                      fit: BoxFit.cover,
                    ),
                  ).animate(delay: (index * 50).ms).fade(duration: 250.ms),
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
