// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:wallpaper_app/utils/fetch_code.dart';
import '/main.dart';
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
  Future<void> hello() async {
    setState(() {});
  }

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
        title: Text(
          widget.title!,
          style: Theme.of(context).textTheme.headlineLarge,
        ),
      ),
      body: RefreshIndicator(
        onRefresh: () {
          return hello();
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: FutureBuilder(
            future: responseData.fetch(parameter: widget.title!),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return GridView.builder(
                  itemCount: snapshot.data!.photosList!.length,
                  gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: width * .33,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    mainAxisExtent: height * .27,
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
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(.5),
                          ),
                          child: Image.network(
                            snapshot.data!.photosList![index].thumbnail,
                            fit: BoxFit.cover,
                            loadingBuilder: (context, child, loadingProgress) {
                              if (loadingProgress == null) {
                                return child;
                              } else {
                                return Center(
                                  child:
                                      LoadingAnimationWidget.staggeredDotsWave(
                                    color: Colors.red,
                                    size: 70,
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
                  child: LoadingAnimationWidget.staggeredDotsWave(
                      color: Colors.green, size: 100),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
