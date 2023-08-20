import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'Data/categories.dart';
import 'models/image_list.dart';
import 'screens/home.dart';

ImageListMethods imageList = ImageListMethods(images: imagesList);
ImageListMethods recommendedImage = ImageListMethods(
  images: recommendedImages);
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
      theme: ThemeData(
        primarySwatch: Colors.green,
        textTheme: const TextTheme(
          headlineMedium: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        useMaterial3: true,
        chipTheme: ChipThemeData(
          elevation: 6,
          shadowColor: Colors.black.withOpacity(.4),
          side: BorderSide(
            color: Colors.black.withOpacity(.02),
          ),
        ),
      ),
      home: const Home(),
      debugShowCheckedModeBanner: false,
    );
  }
}
