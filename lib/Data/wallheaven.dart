import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';

class WallHeavenWallpapers {
  final List<Wallpapers> wallpapers;
  final int totalPages;
  final int currentPage;
  final int totalWallpapers;
  final int nextPage;
  final bool hasMore;

  WallHeavenWallpapers({
    required this.wallpapers,
    required this.totalPages,
    required this.currentPage,
    required this.totalWallpapers,
    required this.nextPage,
    required this.hasMore,
  });

  static WallHeavenWallpapers fromJsonWallheaven({
    required String jsonData,
    required int currentPage,
    required String deviceType,
  }) {
    final Map<String, dynamic> data = jsonDecode(jsonData);
    List<dynamic> results = data["data"];

    List<Wallpapers> wallpapers = results.map((wallpaper) {
      final width = wallpaper["dimension_x"];
      final height = wallpaper["dimension_y"];
      return Wallpapers(
          title: wallpaper["id"].toUpperCase(),
          height: height,
          width: width,
          isPortrait: (height > width) ? true : false,
          thumbNail: wallpaper["thumbs"]
              [deviceType == DeviceType.mobile ? "original" : "large"],
          source: wallpaper["path"],
          ratio: double.parse(wallpaper["ratio"]),
          colors: wallpaper["colors"]);
    }).toList();

    int totalWallpapers = data["meta"]["total"];
    int totalPages = (totalWallpapers / 24).ceil();

    return WallHeavenWallpapers(
      wallpapers: wallpapers,
      totalPages: totalPages,
      currentPage: currentPage,
      totalWallpapers: totalWallpapers,
      nextPage: currentPage + 1,
      hasMore: currentPage < totalPages,
    );
  }

  static Future<WallHeavenWallpapers> fetchFromWallhaven(
      {String? name, required int page, required String deviceType}) async {
    var params = {
      'categories': '111',
      'purity': '100',
      'sorting': 'views',
      'page': '$page',
      "ratios": "landscape",
      "ai_art_filter": "1",
      "order": "desc"
    };
    params.addIf(deviceType == DeviceType.desktop, "ratios", "landscape");
    params.addIf(deviceType == DeviceType.mobile, "ratios", "portrait");
    if (name != null) {
      params["q"] = name;
    }
    final url = Uri.parse('https://wallhaven.cc/api/v1/search')
        .replace(queryParameters: params);

    final res = await get(url);
    final status = res.statusCode;
    if (status == 200) {
      return WallHeavenWallpapers.fromJsonWallheaven(
          jsonData: res.body, currentPage: page, deviceType: deviceType);
    } else {
      Fluttertoast.showToast(msg: "Failed to show wallpaper from Wallhaven.");
      throw Exception("Failed to get wallpaper from Wallhaven");
    }
  }

  static Future<WallHeavenWallpapers> getWallpaper({
    String? name,
    int page = 1,
    String type = DeviceType.mobile,
  }) async {
    return fetchFromWallhaven(name: name, page: page, deviceType: type);
  }
}

class DeviceType {
  static const String mobile = "\$mobilewallpapers";
  static const String desktop = "\$desktopwallpapers";
}

class Wallpapers {
  String title;
  int height;
  int width;
  bool isPortrait;
  String thumbNail;
  String source;
  double ratio;
  List colors;
  Wallpapers({
    required this.title,
    required this.height,
    required this.width,
    required this.isPortrait,
    required this.thumbNail,
    required this.source,
    required this.ratio,
    required this.colors,
  });

  static Future<String> toJson(Wallpapers wallpaper) async {
    return jsonEncode({
      'title': wallpaper.title,
      'height': wallpaper.height,
      'width': wallpaper.width,
      'isPortrait': wallpaper.isPortrait,
      'thumbNail': wallpaper.thumbNail,
      'source': wallpaper.source,
      'ratio': wallpaper.ratio,
      "colors": wallpaper.colors
    });
  }

  static List<Wallpapers> fromJsonFirebase({required List jsonData}) {
    final data = jsonData.map((wallpaper) => jsonDecode(wallpaper)).toList();
    return data.map((wallpaper) {
      return Wallpapers(
          title: wallpaper["title"],
          height: wallpaper["height"],
          width: wallpaper["width"],
          isPortrait: wallpaper["isPortrait"],
          thumbNail: wallpaper["thumbNail"],
          source: wallpaper["source"],
          ratio: double.parse(wallpaper["ratio"].toString()),
          colors: wallpaper["colors"]);
    }).toList();
  }
}
