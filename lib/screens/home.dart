import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import 'package:wallpaper_app/screens/favorites.dart';
import 'package:wallpaper_app/screens/settings.dart';
import '../utils/tab_control.dart';
import 'desktop_wallpaper.dart';
import 'mobile_wallpaper.dart';

NavigationController navigationController = Get.put(NavigationController());
final PageController pageController = PageController();

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    super.initState();
    pageController.addListener(() {
      int pageIndex = pageController.page!.round();
      if (navigationController.selectedIndex!.value != pageIndex) {
        navigationController.selectedIndex!.value = pageIndex;
      }
    });
  }

  @override
  void dispose() {
    navigationController.dispose();
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        physics: const NeverScrollableScrollPhysics(),
        controller: pageController,
        children: [
          const MobileWallpaper(),
          DesktopWallpaper(),
          const FavoritesScreen(),
          const SettingsScreen(),
        ],
        onPageChanged: (index) {
          navigationController.selectedIndex!.value = index;
        },
      ),
      bottomNavigationBar: SafeArea(
        child: Obx(() {
          return SalomonBottomBar(
            selectedItemColor: Theme.of(context).listTileTheme.iconColor,
            currentIndex: navigationController.selectedIndex!.value,
            onTap: (index) {
              pageController.jumpToPage(index);
              navigationController.navigate(index);
            },
            items: [
              SalomonBottomBarItem(
                icon: const Icon(CupertinoIcons.compass),
                title: const Text("Explore"),
              ),
              SalomonBottomBarItem(
                icon: const Icon(CupertinoIcons.device_laptop),
                title: const Text("Desktop"),
              ),
              SalomonBottomBarItem(
                icon: const Icon(CupertinoIcons.square_favorites_alt),
                title: const Text("Favorites"),
              ),
              SalomonBottomBarItem(
                icon: const Icon(CupertinoIcons.settings),
                title: const Text("Settings"),
              ),
            ],
          );
        }),
      ),
    );
  }
}
