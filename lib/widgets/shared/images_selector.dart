import 'dart:io';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pursenal/utils/app_logger.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:path/path.dart' as p;

class ImagesSelector extends StatelessWidget {
  const ImagesSelector({
    super.key,
    required this.paths,
    required this.addPathFn,
    required this.deletePathFn,
  });

  final List<String> paths;
  final Function(String) addPathFn;
  final Function(String) deletePathFn;

  @override
  Widget build(BuildContext context) {
    Future<void> pickImages() async {
      final ImagePicker picker = ImagePicker();
      final List<XFile> pickedFiles = await picker.pickMultiImage();

      if (pickedFiles.isNotEmpty) {
        for (XFile file in pickedFiles) {
          // Create a secure directory path based on the platform
          final Directory appDir = await getApplicationSupportDirectory();
          final String securePath = p.join(appDir.path, "images");
          await Directory(securePath).create(recursive: true);
          String fileName = file.name;
          try {
            final String extension = fileName.split(".").last;
            fileName = "${Random().nextInt(80000000) + 10000000}.$extension";
          } catch (e) {
            AppLogger.instance
                .error("Cannot rename image ${file.name}", e.toString());
          }
          // Move the selected image to a secure directory
          final File newImage =
              await File(file.path).copy(p.join(securePath, fileName));
          addPathFn(newImage.path);
        }
      }
    }

    Future<void> deleteImage(String path) async {
      try {
        final File file = File(path);
        if (await file.exists()) {
          await file.delete();
        }
      } catch (e) {
        AppLogger.instance.error('Error deleting image: $e');
      }
    }

    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          child: InputDecorator(
            decoration: InputDecoration(
                labelText: AppLocalizations.of(context)!.addPhotos,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                )),
            child: Wrap(
              crossAxisAlignment: WrapCrossAlignment.center,
              runAlignment: WrapAlignment.center,
              children: [
                ...paths.map((i) {
                  return Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: SizedBox(
                      width: 60,
                      height: 60,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(5),
                        child: Stack(
                          alignment: Alignment.topRight,
                          children: [
                            SizedBox(
                              width: 60,
                              height: 60,
                              child: Image.file(
                                File(i),
                                fit: BoxFit.cover,
                              ),
                            ),
                            Positioned(
                              top: -5,
                              right: -5,
                              child: IconButton(
                                onPressed: () {
                                  deletePathFn(i);
                                  deleteImage(i);
                                },
                                icon: const Icon(
                                  Icons.close,
                                  color: Colors.red,
                                  size: 20,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                }),
                Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: SizedBox(
                    height: 60,
                    width: 60,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        elevation: 1,
                        padding: EdgeInsets.zero,
                      ),
                      onPressed: () {
                        pickImages();
                      },
                      child: const Icon(
                        Icons.add,
                        color: Colors.white,
                        size: 28,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
