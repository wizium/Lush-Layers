// ignore_for_file: use_build_context_synchronously

import 'package:async_wallpaper/async_wallpaper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import '/models/response_model.dart';
import '/main.dart';
import 'package:gallery_saver/gallery_saver.dart';

class PreviewWallpaper extends StatefulWidget {
  final PhotosModel model;
  const PreviewWallpaper({super.key, required this.model});

  @override
  State<PreviewWallpaper> createState() => _PreviewWallpaperState();
}

class _PreviewWallpaperState extends State<PreviewWallpaper> {
  bool isDownloaded = false;
  @override
  void initState() {
    // Make the system UI mode transparent when the widget is initialized
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
  }

  @override
  void dispose() {
    // Restore the system UI mode when the widget is disposed
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Image.network(
            widget.model.portraitLink,
            loadingBuilder: (context, child, loadingProgress) {
              if (loadingProgress == null) {
                return child;
              } else {
                return Center(
                  child: LoadingAnimationWidget.staggeredDotsWave(
                    color: Colors.green,
                    size: 100,
                  ),
                );
              }
            },
            height: height,
            width: width,
            fit: BoxFit.cover,
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: IconButton(
                    iconSize: 30,
                    color: Colors.red,
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.close_rounded),
                  ),
                ),
                SizedBox(
                  width: width * .75,
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        IconButton.filled(
                          iconSize: 40,
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (context) {
                                return SimpleDialog(
                                  contentPadding: const EdgeInsets.all(20),
                                  title: Text(
                                    widget.model.name,
                                  ),
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(20),
                                      child: Image(
                                        image: NetworkImage(
                                          widget.model.thumbnail,
                                        ),
                                        height: height * .35,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                        vertical: 10,
                                      ),
                                      child: Text(
                                        "Photo by ${widget.model.photoGrapher}",
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleLarge,
                                      ),
                                    ),
                                    ElevatedButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: Text(
                                        "Ok",
                                        style: Theme.of(context)
                                            .textTheme
                                            .headlineMedium,
                                      ),
                                    )
                                  ],
                                );
                              },
                            );
                          },
                          icon: const Icon(
                            Icons.info_outline_rounded,
                            color: Colors.white,
                          ),
                          style: ButtonStyle(
                            backgroundColor: MaterialStatePropertyAll(
                              Colors.grey.withOpacity(.5),
                            ),
                          ),
                        ),
                        IconButton.filled(
                          iconSize: 50,
                          onPressed: () async {
                            if (isDownloaded) {
                              Get.snackbar("Already Downloaded", "🤨");
                            } else {
                              isDownloaded = (await GallerySaver.saveImage(
                                widget.model.portraitLink,
                              ))!;
                              if (isDownloaded) {
                              Get.snackbar("Downloaded", "🎉");

                              } else {
                                Get.snackbar("Download Failed", "😭");
                              }
                            }

                            setState(() {});
                          },
                          icon: Icon(
                            isDownloaded
                                ? Icons.download_done_rounded
                                : Icons.downloading_rounded,
                            color: Colors.white,
                          ),
                          style: ButtonStyle(
                            backgroundColor: MaterialStatePropertyAll(
                              Colors.grey.withOpacity(.5),
                            ),
                          ),
                        ),
                        IconButton.filled(
                          iconSize: 40,
                          onPressed: () async {
                            await AsyncWallpaper.setWallpaperNative(
                              url: widget.model.portraitLink,
                            );
                          },
                          icon: const Icon(Icons.wallpaper_rounded),
                          style: ButtonStyle(
                            backgroundColor: MaterialStatePropertyAll(
                              Colors.grey.withOpacity(.5),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
