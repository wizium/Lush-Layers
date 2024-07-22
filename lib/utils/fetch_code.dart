// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'dart:convert';
import '/models/response_model.dart';
import 'dart:math';

class ResponseData {
  int? requestType;
  ResponseData({required this.requestType});
  Future<ResponseModel?> fetch({required String parameter}) async {
    String? nextPage;
    String? prevPage;
    int pageNumber;
    int? prevPageNum;
    int? nextPageNum;
    Response response;
    Map responseBody;
    List<PhotosModel>? photosList = [];
    String? url;

    if (requestType == RequestType.page) {
      url = parameter;
    } else if (requestType == RequestType.category) {
      url =
          "https://api.pexels.com/v1/search?query=$parameter&per_page=18&page=1&orientation=portrait";
    } else if (requestType == RequestType.color) {
      url =
          "https://api.pexels.com/v1/search?query=wallpaper&color=$parameter&per_page=18&page=1&orientation=portrait";
    } else {
      url =
          "https://api.pexels.com/v1/search?query=mobile wallpaper&per_page=18&page=${Random.secure().nextInt(100)}&orientation=portrait";
    }
    try {
      response = await get(
          Uri.parse(
            url,
          ),
          headers: {
            "Authorization":
                "JXjYhdhoTZaNet5DcqlwJv03zjI9KMScffADq5xU2o2lWUyGMngScSrO"
          });
      if (response.statusCode == 200) {
        responseBody = jsonDecode(response.body);
        pageNumber = responseBody["page"];
        if (responseBody.containsKey("next_page")) {
          nextPage = responseBody["next_page"];
        }
        if (responseBody.containsKey("prev_page")) {
          prevPage = responseBody["prev_page"];
        }

        for (Map i in responseBody["photos"]) {
          photosList.add(
            PhotosModel(
                thumbnail: i["src"]!["medium"],
                name: i["alt"],
                portraitLink: i["src"]!["portrait"],
                photoGrapher: i["photographer"]),
          );
        }
        if (nextPage != null) {
          nextPageNum = pageNumber + 1;
        }
        if (prevPage != null) {
          prevPageNum = pageNumber - 1;
        }
        return ResponseModel(
          nextPageNum: nextPageNum,
          prevPageNum: prevPageNum,
          pageNumber: pageNumber,
          nextPage: nextPage,
          prevPage: prevPage,
          photosList: photosList,
        );
      } else {
        throw Exception("Something went wrong with ${response.statusCode}");
      }
    } catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }
}

class RequestType {
  static int? curated = 0;
  static int? category = 1;
  static int? page = 2;
  static int? color = 3;
}
