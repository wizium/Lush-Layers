import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wallpaper_app/main.dart';

class Settings extends GetxController {
  RxBool isPro = false.obs;
  RxBool dark = true.obs;
  RxBool quality = true.obs;
  qualityStateUpdate() async {
    quality.value = settingsBox!.get("quality", defaultValue: true);
  }

  qualityStateSave(bool value) async {
    await settingsBox!.put("quality", value);
    qualityStateUpdate();
  }

  proStateUpdate() {
    isPro.value = settingsBox!
        .get(
          "endDate",
          defaultValue: DateTime.now().subtract(
            const Duration(days: 1),
          ),
        )
        .isAfter(DateTime.now());
  }

  proStateSave(Timestamp endDate) async {
    await settingsBox!.put("endDate", endDate.toDate());
    proStateUpdate();
  }

  themeStateSave(bool theme) async {
    dark.value = theme;
    Get.changeThemeMode(dark.value ? ThemeMode.dark : ThemeMode.light);
    await settingsBox!.put("isDark", dark.value);
  }

  themeStateUpdate() {
    dark.value = settingsBox!.get("isDark", defaultValue: true);
  }
}
