import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:shimmer/shimmer.dart';
import 'package:wallpaper_app/Data/wallheaven.dart';
import 'package:wallpaper_app/config.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:wallpaper_app/screens/home.dart';
import '../main.dart';
import 'no_image.dart';
import 'wallpaper_preview.dart';

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({super.key});

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  @override
  Widget build(BuildContext context) {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorites'),
      ),
      body: SafeArea(
        child: firebaseAuth.currentUser != null
            ? StreamBuilder(
                stream: firestore
                    .collection('Favorites')
                    .doc(firebaseAuth.currentUser!.uid)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: LoadingAnimationWidget.threeArchedCircle(
                        color: Theme.of(context).colorScheme.primary,
                        size: 80,
                      ),
                    );
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  }

                  List<Wallpapers> favoritesData = Wallpapers.fromJsonFirebase(
                      jsonData: snapshot.data!.data()!["wallpapers"]);
                  if (favoritesData.isEmpty) {
                    return Center(
                      child: SizedBox(
                        height: 100,
                        width: Get.width,
                        child: const Card.outlined(
                          margin: EdgeInsets.all(gPadding),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                'No favorites available.',
                              ),
                              Text(
                                'Add some wallpaper to favorites to see here.',
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }

                  return SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(horizontal: gPadding),
                    child: StaggeredGrid.count(
                      crossAxisCount: 8,
                      mainAxisSpacing: 5,
                      crossAxisSpacing: 5,
                      children: List.generate(favoritesData.length, (i) {
                        Wallpapers wallpaper = favoritesData[i];
                        if (wallpaper.isPortrait) {
                          return StaggeredGridTile.count(
                            crossAxisCellCount: 3,
                            mainAxisCellCount: 5,
                            child: InkWell(
                              onTap: () async {
                                Get.to(
                                  () => PreviewWallpaper(
                                    wallpaper: wallpaper,
                                    isFavorite: true,
                                  ),
                                );
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(),
                                  color: Colors.black.withOpacity(.5),
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Stack(
                                    fit: StackFit.expand,
                                    children: [
                                      Image.network(
                                        settings.quality.value
                                            ? wallpaper.source
                                            : wallpaper.thumbNail,
                                        fit: BoxFit.cover,
                                        gaplessPlayback: true,
                                        frameBuilder: (context, child, frame,
                                            wasSynchronouslyLoaded) {
                                          return child;
                                        },
                                        errorBuilder:
                                            (context, error, stackTrace) {
                                          return const SomethingWrongScreen();
                                        },
                                        loadingBuilder:
                                            (context, child, loadingProgress) {
                                          if (loadingProgress != null) {
                                            return Shimmer.fromColors(
                                              baseColor: Theme.of(context)
                                                  .colorScheme
                                                  .surface,
                                              highlightColor: Colors
                                                  .grey.shade400
                                                  .withOpacity(.5),
                                              period: const Duration(
                                                  milliseconds: 800),
                                              direction: ShimmerDirection.ttb,
                                              child: Container(
                                                height: double.infinity,
                                                width: double.infinity,
                                                color: Colors.white,
                                              ),
                                            );
                                          } else {
                                            return child;
                                          }
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        } else {
                          return StaggeredGridTile.count(
                            crossAxisCellCount: 5,
                            mainAxisCellCount: 4,
                            child: InkWell(
                              onTap: () async {
                                Get.to(
                                  () => PreviewWallpaper(
                                    wallpaper: wallpaper,
                                    isFavorite: true,
                                  ),
                                );
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  border: Border.all(),
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.black.withOpacity(.5),
                                ),
                                height: 250,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Image.network(wallpaper.thumbNail,
                                      gaplessPlayback: true,
                                      fit: BoxFit.cover, errorBuilder:
                                          (context, error, stackTrace) {
                                    return const SomethingWrongScreen();
                                  }, loadingBuilder:
                                          (context, child, loadingProgress) {
                                    if (loadingProgress != null) {
                                      return Shimmer.fromColors(
                                        baseColor: Theme.of(context)
                                            .colorScheme
                                            .surface,
                                        highlightColor: Colors.grey.shade400
                                            .withOpacity(.5),
                                        period: const Duration(
                                          milliseconds: 800,
                                        ),
                                        direction: ShimmerDirection.ttb,
                                        child: Container(
                                          height: double.infinity,
                                          width: double.infinity,
                                          color: Colors.white,
                                        ),
                                      );
                                    } else {
                                      return child;
                                    }
                                  }),
                                ),
                              ),
                            ),
                          );
                        }
                      }),
                    ),
                  );
                },
              )
            : Center(
                child: Card.outlined(
                  margin: const EdgeInsets.all(gPadding),
                  child: SizedBox(
                    height: 100,
                    width: Get.width,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Text(
                          "You should login first in order to sync Favorites.",
                        ),
                        Padding(
                          padding: const EdgeInsets.all(gPadding),
                          child: SizedBox(
                            width: Get.width,
                            height: 40,
                            child: FilledButton(
                              onPressed: () {
                                navigationController.navigate(3);
                                pageController.jumpToPage(3);
                              },
                              child: Text(
                                "Login",
                                style: const TextStyle().copyWith(
                                  color:
                                      Theme.of(context).colorScheme.onSecondary,
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
      ),
    );
  }
}
