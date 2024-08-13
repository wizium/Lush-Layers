import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wallpaper_app/Data/categories.dart';
import 'package:wallpaper_app/screens/desktop_wallpaper.dart';
import 'package:wallpaper_app/screens/mobile_wallpaper.dart';
import 'package:wallpaper_app/config.dart';

import '../Data/wallheaven.dart';

class SearchScreen extends StatelessWidget {
  final String deviceType;
  const SearchScreen({super.key, required this.deviceType});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      appBar: AppBar(
        title: const Text("Search"),
        leading: InkWell(
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
        ),
        backgroundColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
      ),
      body: Theme(
        data: ThemeData(
          useMaterial3: true,
          chipTheme: ChipThemeData(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
              side: const BorderSide(
                color: Colors.transparent,
              ),
            ),
            backgroundColor: Theme.of(context).colorScheme.onSecondary,
            labelStyle: Theme.of(context).textTheme.bodyLarge,
            padding: const EdgeInsets.all(10),
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(gPadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Hello!',
                  style: Theme.of(context).textTheme.headlineLarge!.merge(
                        const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                ),
                const SizedBox(height: 5),
                Text(
                  'Looking for something?',
                  style: Theme.of(context).textTheme.titleLarge!,
                ),
                const SizedBox(height: 20),
                TextFormField(
                  autofocus: false,
                  onFieldSubmitted: (search) {
                    deviceType == DeviceType.mobile
                        ? Get.to(
                            () => MobileWallpaper(
                              searchQuery: search,
                              onHomeScreen: false,
                              deviceType: DeviceType.mobile,
                            ),
                          )
                        : Get.to(
                            () => DesktopWallpaper(
                              searchQuery: search,
                              onHomeScreen: false,
                              deviceType: DeviceType.desktop,
                            ),
                          );
                  },
                  enableSuggestions: true,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.all(15),
                    filled: true,
                    hintText: 'Search For...',
                    hintStyle: Theme.of(context).textTheme.titleMedium!.merge(
                          TextStyle(
                            color: Colors.grey.shade500,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                    fillColor: Theme.of(context).colorScheme.onSecondary,
                    prefixIcon: Icon(
                      Icons.search,
                      color: Theme.of(context).colorScheme.inverseSurface,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                Text(
                  'Popular Search',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 5),
                Wrap(
                  spacing: 8,
                  children: wallpaperCategories.map((search) {
                    return InkWell(
                      onTap: () {
                        deviceType == DeviceType.mobile
                            ? Get.to(
                                () => MobileWallpaper(
                                  searchQuery: search,
                                  onHomeScreen: false,
                                  deviceType: DeviceType.mobile,
                                ),
                              )
                            : Get.to(
                                () => DesktopWallpaper(
                                  searchQuery: search,
                                  onHomeScreen: false,
                                  deviceType: DeviceType.desktop,
                                ),
                              );
                      },
                      child: Chip(
                        label: Text(search),
                      ),
                    );
                  }).toList(),
                ),
                const SizedBox(height: 24),
                Text(
                  'Search by colors',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 10),
                GridView.builder(
                  shrinkWrap: true,
                  itemCount: colorMap.length,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 5,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
                  ),
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        deviceType == DeviceType.mobile
                            ? Get.to(
                                () => MobileWallpaper(
                                  searchQuery: colorMap.keys
                                      .toList()
                                      .reversed
                                      .toList()[index],
                                  onHomeScreen: false,
                                  deviceType: DeviceType.mobile,
                                ),
                              )
                            : Get.to(
                                () => DesktopWallpaper(
                                  searchQuery: colorMap.keys
                                      .toList()
                                      .reversed
                                      .toList()[index],
                                  onHomeScreen: false,
                                  deviceType: DeviceType.desktop,
                                ),
                              );
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color:
                              colorMap.values.toList().reversed.toList()[index],
                        ),
                      ),
                    );
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
