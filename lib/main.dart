import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wallpaper_app/theme.dart';
import 'Data/categories.dart';
import 'models/image_list.dart';
import 'screens/home.dart';

ImageListMethods imageList = ImageListMethods(images: imagesList);
ImageListMethods recommendedImage = ImageListMethods(images: recommendedImages);
late double height;
late double width;
void main(List<String> args) {
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
      darkTheme: ThemeData(
        // fontFamily: "Dosis-Font",
        colorScheme: ColorScheme.fromSeed(
          seedColor: pColor,
          brightness: Brightness.dark,
        ),
        iconButtonTheme: const IconButtonThemeData(
          style: ButtonStyle(
            elevation: WidgetStatePropertyAll(1),
            foregroundColor: WidgetStatePropertyAll(Colors.white),
          ),
        ),
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          foregroundColor: ColorScheme.fromSeed(
            seedColor: pColor,
            brightness: Brightness.dark,
          ).inversePrimary,
          backgroundColor: ColorScheme.fromSeed(
            seedColor: pColor,
            brightness: Brightness.dark,
          ).primary,
        ),
        chipTheme: ChipThemeData(
          elevation: 6,
          shadowColor: ColorScheme.fromSeed(
            seedColor: pColor,
            brightness: Brightness.dark,
          ).inversePrimary.withOpacity(.4),
          side: BorderSide(
            color: ColorScheme.fromSeed(
              seedColor: pColor,
              brightness: Brightness.dark,
            ).inversePrimary.withOpacity(.2),
          ),
        ),
      ),
      themeMode: ThemeMode.dark,
      home: const Home(),
      debugShowCheckedModeBanner: false,
    );
  }
}
