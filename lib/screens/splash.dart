import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wallpaper_app/screens/home.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Timer(const Duration(seconds: 3), () {
      Get.offAll(() => const Home());
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          alignment: Alignment.center,
          fit: StackFit.expand,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  height: 80,
                  width: 80,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    image: const DecorationImage(
                      image: AssetImage(
                        "assets/appIcon.png",
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 20),
                Text(
                  "Lush Layers",
                  style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                        fontFamily: "AkayaKanadaka",
                        color: Theme.of(context).listTileTheme.iconColor,
                      ),
                ),
              ],
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.all(40),
                child: Text(
                  "The ultimate wallpaper app.",
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                        fontFamily: "AkayaKanadaka",
                        color: Theme.of(context).listTileTheme.iconColor,
                      ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
