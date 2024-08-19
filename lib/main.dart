import 'dart:convert';
import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:json_theme/json_theme.dart';
import 'package:path_provider/path_provider.dart';
import 'package:wallpaper_app/screens/splash.dart';
import 'package:wallpaper_app/utils/settings.dart';

ThemeData? lightTheme;
ThemeData? darkTheme;
Box? settingsBox;
Settings settings = Get.put(Settings());
Directory? downloadPath;
void main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  downloadPath = await getDownloadsDirectory();
  Hive.init((await getApplicationDocumentsDirectory()).path);
  settingsBox = await Hive.openBox("settings");
  final lThemeStr = await rootBundle.loadString('assets/light_theme.json');
  final lThemeJson = jsonDecode(lThemeStr);
  lightTheme = ThemeDecoder.decodeThemeData(lThemeJson)!;
  final dThemeStr = await rootBundle.loadString('assets/dark_theme.json');
  final dThemeJson = jsonDecode(dThemeStr);
  darkTheme = ThemeDecoder.decodeThemeData(dThemeJson)!;
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    settings.themeStateUpdate();
    settings.proStateUpdate();
    settings.qualityStateUpdate();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return GetMaterialApp(
      darkTheme: darkTheme!.copyWith(
        listTileTheme:
            ListTileThemeData(iconColor: darkTheme!.colorScheme.primary),
      ),
      theme: lightTheme!.copyWith(
        listTileTheme:
            ListTileThemeData(iconColor: lightTheme!.colorScheme.secondary),
      ),
      themeMode: settings.dark.value ? ThemeMode.dark : ThemeMode.light,
      home: const SplashScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
