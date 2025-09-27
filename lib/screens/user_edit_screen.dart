import 'dart:io';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:pursenal/app/global/dimensions.dart';
import 'package:pursenal/core/models/domain/user.dart';
import 'package:pursenal/core/repositories/drift/user_drift_repository.dart';
import 'package:pursenal/utils/app_logger.dart';
import 'package:pursenal/viewmodels/app_viewmodel.dart';
import 'package:pursenal/viewmodels/user_viewmodel.dart';
import 'package:pursenal/widgets/shared/loading_body.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:path/path.dart' as p;

class UserEditScreen extends StatelessWidget {
  const UserEditScreen({
    super.key,
    required this.user,
  });
  final User user;

  @override
  Widget build(BuildContext context) {
    final userRepository =
        Provider.of<UserDriftRepository>(context, listen: false);

    final appViewmodel = Provider.of<AppViewmodel>(context);
    return ChangeNotifierProvider<UserViewmodel>(
      create: (context) => UserViewmodel(user, userRepository)..init(),
      child: Consumer<UserViewmodel>(
        builder: (context, viewmodel, child) {
          Future<void> pickImage(ImageSource imgSource) async {
            final ImagePicker picker = ImagePicker();
            final XFile? file = await picker.pickImage(source: imgSource);
            if (file != null) {
              final Directory appDir = await getApplicationSupportDirectory();
              final String securePath = p.join(appDir.path, "images");
              await Directory(securePath).create(recursive: true);
              String fileName = file.name;
              try {
                final String extension = fileName.split(".").last;
                fileName =
                    "${Random().nextInt(80000000) + 10000000}.$extension";
              } catch (e) {
                AppLogger.instance
                    .error("Cannot rename image ${file.name}", e.toString());
              }
              // Move the selected image to a secure directory
              final File newImage =
                  await File(file.path).copy(p.join(securePath, fileName));
              viewmodel.photoPath = newImage.path;
            }
          }

          return Scaffold(
            appBar: AppBar(
              title: Text(
                viewmodel.project?.name ?? "",
                overflow: TextOverflow.ellipsis,
              ),
            ),
            body: LoadingBody(
                loadingStatus: viewmodel.loadingStatus,
                errorText: viewmodel.errorText,
                widget: Center(
                  child: SizedBox(
                    width: smallWidth,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          Hero(
                            tag: "user_photo",
                            child: InkWell(
                              radius: 60,
                              customBorder: const CircleBorder(),
                              onTap: () {
                                if (appViewmodel.isPhone) {
                                  showDialog(
                                    context: context,
                                    builder: (context) => ImageOrGalleryDialog(
                                      openGallery: () {
                                        pickImage(ImageSource.gallery);
                                      },
                                      openCamera: () {
                                        pickImage(ImageSource.camera);
                                      },
                                    ),
                                  ).then((_) {
                                    PaintingBinding.instance.imageCache.clear();
                                    PaintingBinding.instance.imageCache
                                        .clearLiveImages();
                                    viewmodel.init();
                                  });
                                } else {
                                  pickImage(ImageSource.gallery).then((_) {
                                    PaintingBinding.instance.imageCache.clear();
                                    PaintingBinding.instance.imageCache
                                        .clearLiveImages();
                                    viewmodel.init();
                                  });
                                }
                              },
                              child: CircleAvatar(
                                radius: 60,
                                backgroundImage: viewmodel
                                            .photoPath.isNotEmpty &&
                                        File(viewmodel.photoPath).existsSync()
                                    ? Image.file(
                                        File(viewmodel.photoPath),
                                        key: ValueKey(viewmodel.photoPath),
                                      ).image
                                    : null,
                                child: viewmodel.photoPath.isEmpty ||
                                        !File(viewmodel.photoPath).existsSync()
                                    ? const Center(
                                        child: Icon(
                                          Icons.person,
                                          size: 42,
                                        ),
                                      )
                                    : null,
                              ),
                            ),
                          ),
                          const SizedBox(height: 46),
                          TextFormField(
                            initialValue: viewmodel.name,
                            decoration: InputDecoration(
                              labelText:
                                  AppLocalizations.of(context)?.nickName ??
                                      "Name",
                              border: const OutlineInputBorder(),
                            ),
                            onChanged: (value) {
                              viewmodel.name = value;
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                resetErrorTextFn: () {
                  viewmodel.resetErrorText();
                }),
          );
        },
      ),
    );
  }
}

class ImageOrGalleryDialog extends StatelessWidget {
  const ImageOrGalleryDialog({
    super.key,
    required this.openCamera,
    required this.openGallery,
  });

  final Function openGallery;
  final Function openCamera;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        height: 100,
        width: smallWidth,
        padding: const EdgeInsets.symmetric(horizontal: 32),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
                onPressed: () {
                  openCamera();
                  Navigator.of(context).pop();
                },
                icon: const Icon(
                  Icons.camera_alt,
                  size: 32,
                )),
            IconButton(
                onPressed: () {
                  openGallery();
                  Navigator.of(context).pop();
                },
                icon: const Icon(
                  Icons.photo_rounded,
                  size: 32,
                )),
          ],
        ),
      ),
    );
  }
}
