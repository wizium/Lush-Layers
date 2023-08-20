class ResponseModel {
  String? nextPage;
  String? prevPage;
  int? pageNumber;
  int? prevPageNum;
  int? nextPageNum;
  List<PhotosModel>? photosList;
  ResponseModel({
    required this.nextPageNum,
    required this.prevPageNum,
    required this.pageNumber,
    required this.nextPage,
    required this.prevPage,
    required this.photosList,
  });
}

class PhotosModel {
  String name;
  String portraitLink;
  String photoGrapher;
  String thumbnail;
  PhotosModel({
    required this.thumbnail,
    required this.name,
    required this.portraitLink,
    required this.photoGrapher,
  });
}
