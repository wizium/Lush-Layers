// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:shimmer/shimmer.dart';
import 'package:wallpaper_app/theme.dart';
import 'package:wallpaper_app/utils/fetch_code.dart';
import 'wallpaper_preview.dart';

late ResponseData responseData;

class AllWallpapers extends StatefulWidget {
  String? title = "MOBILE WALLPAPER";
  int? requestType = RequestType.curated;
  AllWallpapers({super.key, this.title, this.requestType});
  @override
  State<AllWallpapers> createState() => _AllWallpapersState();
}

class _AllWallpapersState extends State<AllWallpapers>
    with AutomaticKeepAliveClientMixin<AllWallpapers> {
  @override
  bool get wantKeepAlive => true;
  @override
  void initState() {
    super.initState();
    responseData = ResponseData(requestType: widget.requestType);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: AppBar(
        leading: Container(
          margin: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primary,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(
            Iconsax.arrow_right_3,
            color: Theme.of(context).colorScheme.surface,
          ),
        ),
        title: Text(widget.title!),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: gPadding),
        child: FutureBuilder(
          future: responseData.fetch(parameter: widget.title!),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return GridView.builder(
                itemCount: snapshot.data!.photosList!.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                  childAspectRatio: .7,
                ),
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return PreviewWallpaper(
                              model: snapshot.data!.photosList![index],
                            );
                          },
                        ),
                      );
                    },
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Container(
                        // height: 190,
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(.5),
                        ),
                        child: Image.network(
                          snapshot.data!.photosList![index].thumbnail,
                          fit: BoxFit.cover,
                          gaplessPlayback: true,
                          frameBuilder:
                              (context, child, frame, wasSynchronouslyLoaded) {
                            return child;
                          },
                          loadingBuilder: (context, child, loadingProgress) {
                            if (loadingProgress == null) {
                              return child;
                            } else {
                              return Shimmer.fromColors(
                                baseColor: Colors.grey[300]!,
                                highlightColor: Colors.grey[100]!,
                                child: Container(
                                  color: Colors.white,
                                ),
                              );
                            }
                          },
                        ),
                      ),
                    ),
                  );
                },
              );
            } else {
              return Center(
                child: LoadingAnimationWidget.discreteCircle(
                  color: Colors.pink,
                  thirdRingColor: Colors.orange,
                  size: 100,
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
