import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:wallpaper_app/theme.dart';
import '/models/response_model.dart';

class PreviewWallpaper extends StatefulWidget {
  final PhotosModel model;
  const PreviewWallpaper({super.key, required this.model});

  @override
  State<PreviewWallpaper> createState() => _PreviewWallpaperState();
}

class _PreviewWallpaperState extends State<PreviewWallpaper> {
  bool isVisible = true;

  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
  }

  @override
  void dispose() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
        return Scaffold(
          extendBodyBehindAppBar: true,
          body: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              InkWell(
                child: Image.network(
                  widget.model.portraitLink,
                  gaplessPlayback: true,
                  frameBuilder:
                      (context, child, frame, wasSynchronouslyLoaded) {
                    return child;
                  },
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) {
                      return child;
                    } else {
                      return Center(
                        child: LoadingAnimationWidget.threeRotatingDots(
                          color: Theme.of(context).colorScheme.inversePrimary,
                          size: 100,
                        ),
                      );
                    }
                  },
                  height: double.infinity,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
                onTap: () {
                  isVisible = !isVisible;
                  setState(() {});
                },
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Visibility(
                  visible: isVisible,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      InkWell(
                        onTap: () {
                          Get.back();
                        },
                        child: Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.primary,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Icon(
                            Iconsax.arrow_left_2,
                            color: Theme.of(context).colorScheme.surface,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Align(
                          alignment: Alignment.bottomCenter,
                          child: Container(
                            decoration: BoxDecoration(
                              color: Theme.of(context)
                                  .colorScheme
                                  .inversePrimary
                                  .withOpacity(.5),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            height: 150,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: BackdropFilter(
                                filter:
                                    ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                                child: Align(
                                  alignment: Alignment.bottomCenter,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: gPadding,
                                      vertical: 20,
                                    ),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 7),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "Free Wallpaper",
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .titleLarge!
                                                    .merge(
                                                      const TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                              ),
                                              Row(
                                                children: [
                                                  Text(
                                                    "1720 x 3480",
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .bodyLarge!
                                                        .merge(
                                                          const TextStyle(
                                                            color: Colors.white,
                                                          ),
                                                        ),
                                                  ),
                                                  const SizedBox(width: 20),
                                                  Text(
                                                    "JPG",
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .bodyLarge!
                                                        .merge(
                                                          const TextStyle(
                                                            color: Colors.white,
                                                          ),
                                                        ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          children: [
                                            IconButton(
                                              onPressed: () {},
                                              icon: const Icon(
                                                CupertinoIcons
                                                    .arrowshape_turn_up_right,
                                                size: 25,
                                              ),
                                            ),
                                            IconButton(
                                              onPressed: () {
                                                isVisible = false;
                                                setState(() {});
                                                showModalBottomSheet(
                                                  backgroundColor:
                                                      Colors.transparent,
                                                  barrierColor:
                                                      Colors.transparent,
                                                  enableDrag: false,
                                                  context: context,
                                                  builder: (context) {
                                                    return BottomSheet(
                                                      enableDrag: false,
                                                      backgroundColor:
                                                          Colors.transparent,
                                                      onClosing: () {},
                                                      builder: (context) {
                                                        return Container(
                                                          height: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .height *
                                                              .38,
                                                          width: MediaQuery.of(
                                                                  context)
                                                              .size
                                                              .width,
                                                          margin:
                                                              const EdgeInsets
                                                                  .all(
                                                                  gPadding),
                                                          decoration:
                                                              BoxDecoration(
                                                            color: Theme.of(
                                                                    context)
                                                                .colorScheme
                                                                .inversePrimary
                                                                .withOpacity(
                                                                    .5),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                              20,
                                                            ),
                                                          ),
                                                          child: ClipRRect(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        20),
                                                            child:
                                                                BackdropFilter(
                                                              filter:
                                                                  ImageFilter
                                                                      .blur(
                                                                sigmaX: 20.0,
                                                                sigmaY: 20.0,
                                                              ),
                                                              child: Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                        .all(
                                                                        20.0),
                                                                child: Column(
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                    Row(
                                                                      children: [
                                                                        Column(
                                                                          mainAxisAlignment:
                                                                              MainAxisAlignment.start,
                                                                          crossAxisAlignment:
                                                                              CrossAxisAlignment.start,
                                                                          children: [
                                                                            Text(
                                                                              "Info",
                                                                              style: Theme.of(context).textTheme.titleLarge!.merge(
                                                                                    const TextStyle(
                                                                                      fontWeight: FontWeight.bold,
                                                                                      color: Colors.white,
                                                                                    ),
                                                                                  ),
                                                                            ),
                                                                            const SizedBox(height: 5),
                                                                            Text(
                                                                              "Type",
                                                                              style: Theme.of(context).textTheme.bodyLarge!.merge(
                                                                                    const TextStyle(
                                                                                      color: Colors.white,
                                                                                    ),
                                                                                  ),
                                                                            ),
                                                                            const SizedBox(height: 5),
                                                                            Text(
                                                                              "Resolution",
                                                                              style: Theme.of(context).textTheme.bodyLarge!.merge(
                                                                                    const TextStyle(
                                                                                      color: Colors.white,
                                                                                    ),
                                                                                  ),
                                                                            ),
                                                                          ],
                                                                        ),
                                                                        const SizedBox(
                                                                            width:
                                                                                30),
                                                                        Column(
                                                                          mainAxisAlignment:
                                                                              MainAxisAlignment.start,
                                                                          crossAxisAlignment:
                                                                              CrossAxisAlignment.start,
                                                                          children: [
                                                                            Text(
                                                                              "",
                                                                              style: Theme.of(context).textTheme.titleLarge!.merge(
                                                                                    const TextStyle(
                                                                                      fontWeight: FontWeight.bold,
                                                                                      color: Colors.white,
                                                                                    ),
                                                                                  ),
                                                                            ),
                                                                            const SizedBox(height: 5),
                                                                            Text(
                                                                              "JPG",
                                                                              style: Theme.of(context).textTheme.bodyLarge!.merge(
                                                                                    const TextStyle(
                                                                                      color: Colors.white,
                                                                                    ),
                                                                                  ),
                                                                            ),
                                                                            const SizedBox(height: 5),
                                                                            Text(
                                                                              "1720 x 3840",
                                                                              style: Theme.of(context).textTheme.bodyLarge!.merge(
                                                                                    const TextStyle(
                                                                                      color: Colors.white,
                                                                                    ),
                                                                                  ),
                                                                            ),
                                                                          ],
                                                                        ),
                                                                      ],
                                                                    ),
                                                                    const Divider(
                                                                      color: Colors
                                                                          .white,
                                                                      thickness:
                                                                          .5,
                                                                    ),
                                                                    Text(
                                                                      "Colors",
                                                                      style: Theme.of(
                                                                              context)
                                                                          .textTheme
                                                                          .titleLarge!
                                                                          .merge(
                                                                            const TextStyle(
                                                                              fontWeight: FontWeight.bold,
                                                                              color: Colors.white,
                                                                            ),
                                                                          ),
                                                                    ),
                                                                    Text(
                                                                      "Tap to copy color",
                                                                      style: Theme.of(
                                                                              context)
                                                                          .textTheme
                                                                          .bodyLarge!
                                                                          .merge(
                                                                            const TextStyle(
                                                                              color: Colors.white,
                                                                            ),
                                                                          ),
                                                                    ),
                                                                    const SizedBox(
                                                                        height:
                                                                            5),
                                                                    GridView
                                                                        .builder(
                                                                      shrinkWrap:
                                                                          true,
                                                                      physics:
                                                                          const NeverScrollableScrollPhysics(),
                                                                      gridDelegate:
                                                                          const SliverGridDelegateWithFixedCrossAxisCount(
                                                                        crossAxisCount:
                                                                            3,
                                                                        childAspectRatio:
                                                                            2.5,
                                                                        crossAxisSpacing:
                                                                            5,
                                                                        mainAxisSpacing:
                                                                            5,
                                                                      ),
                                                                      itemCount:
                                                                          6,
                                                                      itemBuilder:
                                                                          (
                                                                        context,
                                                                        index,
                                                                      ) {
                                                                        return InkWell(
                                                                          onTap:
                                                                              () {
                                                                            Clipboard.setData(
                                                                              ClipboardData(
                                                                                text: widget.model.portraitLink,
                                                                              ),
                                                                            );
                                                                          },
                                                                          child:
                                                                              Container(
                                                                            decoration:
                                                                                BoxDecoration(
                                                                              color: Colors.red,
                                                                              borderRadius: BorderRadius.circular(
                                                                                30,
                                                                              ),
                                                                            ),
                                                                            child:
                                                                                const Center(
                                                                              child: Text(
                                                                                "#000000",
                                                                                style: TextStyle(
                                                                                  color: Colors.black,
                                                                                ),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        );
                                                                      },
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        );
                                                      },
                                                    );
                                                  },
                                                );
                                              },
                                              icon: const Icon(
                                                Icons.info_outline_rounded,
                                                size: 25,
                                              ),
                                            ),
                                            IconButton(
                                              onPressed: () {},
                                              icon: const Icon(
                                                CupertinoIcons
                                                    .arrow_down_circle,
                                                size: 25,
                                              ),
                                            ),
                                            IconButton(
                                              onPressed: () {
                                                isVisible = false;
                                                setState(() {});
                                                showModalBottomSheet(
                                                  barrierColor:
                                                      Colors.transparent,
                                                  backgroundColor:
                                                      Colors.transparent,
                                                  enableDrag: false,
                                                  context: context,
                                                  builder: (context) {
                                                    return Container(
                                                      margin:
                                                          const EdgeInsets.all(
                                                              gPadding),
                                                      height: Get.height * .25,
                                                      width: Get.width,
                                                      decoration: BoxDecoration(
                                                        color: Theme.of(context)
                                                            .colorScheme
                                                            .inversePrimary
                                                            .withOpacity(.5),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(
                                                          20,
                                                        ),
                                                      ),
                                                      child: ClipRRect(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(20),
                                                        child: BackdropFilter(
                                                          filter:
                                                              ImageFilter.blur(
                                                            sigmaX: 20.0,
                                                            sigmaY: 20.0,
                                                          ),
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(20.0),
                                                            child: Column(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceEvenly,
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .center,
                                                              children: [
                                                                Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .spaceBetween,
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .center,
                                                                  children: [
                                                                    Text(
                                                                      "Remix Wallpaper",
                                                                      style: Theme.of(
                                                                              context)
                                                                          .textTheme
                                                                          .titleLarge!,
                                                                    ),
                                                                    const Icon(Icons
                                                                        .refresh_rounded)
                                                                  ],
                                                                ),
                                                                Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .spaceEvenly,
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .center,
                                                                  children: [
                                                                    const Icon(
                                                                      Iconsax
                                                                          .colorfilter,
                                                                    ),
                                                                    Slider(
                                                                        value:
                                                                            1,
                                                                        onChanged:
                                                                            (value) {})
                                                                  ],
                                                                ),
                                                                Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .spaceEvenly,
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .center,
                                                                  children: [
                                                                    const Icon(
                                                                      Icons
                                                                          .blur_on_rounded,
                                                                    ),
                                                                    Slider(
                                                                        value:
                                                                            1,
                                                                        onChanged:
                                                                            (value) {})
                                                                  ],
                                                                )
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    );
                                                  },
                                                );
                                              },
                                              icon: const Icon(
                                                CupertinoIcons.paintbrush,
                                                size: 25,
                                              ),
                                            ),
                                            IconButton(
                                              onPressed: () {},
                                              icon: const Icon(
                                                CupertinoIcons.heart,
                                                size: 25,
                                              ),
                                            ),
                                            Expanded(
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    right: 8),
                                                child: Align(
                                                  alignment:
                                                      Alignment.bottomRight,
                                                  child: FloatingActionButton(
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              40),
                                                    ),
                                                    onPressed: () async {
                                                      Get.dialog(
                                                        Dialog(
                                                          backgroundColor: Theme
                                                                  .of(context)
                                                              .colorScheme
                                                              .inversePrimary,
                                                          child: Container(
                                                            margin:
                                                                const EdgeInsets
                                                                    .all(20),
                                                            height: 300,
                                                            width: Get.width,
                                                            child: Column(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .start,
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .center,
                                                              children: [
                                                                Icon(
                                                                  Icons
                                                                      .wallpaper_rounded,
                                                                  color: Theme.of(
                                                                          context)
                                                                      .colorScheme
                                                                      .primary,
                                                                  size: 35,
                                                                ),
                                                                const SizedBox(
                                                                    height: 10),
                                                                Text(
                                                                  "Set wallpaper on",
                                                                  style: Theme.of(
                                                                          context)
                                                                      .textTheme
                                                                      .headlineSmall,
                                                                ),
                                                                const SizedBox(
                                                                  height: 10,
                                                                ),
                                                                Container(
                                                                  decoration: BoxDecoration(
                                                                    borderRadius: BorderRadius.circular(10)
                                                                  ),
                                                                  height: 60,
                                                                  width:
                                                                      Get.width,
                                                                  child:
                                                                      ElevatedButton(
                                                                    onPressed:
                                                                        () {},
                                                                    child:
                                                                        const Text(
                                                                      "Home Screen",
                                                                    ),
                                                                  ),
                                                                ),
                                                                const SizedBox(
                                                                    height: 10),
                                                                Container(
                                                                  decoration: BoxDecoration(
                                                                    borderRadius: BorderRadius.circular(10)
                                                                  ),
                                                                  height: 60,
                                                                  width:
                                                                      Get.width,
                                                                  child:
                                                                      ElevatedButton(
                                                                    onPressed:
                                                                        () {},
                                                                    child:
                                                                        const Text(
                                                                      "Lock Screen",
                                                                    ),
                                                                  ),
                                                                ),
                                                                const SizedBox(
                                                                    height: 10),
                                                                Container(
                                                                  decoration: BoxDecoration(
                                                                    borderRadius: BorderRadius.circular(10)
                                                                  ),
                                                                  height: 60,
                                                                  width:
                                                                      Get.width,
                                                                  child:
                                                                      ElevatedButton(
                                                                    onPressed:
                                                                        () {},
                                                                    child:
                                                                        const Text(
                                                                      "Both",
                                                                    ),
                                                                  ),
                                                                )
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                      );
                                                    },
                                                    child: const Icon(
                                                      CupertinoIcons.share,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
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
