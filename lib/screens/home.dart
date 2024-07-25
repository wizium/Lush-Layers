import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:wallpaper_app/screens/parallax.dart';
import '/models/get_controllers.dart';
import 'package:wallpaper_app/utils/fetch_code.dart';
import 'all_wallpapers.dart';
import 'category.dart';
import 'me.dart';

List screens = [
  AllWallpapers(title: "Wallpaper Android", requestType: RequestType.curated),
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
      extendBody: true,
      body: PageView(
        controller: pageController,
        children: [
          AllWallpapers(
            title: "Lush Layers",
            requestType: RequestType.curated,
          ),
          const Categories(),
          const DesktopWallpapers(),
          const Settings()
        ],
        onPageChanged: (index) {
          navigationController.selectedIndex!.value = index;
        },
      ),
      bottomNavigationBar: Obx(() {
        return BottomNavigationBar(
          selectedFontSize: Theme.of(context).textTheme.bodyMedium!.fontSize!,
          showUnselectedLabels: false,
          type: BottomNavigationBarType.fixed,
          currentIndex: navigationController.selectedIndex!.value,
          selectedIconTheme: IconThemeData(
            color: Theme.of(context).colorScheme.surface,
          ),
          unselectedIconTheme: IconThemeData(
            color: Theme.of(context).colorScheme.inverseSurface,
          ),
          selectedLabelStyle: TextStyle(
            color: Theme.of(context).colorScheme.primary,
          ),
          onTap: (value) {
            pageController.jumpToPage(value);
            navigationController.navigate(value);
          },
          items: [
            BottomNavigationBarItem(
              icon: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(14),
                  color: navigationController.selectedIndex!.value == 0
                      ? Theme.of(context).colorScheme.primary
                      : null,
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 15,
                  vertical: 3,
                ),
                child: const Icon(Iconsax.image4),
              ),
              label: "Home",
            ),
            BottomNavigationBarItem(
              icon: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(14),
                  color: navigationController.selectedIndex!.value == 1
                      ? Theme.of(context).colorScheme.primary
                      : null,
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 15,
                  vertical: 3,
                ),
                child: const Icon(Iconsax.category_2),
              ),
              label: "Category",
            ),
            BottomNavigationBarItem(
              icon: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(14),
                  color: navigationController.selectedIndex!.value == 2
                      ? Theme.of(context).colorScheme.primary
                      : null,
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 15,
                  vertical: 3,
                ),
                child: const Icon(CupertinoIcons.device_desktop),
              ),
              label: "Desktop",
            ),
            BottomNavigationBarItem(
              icon: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(14),
                  color: navigationController.selectedIndex!.value == 3
                      ? Theme.of(context).colorScheme.primary
                      : null,
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 15,
                  vertical: 3,
                ),
                child: const Icon(Iconsax.security_user4),
              ),
              label: "Me",
            ),
          ],
        );
      }),
    );
  }
}
