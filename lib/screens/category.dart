import 'package:flutter/material.dart';
import '/utils/fetch_code.dart';
import '/utils/text_scale.dart';
import '/Data/categories.dart';
import '/main.dart';
import 'all_wallpapers.dart';

class Categories extends StatefulWidget {
  const Categories({super.key});
  @override
  State<Categories> createState() => _HomeState();
}

class _HomeState extends State<Categories> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "CATEGORY",
          style: Theme.of(context).textTheme.headlineLarge,
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: height * .08,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: wallpaperCategories.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                  ),
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return AllWallpapers(
                              title: wallpaperCategories[index],
                              requestType: RequestType.category,
                            );
                          },
                        ),
                      );
                    },
                    child: Chip(
                      backgroundColor: Colors.white,
                      label: Text(
                        wallpaperCategories[index],
                        style: const TextStyle(fontSize: 16),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: SizedBox(
              height: height * .06,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: colorsList.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                    ),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return AllWallpapers(
                                title: colorsList[index]
                                    .value
                                    .toRadixString(16)
                                    .substring(2)
                                    .toUpperCase(),
                                requestType: RequestType.color,
                              );
                            },
                          ),
                        );
                      },
                      child: Container(
                        clipBehavior: Clip.hardEdge,
                        width: width * .12,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: colorsList[index],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 10,
            ),
            child: SizedBox(
              height: height * .27,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: imageList.images.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return AllWallpapers(
                              title: imageList.refinedList[index].name,
                              requestType: RequestType.category,
                            );
                          },
                        ),
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                      ),
                      child: Stack(
                        children: [
                          Align(
                            alignment: Alignment.bottomCenter,
                            child: Container(
                              clipBehavior: Clip.hardEdge,
                              height: height * .2,
                              width: width * .3,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: colorsList.reversed.toList()[index],
                              ),
                            ),
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Image(
                                height: height * .2,
                                width: width * .3,
                                image: AssetImage(
                                  imageList.refinedList[index].path,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 10,
                                ),
                                child: Text(
                                  imageList.refinedList[index].name,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 19,
                                    fontWeight: FontWeight.w600,
                                  ),
                                  textScaleFactor: textScaleFactor(context),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(
                top: 10,
                left: 10,
                right: 10,
              ),
              child: GridView.builder(
                primary: true,
                itemCount: 6,
                gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: width * .5,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                  mainAxisExtent: height * .1,
                ),
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return AllWallpapers(
                              title: recommendedImage.refinedList[index].name,
                              requestType: RequestType.category,
                            );
                          },
                        ),
                      );
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: Colors.black.withOpacity(.1),
                          width: 2,
                          style: BorderStyle.solid,
                        ),
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 4,
                            blurStyle: BlurStyle.normal,
                            color: Colors.black.withOpacity(.1),
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image(
                              height: height * .2,
                              fit: BoxFit.cover,
                              width: width * .2,
                              image: AssetImage(
                                recommendedImage.refinedList[index].path,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                              left: 10,
                            ),
                            child: Text(
                              recommendedImage.refinedList[index].name,
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 17,
                              ),
                              softWrap: true,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
