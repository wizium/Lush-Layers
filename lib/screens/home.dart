import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '/models/get_controllers.dart';
import 'package:wallpaper_app/utils/fetch_code.dart';
import 'all_wallpapers.dart';
import 'category.dart';
import 'me.dart';

List screens = [
  AllWallpapers(
    title: "Wallpaper",
  ),
  const Categories(),
  const Settings(),
];


class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  NavigationController navigationController = Get.put(NavigationController());
  final PageController pageController = PageController();
  @override
  void dispose() {
    super.dispose();
    navigationController.dispose();
    pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Obx(() {
        return BottomNavigationBar(
          currentIndex: navigationController.selectedIndex!.value,
          selectedIconTheme: const IconThemeData(
            color: Colors.black,
          ),
          showSelectedLabels: false,
          showUnselectedLabels: false,
          type: BottomNavigationBarType.fixed,
          onTap: (value) {
            navigationController.navigate(value);
            pageController.jumpToPage(value);
          },
          backgroundColor: Colors.lightGreenAccent,
          items: const [
            BottomNavigationBarItem(
              label: "Categories",
              icon: Icon(
                CupertinoIcons.house_fill,
              ),
            ),
            BottomNavigationBarItem(
              label: "Categories",
              icon: Icon(
                Icons.grid_view_rounded,
              ),
            ),
            BottomNavigationBarItem(
              label: "Categories",
              icon: Icon(
                Icons.account_circle_outlined,
              ),
            ),
          ],
        );
      }),
      body: PageView(
        controller: pageController,
        children: [
          AllWallpapers(
            title: "Wallpaper",
            requestType: RequestType.curated,
          ),
          const Categories(),
          const Settings()
        ],
      ),
    );
  }
}
