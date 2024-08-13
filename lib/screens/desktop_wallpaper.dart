import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:palette_generator/palette_generator.dart';
import 'package:shimmer/shimmer.dart';
import 'package:wallpaper_app/config.dart';
import 'package:wallpaper_app/screens/search.dart';
import 'package:wallpaper_app/screens/wallpaper_preview.dart';
import '../Data/wallheaven.dart';
import '../main.dart';
import 'no_image.dart';

class DesktopWallpaper extends StatefulWidget {
  final bool onHomeScreen;
  final String? searchQuery;
  final String deviceType;

  DesktopWallpaper({
    super.key,
    this.onHomeScreen = true,
    this.searchQuery,
    this.deviceType = DeviceType.desktop,
  });

  @override
  State<DesktopWallpaper> createState() => _DesktopWallpaperState();
}

class _DesktopWallpaperState extends State<DesktopWallpaper>
    with AutomaticKeepAliveClientMixin<DesktopWallpaper> {
  bool _isFetchingMore = false;
  int _currentPage = 1;
  bool _hasMore = true;
  List<Wallpapers> _wallpapers = [];
  late Future<void> _initialLoad;
  late ScrollController _scrollController;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController()..addListener(_onScroll);
    _initialLoad = _fetchWallpapers();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> _fetchWallpapers({bool isLoadMore = false}) async {
    if (_isFetchingMore) return;
    _isFetchingMore = true;

    try {
      WallHeavenWallpapers response = await WallHeavenWallpapers.getWallpaper(
        name: widget.searchQuery,
        page: _currentPage,
        type: widget.deviceType,
      );
      setState(() {
        if (isLoadMore) {
          _wallpapers.addAll(response.wallpapers);
        } else {
          _wallpapers = response.wallpapers;
        }
        _currentPage = response.nextPage;
        _hasMore = response.hasMore;
      });
    } catch (e) {
      log(e.toString());
      setState(() {
        _hasMore = false;
      });
    } finally {
      _isFetchingMore = false;
    }
  }

  void _onScroll() {
    if (_scrollController.position.pixels ==
            _scrollController.position.maxScrollExtent &&
        _hasMore &&
        !_isFetchingMore) {
      _fetchWallpapers(isLoadMore: true);
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: widget.onHomeScreen
          ? FloatingActionButton(
              heroTag: "",
              onPressed: () {
                Get.to(() => SearchScreen(deviceType: widget.deviceType));
              },
              child: const Icon(Icons.search),
            )
          : null,
      appBar: AppBar(
        title: Text(
            widget.onHomeScreen ? "Desktop Wallpaper" : widget.searchQuery!),
        leading: !widget.onHomeScreen
            ? InkWell(
                borderRadius: BorderRadius.circular(10),
                onTap: () {
                  Get.back();
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primary,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Icon(
                      CupertinoIcons.chevron_back,
                      color: Theme.of(context).colorScheme.surface,
                    ),
                  ),
                ),
              )
            : null,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: gPadding),
          child: FutureBuilder(
            future: _initialLoad,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: LoadingAnimationWidget.discreteCircle(
                    color: Theme.of(context).colorScheme.primary,
                    size: 80,
                  ),
                );
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              }
              return NotificationListener<ScrollNotification>(
                onNotification: (ScrollNotification scrollInfo) => false,
                child: Column(
                  children: [
                    Expanded(
                      child: GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 1,
                          mainAxisSpacing: 5,
                          crossAxisSpacing: 5,
                          childAspectRatio: 1.5,
                        ),
                        controller: _scrollController,
                        itemCount: _wallpapers.length + (_hasMore ? 1 : 0),
                        itemBuilder: (context, index) {
                          if (index == _wallpapers.length) {
                            return Center(
                              child: _isFetchingMore
                                  ? LoadingAnimationWidget.threeArchedCircle(
                                      color:
                                          Theme.of(context).colorScheme.primary,
                                      size: 50,
                                    )
                                  : const SizedBox.shrink(),
                            );
                          } else {
                            final wallpaper = _wallpapers[index];
                            return InkWell(
                              onTap: () async {
                                Get.to(
                                  () => PreviewWallpaper(
                                    wallpaper: wallpaper,
                                  ),
                                );
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.black.withOpacity(.5),
                                ),
                                height: 250,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: CachedNetworkImage(
                                    filterQuality: FilterQuality.high,
                                    imageUrl:settings.quality.value?wallpaper.source: wallpaper.thumbNail,
                                    fit: BoxFit.cover,
                                    placeholder: (context, url) =>
                                        Shimmer.fromColors(
                                      baseColor:
                                          Theme.of(context).colorScheme.surface,
                                      highlightColor:
                                          Colors.grey.shade400.withOpacity(.5),
                                      period: const Duration(milliseconds: 800),
                                      direction: ShimmerDirection.ttb,
                                      child: Container(
                                        height: double.infinity,
                                        width: double.infinity,
                                        color: Colors.white,
                                      ),
                                    ),
                                    errorWidget: (context, url, error) =>
                                        Center(
                                      child: Card.outlined(
                                        margin: const EdgeInsets.all(gPadding),
                                        child: SizedBox(
                                          height: 100,
                                          width: Get.width,
                                          child: const Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Text(
                                                "Something went wrong while loading image.",
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    fadeInDuration:
                                        const Duration(milliseconds: 500),
                                    fadeOutDuration:
                                        const Duration(milliseconds: 500),
                                  ),
                                ),
                              ),
                            );
                          }
                        },
                      ),
                    ),
                    if (_isFetchingMore)
                      SizedBox(
                        height: 100,
                        width: Get.width,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 16.0),
                          child: Center(
                            child: LoadingAnimationWidget.discreteCircle(
                              color: Theme.of(context).colorScheme.primary,
                              size: 50,
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
