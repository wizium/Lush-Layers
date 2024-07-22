import 'dart:convert';
import 'package:http/http.dart' as http;

import '../model/tag.dart';
import '../model/wallpaper.dart';

List<WallPaper> walls = [];
List<WallPaper> wallsS = [];
WallPaper wall = WallPaper();
Future<List<WallPaper>> categoryDataFetcher(String categoryName, String mode,
    int? categories, int? purity, int? pageNumber) async {
  http
      .get(
    Uri.parse(
        "https://wallhaven.cc/api/v1/search?q=$categoryName&page=${pageNumber ?? 1}&categories=$categories&purity=$purity"),
  )
      .then(
    (http.Response response) {
      final resp = json.decode(response.body);
      for (int i = 0; i < (resp["data"].length as int); i++) {
        walls.add(
          WallPaper(
              id: resp["data"][i]["id"].toString(),
              url: resp["data"][i]["url"].toString(),
              shortUrl: resp["data"][i]["short_url"].toString(),
              views: resp["data"][i]["views"].toString(),
              favorites: resp["data"][i]["favorites"].toString(),
              category: resp["data"][i]["category"].toString(),
              dimensionX: resp["data"][i]["dimension_x"].toString(),
              dimensionY: resp["data"][i]["dimension_y"].toString(),
              resolution: resp["data"][i]["resolution"].toString(),
              fileSize: resp["data"][i]["file_size"].toString(),
              colors: resp["data"][i]["colors"] as List?,
              path: resp["data"][i]["path"].toString(),
              thumbs: resp["data"][i]["thumbs"] as Map?,
              currentPage: resp["meta"]["current_page"] as int?),
        );
      }
      return walls;
    },
  );
  return walls;
}

Future<List<WallPaper>> getData(
    String mode, int? categories, int? purity, int? pageNumber) async {
  http
      .get(
    Uri.parse(
        "https://wallhaven.cc/api/v1/search?page=${pageNumber ?? 1}&categories=$categories&purity=$purity&sorting=toplist&order=des"),
  )
      .then(
    (http.Response response) {
      final resp = json.decode(response.body);
      for (int i = 0; i < (resp["data"].length as int); i++) {
        walls.add(
          WallPaper(
              id: resp["data"][i]["id"].toString(),
              url: resp["data"][i]["url"].toString(),
              shortUrl: resp["data"][i]["short_url"].toString(),
              views: resp["data"][i]["views"].toString(),
              favorites: resp["data"][i]["favorites"].toString(),
              category: resp["data"][i]["category"].toString(),
              dimensionX: resp["data"][i]["dimension_x"].toString(),
              dimensionY: resp["data"][i]["dimension_y"].toString(),
              resolution: resp["data"][i]["resolution"].toString(),
              fileSize: resp["data"][i]["file_size"].toString(),
              colors: resp["data"][i]["colors"] as List?,
              path: resp["data"][i]["path"].toString(),
              thumbs: resp["data"][i]["thumbs"] as Map?,
              currentPage: resp["meta"]["current_page"] as int?),
        );
      }
      return walls;
    },
  ).catchError((e) {
    return walls;
  });
  return walls;
}

Future<WallPaper> getWallByID(String idU) async {
  final String id = idU.toLowerCase();
  wall = WallPaper();
  http
      .get(
    Uri.parse("https://wallhaven.cc/api/v1/w/$id"),
  )
      .then(
    (http.Response response) {
      final resp = json.decode(response.body)["data"];
      print(response.body);
      wall = WallPaper(
        id: resp["id"].toString(),
        url: resp["url"].toString(),
        shortUrl: resp["short_url"].toString(),
        views: resp["views"].toString(),
        favorites: resp["favorites"].toString(),
        category: resp["category"].toString(),
        dimensionX: resp["dimension_x"].toString(),
        dimensionY: resp["dimension_y"].toString(),
        resolution: resp["resolution"].toString(),
        fileSize: resp["file_size"].toString(),
        colors: resp["colors"] as List?,
        path: resp["path"].toString(),
        thumbs: resp["thumbs"] as Map?,
        tags: List<Tag>.generate(
          resp["tags"].length as int,
          (tag) => Tag(
            id: resp["tags"][tag]["id"].toString(),
            name: resp["tags"][tag]["name"].toString(),
            alias: resp["tags"][tag]["alias"].toString(),
            categoryId: resp["tags"][tag]["category_id"].toString(),
            category: resp["tags"][tag]["category"].toString(),
          ),
        ),
      );
      return wall;
    },
  );
  return wall;
}

Future<List<WallPaper>> getWallsByQuery(
    String query, int? categories, int? purity) async {
  http
      .get(
    Uri.parse(
        "https://wallhaven.cc/api/v1/search?q=$query&page=1&categories=$categories&purity=$purity"),
  )
      .then(
    (http.Response response) {
      final resp = json.decode(response.body);
      print(response.body);
      for (int i = 0; i < (resp["data"].length as int); i++) {
        wallsS.add(
          WallPaper(
              id: resp["data"][i]["id"].toString(),
              url: resp["data"][i]["url"].toString(),
              shortUrl: resp["data"][i]["short_url"].toString(),
              views: resp["data"][i]["views"].toString(),
              favorites: resp["data"][i]["favorites"].toString(),
              category: resp["data"][i]["category"].toString(),
              dimensionX: resp["data"][i]["dimension_x"].toString(),
              dimensionY: resp["data"][i]["dimension_y"].toString(),
              resolution: resp["data"][i]["resolution"].toString(),
              fileSize: resp["data"][i]["file_size"].toString(),
              colors: resp["data"][i]["colors"] as List?,
              path: resp["data"][i]["path"].toString(),
              thumbs: resp["data"][i]["thumbs"] as Map?,
              currentPage: resp["meta"]["current_page"] as int?),
        );
      }
      return wallsS;
    },
  );
  return wallsS;
}

Future<List<WallPaper>> getWallsByQueryPage(
    String query, int? categories, int? purity, int? pageNumber) async {
  http
      .get(
    Uri.parse(
        "https://wallhaven.cc/api/v1/search?q=$query&page=${pageNumber ?? 1}&categories=$categories&purity=$purity"),
  )
      .then(
    (http.Response response) {
      final resp = json.decode(response.body);
      for (int i = 0; i < (resp["data"].length as int); i++) {
        wallsS.add(
          WallPaper(
              id: resp["data"][i]["id"].toString(),
              url: resp["data"][i]["url"].toString(),
              shortUrl: resp["data"][i]["short_url"].toString(),
              views: resp["data"][i]["views"].toString(),
              favorites: resp["data"][i]["favorites"].toString(),
              category: resp["data"][i]["category"].toString(),
              dimensionX: resp["data"][i]["dimension_x"].toString(),
              dimensionY: resp["data"][i]["dimension_y"].toString(),
              resolution: resp["data"][i]["resolution"].toString(),
              fileSize: resp["data"][i]["file_size"].toString(),
              colors: resp["data"][i]["colors"] as List?,
              path: resp["data"][i]["path"].toString(),
              thumbs: resp["data"][i]["thumbs"] as Map?,
              currentPage: resp["meta"]["current_page"] as int?),
        );
      }
      return wallsS;
    },
  );
  return wallsS;
}

// Your previously defined functions...

void main() async {
  // Test categoryDataFetcher function
  List<WallPaper> categoryWallpapers =
      await categoryDataFetcher('nature', 'search', 100, 100, 1);
  print('Category Wallpapers:');
  for (var wallpaper in categoryWallpapers) {
    print(wallpaper.url);
  }

  // Test getData function
  List<WallPaper> topWallpapers = await getData('toplist', 100, 100, 1);
  print('Top Wallpapers:');
  for (var wallpaper in topWallpapers) {
    print(wallpaper.url);
  }

  // Test getWallsByQuery function
  List<WallPaper> queryWallpapers = await getWallsByQuery('abstract', 100, 100);
  print('Query Wallpapers:');
  for (var wallpaper in queryWallpapers) {
    print(wallpaper.url);
  }

  // Test getWallsByQueryPage function
  List<WallPaper> queryPageWallpapers =
      await getWallsByQueryPage('city', 100, 100, 1);
  print('Query Page Wallpapers:');
  for (var wallpaper in queryPageWallpapers) {
    print(wallpaper.url);
  }
}
