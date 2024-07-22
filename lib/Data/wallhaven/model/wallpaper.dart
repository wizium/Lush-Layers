import 'package:wallpaper_app/Data/wallhaven/model/tag.dart';

class WallPaper {
  final String? id;
  final String? url;
  final String? shortUrl;
  final String? views;
  final String? favorites;
  final String? category;
  final String? dimensionX;
  final String? dimensionY;
  final String? resolution;
  final String? fileSize;
  final List? colors;
  final String? path;
  final Map? thumbs;
  final List<Tag>? tags;
  final int? currentPage;
  WallPaper({
    this.id,
    this.url,
    this.shortUrl,
    this.views,
    this.favorites,
    this.category,
    this.dimensionX,
    this.dimensionY,
    this.resolution,
    this.fileSize,
    this.colors,
    this.path,
    this.thumbs,
    this.tags,
    this.currentPage,
  });
}
