import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:parallax_cards/parallax_cards.dart';

class ParallaxScreen extends StatefulWidget {
  const ParallaxScreen({super.key});

  @override
  State<ParallaxScreen> createState() => _ParallaxScreenState();
}

class _ParallaxScreenState extends State<ParallaxScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: List.generate(5, (index) => buildParallaxListView()),
        ),
      ),
    );
  }

  Widget buildParallaxListView() {
    return Padding(
      padding: const EdgeInsets.all(5),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: ParallaxCards(
          borderRadius: BorderRadius.circular(15),
          imagesList: const [
            "assets/appBarBackground.jpg",
            "assets/appBarBackground.jpg",
            "assets/appBarBackground.jpg",
            "assets/appBarBackground.jpg",
            "assets/appBarBackground.jpg",
            "assets/appBarBackground.jpg",
            "assets/appBarBackground.jpg",
          ],
          overlays: [
            Stack(
              alignment: Alignment.bottomCenter,
              children: [
                Container(
                  height: 1,
                  decoration: const BoxDecoration(boxShadow: [
                    BoxShadow(
                      color: Colors.black,
                      spreadRadius: 30,
                      blurRadius: 30,
                      offset: Offset.zero,
                    )
                  ]),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Align(
                        alignment: Alignment.topRight,
                        child: Container(
                          height: 25,
                          width: 50,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: Theme.of(context).colorScheme.primary,
                          ),
                          child: Center(
                            child: Text(
                              "30+",
                              style: Theme.of(context)
                                  .textTheme
                                  .titleSmall
                                  ?.copyWith(color: Colors.black),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Align(
                          alignment: Alignment.bottomLeft,
                          child: Text(
                            "Dreamy Nature",
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge
                                ?.copyWith(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(),
            const SizedBox(),
            const SizedBox(),
            const SizedBox(),
            const SizedBox(),
            Stack(
              alignment: Alignment.center,
              children: [
                Align(
                  alignment: Alignment.centerRight,
                  child: Container(
                    width: Get.width * .1,
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(.9),
                          spreadRadius: 40,
                          blurRadius: 30,
                          offset: Offset.zero,
                        )
                      ],
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "View More",
                      style: Theme.of(context)
                          .textTheme
                          .titleLarge
                          ?.copyWith(fontWeight: FontWeight.bold),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: LottieBuilder.asset(
                        "assets/arrowRight.json",
                        width: 50,
                      ),
                    )
                  ],
                )
              ],
            )
          ],
          scrollDirection: Axis.horizontal,
          thickness: 0,
          margin: const EdgeInsets.symmetric(horizontal: 5),
          height: Get.height * .3,
          width: Get.width * .85,
        ),
      ),
    );
  }
}
