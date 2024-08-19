import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:shimmer/shimmer.dart';
import 'package:wallpaper_app/screens/no_image.dart';
import 'package:wallpaper_app/screens/search.dart';
import 'package:wallpaper_app/config.dart';
import '../Data/wallheaven.dart';
import '../main.dart';
import 'wallpaper_preview.dart';

class MobileWallpaper extends StatefulWidget {
  final bool onHomeScreen;
  final String? searchQuery;
  final String deviceType;

  const MobileWallpaper({
    super.key,
    this.onHomeScreen = true,
    this.searchQuery,
    this.deviceType = DeviceType.mobile,
  });

  @override
  State<MobileWallpaper> createState() => _MobileWallpaperState();
}

class _MobileWallpaperState extends State<MobileWallpaper>
    with AutomaticKeepAliveClientMixin<MobileWallpaper> {
  final ValueNotifier<bool> _isFetchingMore = ValueNotifier(false);
  final ValueNotifier<bool> _hasMore = ValueNotifier(true);
  int _currentPage = 1;
  List<Wallpapers> _wallpapers = [];
  late Future<void> _initialLoad;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    _initialLoad = _fetchWallpapers();
  }

  Future<void> _fetchWallpapers({bool isLoadMore = false}) async {
    if (_isFetchingMore.value) return;
    _isFetchingMore.value = true;

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
        _hasMore.value = response.hasMore;
      });
    } catch (e) {
      log(e.toString());
    } finally {
      _isFetchingMore.value = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: widget.onHomeScreen
          ? FloatingActionButton(
              onPressed: () {
                Get.to(() => SearchScreen(deviceType: widget.deviceType));
              },
              child: const Icon(Icons.search),
            )
          : null,
      appBar: AppBar(
        title: Text(widget.onHomeScreen ? "Lush Layers" : widget.searchQuery!),
        centerTitle: true,
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
                  child: LoadingAnimationWidget.threeArchedCircle(
                    color: Theme.of(context).colorScheme.primary,
                    size: 80,
                  ),
                );
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              }
              return NotificationListener<ScrollNotification>(
                onNotification: (ScrollNotification scrollInfo) {
                  if (scrollInfo.metrics.pixels ==
                          scrollInfo.metrics.maxScrollExtent &&
                      _hasMore.value &&
                      !_isFetchingMore.value) {
                    _fetchWallpapers(isLoadMore: true);
                  }
                  return false;
                },
                child: Column(
                  children: [
                    Expanded(
                      child: GridView.builder(
                        itemCount:
                            _wallpapers.length + (_hasMore.value ? 1 : 0),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 5,
                          crossAxisSpacing: 5,
                          childAspectRatio: .58,
                        ),
                        itemBuilder: (context, index) {
                          if (index == _wallpapers.length) {
                            return Center(
                              child: ValueListenableBuilder(
                                valueListenable: _isFetchingMore,
                                builder: (context, isLoading, child) {
                                  if (isLoading) {
                                    return LoadingAnimationWidget
                                        .discreteCircle(
                                      color:
                                          Theme.of(context).colorScheme.primary,
                                      size: 50,
                                    );
                                  } else if (!_hasMore.value) {
                                    return const Text('No more images.');
                                  }
                                  return const SizedBox.shrink();
                                },
                              ),
                            );
                          }
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
                                border: Border.all(),
                                borderRadius: BorderRadius.circular(12),
                                color: Colors.black.withOpacity(.5),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: CachedNetworkImage(
                                  filterQuality: FilterQuality.high,
                                  imageUrl: settings.quality.value
                                      ? wallpaper.source
                                      : wallpaper.thumbNail,
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
                                      const SomethingWrongScreen(),
                                  fadeInDuration:
                                      const Duration(milliseconds: 500),
                                  fadeOutDuration:
                                      const Duration(milliseconds: 500),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    if (_isFetchingMore.value)
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 16.0),
                        child: Center(
                          child: LoadingAnimationWidget.threeArchedCircle(
                            color: Theme.of(context).colorScheme.primary,
                            size: 50,
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
