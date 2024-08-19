import 'dart:io';
import 'dart:ui';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:share_plus/share_plus.dart';
import 'package:super_tooltip/super_tooltip.dart';
import 'package:wallpaper_app/Data/favorites.dart';
import 'package:wallpaper_app/Data/wallheaven.dart';
import 'package:wallpaper_app/main.dart';
import 'package:wallpaper_app/screens/no_image.dart';
import 'package:wallpaper_app/config.dart';
import 'package:wallpaper_app/utils/gallery_saver.dart';
import 'package:wallpaper_manager_plus/wallpaper_manager_plus.dart';

class PreviewWallpaper extends StatefulWidget {
  final Wallpapers wallpaper;
  bool isFavorite;
  PreviewWallpaper({
    super.key,
    required this.wallpaper,
    this.isFavorite = false,
  });

  @override
  State<PreviewWallpaper> createState() => _PreviewWallpaperState();
}

class _PreviewWallpaperState extends State<PreviewWallpaper> {
  bool isVisible = true;
  SuperTooltipController toolTipController = SuperTooltipController();
  @override
  Widget build(BuildContext context) {
    return Theme(
      data: darkTheme!.copyWith(
        iconButtonTheme: const IconButtonThemeData(
          style: ButtonStyle(
            iconColor: WidgetStatePropertyAll(
              Colors.black,
            ),
          ),
        ),
      ),
      child: Builder(builder: (context) {
        return Scaffold(
          body: Stack(
            fit: StackFit.expand,
            alignment: Alignment.bottomCenter,
            children: [
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    end: Alignment.bottomCenter,
                    begin: Alignment.topCenter,
                    colors: widget.wallpaper.colors.map((e) {
                      return HexColor.fromHex(e);
                    }).toList(),
                  ),
                ),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
                  child: Center(
                    child: InkWell(
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      child: CachedNetworkImage(
                        imageUrl: widget.wallpaper.source,
                        // fit: widget.wallpaper.isPortrait
                        //     ? BoxFit.fitHeight
                        //     : BoxFit.fitWidth,
                        fit: BoxFit.cover,
                        // width: Get.width,
                        // height: Get.height,
                        filterQuality: FilterQuality.high,
                        placeholder: (context, url) => Center(
                          child: LoadingAnimationWidget.discreteCircle(
                            color: Theme.of(context).colorScheme.inversePrimary,
                            size: 120,
                          ),
                        ),
                        errorWidget: (context, url, error) =>
                            const SomethingWrongScreen(),
                        imageBuilder: (context, imageProvider) {
                          return InteractiveViewer(
                            child: Image(
                              image: imageProvider,
                              fit: widget.wallpaper.isPortrait
                                  ? BoxFit.cover
                                  : BoxFit.fitWidth,
                            ),
                          );
                        },
                      ),
                      onTap: () {
                        isVisible = !isVisible;
                        setState(() {});
                      },
                    ),
                  ),
                ),
              ),
              SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(gPadding),
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
                              color: Theme.of(context)
                                  .colorScheme
                                  .primaryContainer,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Icon(
                              Icons.arrow_back_ios_new_rounded,
                              color: Theme.of(context).colorScheme.surface,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Align(
                            alignment: Alignment.bottomCenter,
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(.4),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              height: 150,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: BackdropFilter(
                                  filter: ImageFilter.blur(
                                    sigmaX: 40,
                                    sigmaY: 40,
                                  ),
                                  child: Align(
                                    alignment: Alignment.bottomCenter,
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: gPadding,
                                        vertical: 20,
                                      ),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 7,
                                            ),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  widget.wallpaper.title,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .titleLarge!
                                                      .merge(
                                                        const TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Colors.black,
                                                        ),
                                                      ),
                                                ),
                                                const SizedBox(
                                                  height: 10,
                                                ),
                                                Row(
                                                  children: [
                                                    Text(
                                                      "${widget.wallpaper.height} x ${widget.wallpaper.width}",
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .titleMedium!
                                                          .merge(
                                                            const TextStyle(
                                                              color:
                                                                  Colors.black,
                                                            ),
                                                          ),
                                                    ),
                                                    const SizedBox(width: 10),
                                                    Text(
                                                      "JPG",
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .titleMedium!
                                                          .copyWith(
                                                            color: Colors.black,
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
                                                onPressed: () {
                                                  isVisible = false;
                                                  setState(() {});
                                                  Share.share(
                                                    """Hey check this out Lush Layers.\nAn awesome wallpaper app i have be using it for a while and i love it.\n$appLink""",
                                                  );
                                                },
                                                icon: const Icon(
                                                  CupertinoIcons
                                                      .arrowshape_turn_up_right,
                                                  size: 25,
                                                ),
                                              ),
                                              IconButton(
                                                onPressed: () async {
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
                                                      return infoWidget(
                                                          widget.wallpaper);
                                                    },
                                                  );
                                                },
                                                icon: const Icon(
                                                  Icons.info_outline_rounded,
                                                  size: 25,
                                                ),
                                              ),
                                              IconButton(
                                                onPressed: () async {
                                                  await ImageService
                                                      .downloadAndSaveImage(
                                                    widget.wallpaper.source,
                                                  );
                                                },
                                                icon: const Icon(
                                                  CupertinoIcons
                                                      .arrow_down_circle,
                                                  size: 25,
                                                ),
                                              ),
                                              IconButton(
                                                onPressed: () async {
                                                  !widget.isFavorite
                                                      ? {
                                                          widget.isFavorite =
                                                              await Favorites
                                                                  .addToFavorites(
                                                            widget.wallpaper,
                                                            widget.isFavorite,
                                                          )
                                                        }
                                                      : {
                                                          widget.isFavorite =
                                                              await Favorites
                                                                  .removeFromFavorites(
                                                            widget.wallpaper,
                                                            widget.isFavorite,
                                                          )
                                                        };
                                                  setState(() {});
                                                },
                                                icon: Icon(
                                                  !widget.isFavorite
                                                      ? CupertinoIcons.heart
                                                      : CupertinoIcons
                                                          .heart_fill,
                                                  size: 25,
                                                ),
                                              ),
                                              Expanded(
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                    right: 8,
                                                  ),
                                                  child: Align(
                                                    alignment:
                                                        Alignment.bottomRight,
                                                    child: FloatingActionButton(
                                                      shape:
                                                          RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(
                                                          40,
                                                        ),
                                                      ),
                                                      onPressed: () async {
                                                        isVisible = false;
                                                        setState(() {});
                                                        Get.dialog(
                                                          Dialog(
                                                            backgroundColor: Theme
                                                                    .of(context)
                                                                .colorScheme
                                                                .onInverseSurface,
                                                            child: SizedBox(
                                                              height: 330,
                                                              child: Stack(
                                                                children: [
                                                                  Container(
                                                                    margin:
                                                                        const EdgeInsets
                                                                            .all(
                                                                      20,
                                                                    ),
                                                                    child:
                                                                        Column(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .spaceEvenly,
                                                                      crossAxisAlignment:
                                                                          CrossAxisAlignment
                                                                              .center,
                                                                      children: [
                                                                        Icon(
                                                                          Icons
                                                                              .wallpaper_rounded,
                                                                          color: Theme.of(context)
                                                                              .colorScheme
                                                                              .primaryContainer,
                                                                          size:
                                                                              35,
                                                                        ),
                                                                        const SizedBox(
                                                                          height:
                                                                              10,
                                                                        ),
                                                                        Text(
                                                                          "Set wallpaper on",
                                                                          style: Theme.of(context)
                                                                              .textTheme
                                                                              .headlineSmall!,
                                                                        ),
                                                                        const SizedBox(
                                                                          height:
                                                                              10,
                                                                        ),
                                                                        Column(
                                                                          children: [
                                                                            InkWell(
                                                                              onTap: () async {
                                                                                File wallpaper = await DefaultCacheManager().getSingleFile(
                                                                                  widget.wallpaper.source,
                                                                                );
                                                                                WallpaperManagerPlus().setWallpaper(
                                                                                  wallpaper,
                                                                                  WallpaperManagerPlus.homeScreen,
                                                                                );
                                                                                Get.back();
                                                                              },
                                                                              child: Container(
                                                                                decoration: BoxDecoration(
                                                                                  color: Theme.of(context).colorScheme.primaryContainer,
                                                                                  borderRadius: BorderRadius.circular(
                                                                                    10,
                                                                                  ),
                                                                                ),
                                                                                height: 60,
                                                                                width: Get.width,
                                                                                child: Center(
                                                                                  child: Text(
                                                                                    "Home Screen",
                                                                                    style: Theme.of(context).textTheme.labelLarge!.merge(
                                                                                          const TextStyle(
                                                                                            color: Colors.black,
                                                                                          ),
                                                                                        ),
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                            ),
                                                                            const SizedBox(
                                                                              height: 10,
                                                                            ),
                                                                            InkWell(
                                                                              onTap: () async {
                                                                                File wallpaper = await DefaultCacheManager().getSingleFile(
                                                                                  widget.wallpaper.source,
                                                                                );
                                                                                WallpaperManagerPlus().setWallpaper(
                                                                                  wallpaper,
                                                                                  WallpaperManagerPlus.lockScreen,
                                                                                );
                                                                                Get.back();
                                                                              },
                                                                              child: Container(
                                                                                decoration: BoxDecoration(
                                                                                  color: Theme.of(context).colorScheme.primaryContainer,
                                                                                  borderRadius: BorderRadius.circular(
                                                                                    10,
                                                                                  ),
                                                                                ),
                                                                                height: 60,
                                                                                width: Get.width,
                                                                                child: Center(
                                                                                  child: Text(
                                                                                    "Lock Screen",
                                                                                    style: Theme.of(context).textTheme.labelLarge!.merge(
                                                                                          const TextStyle(
                                                                                            color: Colors.black,
                                                                                          ),
                                                                                        ),
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                            ),
                                                                            const SizedBox(
                                                                              height: 10,
                                                                            ),
                                                                            InkWell(
                                                                              onTap: () async {
                                                                                File wallpaper = await DefaultCacheManager().getSingleFile(
                                                                                  widget.wallpaper.source,
                                                                                );
                                                                                WallpaperManagerPlus().setWallpaper(
                                                                                  wallpaper,
                                                                                  WallpaperManagerPlus.bothScreens,
                                                                                );
                                                                                Get.back();
                                                                              },
                                                                              child: Container(
                                                                                decoration: BoxDecoration(
                                                                                  color: Theme.of(context).colorScheme.primaryContainer,
                                                                                  borderRadius: BorderRadius.circular(
                                                                                    10,
                                                                                  ),
                                                                                ),
                                                                                height: 60,
                                                                                width: Get.width,
                                                                                child: Center(
                                                                                  child: Text(
                                                                                    "Both",
                                                                                    style: Theme.of(context).textTheme.labelLarge!.merge(
                                                                                          const TextStyle(
                                                                                            color: Colors.black,
                                                                                          ),
                                                                                        ),
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                            )
                                                                          ],
                                                                        )
                                                                      ],
                                                                    ),
                                                                  ),
                                                                  Align(
                                                                    alignment:
                                                                        Alignment
                                                                            .topRight,
                                                                    child:
                                                                        Padding(
                                                                      padding:
                                                                          const EdgeInsets
                                                                              .all(
                                                                        gPadding,
                                                                      ),
                                                                      child:
                                                                          SuperTooltip(
                                                                        controller:
                                                                            toolTipController,
                                                                        content:
                                                                            const Text(
                                                                          "The app may restart after apply wallpaper in android 12 and above.",
                                                                        ),
                                                                        child:
                                                                            IconButton(
                                                                          onPressed:
                                                                              () async {
                                                                            await toolTipController.showTooltip();
                                                                          },
                                                                          icon:
                                                                              Icon(
                                                                            Icons.info_outline_rounded,
                                                                            color:
                                                                                Theme.of(context).colorScheme.primaryContainer,
                                                                          ),
                                                                        ),
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
              ),
            ],
          ),
        );
      }),
    );
  }
}

Widget infoWidget(Wallpapers wallpaper) {
  return SafeArea(
    child: BottomSheet(
      enableDrag: false,
      backgroundColor: Colors.transparent,
      onClosing: () {},
      builder: (context) {
        return Container(
          height: 300,
          width: MediaQuery.of(context).size.width,
          margin: const EdgeInsets.all(
            gPadding,
          ),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(
              .4,
            ),
            borderRadius: BorderRadius.circular(
              20,
            ),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(
              20,
            ),
            child: BackdropFilter(
              filter: ImageFilter.blur(
                sigmaX: 40.0,
                sigmaY: 40.0,
              ),
              child: Padding(
                padding: const EdgeInsets.all(
                  20.0,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Info",
                              style:
                                  Theme.of(context).textTheme.titleLarge!.merge(
                                        const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                        ),
                                      ),
                            ),
                            const SizedBox(height: 5),
                            Text(
                              "Type",
                              style:
                                  Theme.of(context).textTheme.bodyLarge!.merge(
                                        const TextStyle(color: Colors.black),
                                      ),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Text(
                              "Resolution",
                              style:
                                  Theme.of(context).textTheme.bodyLarge!.merge(
                                        const TextStyle(color: Colors.black),
                                      ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          width: 30,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "",
                              style:
                                  Theme.of(context).textTheme.titleLarge!.merge(
                                        const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                        ),
                                      ),
                            ),
                            const SizedBox(height: 5),
                            Text(
                              "JPG",
                              style:
                                  Theme.of(context).textTheme.bodyLarge!.merge(
                                        const TextStyle(color: Colors.black),
                                      ),
                            ),
                            const SizedBox(height: 5),
                            Text(
                              "${wallpaper.height} x ${wallpaper.width}",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge!
                                  .merge(const TextStyle(color: Colors.black)),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const Divider(
                      color: Colors.black,
                      thickness: .5,
                    ),
                    Text(
                      "Colors",
                      style: Theme.of(context).textTheme.titleLarge!.merge(
                            const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      "Tap to copy color",
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge!
                          .copyWith(color: Colors.black),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    ColorsGrid(colors: wallpaper.colors),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    ),
  );
}

class ColorsGrid extends StatelessWidget {
  final List colors;
  const ColorsGrid({super.key, required this.colors});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return ListView(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          children: [
            Center(
              child: Wrap(
                spacing: 5,
                runSpacing: 5,
                children: colors.map((color) {
                  return SizedBox(
                    width: (constraints.maxWidth / 5) - 10,
                    height: 115,
                    child: InkWell(
                      onTap: () {
                        Clipboard.setData(
                          ClipboardData(text: color),
                        );
                        Fluttertoast.showToast(
                          msg: "Color copied to clipboard",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.BOTTOM,
                        );
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: HexColor.fromHex(color),
                          borderRadius: BorderRadius.circular(30),
                          border: Border.all(width: .1),
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          ],
        );
      },
    );
  }
}

extension HexColor on Color {
  static Color fromHex(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }

  /// Prefixes a hash sign if [leadingHashSign] is set to `true` (default is `true`).
  String toHex({bool leadingHashSign = true}) => '${leadingHashSign ? '#' : ''}'
      '${alpha.toRadixString(16).padLeft(2, '0')}'
      '${red.toRadixString(16).padLeft(2, '0')}'
      '${green.toRadixString(16).padLeft(2, '0')}'
      '${blue.toRadixString(16).padLeft(2, '0')}';
}
