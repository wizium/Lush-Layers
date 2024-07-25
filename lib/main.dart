import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:json_theme/json_theme.dart';
import 'Data/categories.dart';
import 'models/image_list.dart';
import 'screens/home.dart';

ImageListMethods imageList = ImageListMethods(images: imagesList);
ImageListMethods recommendedImage = ImageListMethods(images: recommendedImages);
late double height;
late double width;
ThemeData? ligthTheme;
ThemeData? darkTheme;

void main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();
  final lThemeStr = await rootBundle.loadString('assets/light_theme.json');
  final lThemeJson = jsonDecode(lThemeStr);
  ligthTheme = ThemeDecoder.decodeThemeData(lThemeJson)!;
  final dThemeStr = await rootBundle.loadString('assets/dark_theme.json');
  final dThemeJson = jsonDecode(dThemeStr);
  darkTheme = ThemeDecoder.decodeThemeData(dThemeJson)!;

  runApp(const MyApp());

  recommendedImage.initialize();
  imageList.initialize();
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return GetMaterialApp(
      darkTheme: darkTheme,
      theme: ligthTheme,
      themeMode: ThemeMode.dark,
      home: const Home(),
      debugShowCheckedModeBanner: false,
    );
  }
}
