class ImageListMethods {
  List images = [];
  List<ImageListModel> refinedList = [];
  ImageListMethods({required this.images});
  void initialize() {
    for (var image in images) {
      refinedList.add(
        ImageListModel(
          path: image["imagePath"],
          name: image["name"],
        ),
      );
    }
  }
}

class ImageListModel {
  String name;
  String path;
  ImageListModel({
    required this.path,
    required this.name,
  });
}
