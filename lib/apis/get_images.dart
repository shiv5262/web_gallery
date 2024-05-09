import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

Dio dio = Dio();

class GetImagesApi {
  final apiKey = "43775490-6e813391b079a55d5d5dc8009";
  Future getImages({
    required int pageNumber,
  }) async {
    try {
      Response response = await dio.get(
        "https://pixabay.com/api/?key=$apiKey&page=$pageNumber&per_page=50",
        options: Options(
            followRedirects: false,
            validateStatus: (status) {
              return status! <= 500;
            }),
      );
      return response;
    } on DioException catch (dioError) {
      debugPrint(dioError.message);
    }
  }

  Future searchImages({
    required int pageNumber,
    required String searchText,
  }) async {
    try {
      Response response = await dio.get(
        "https://pixabay.com/api/?key=$apiKey&q=$searchText&page=$pageNumber&per_page=50",
        options: Options(
            followRedirects: false,
            validateStatus: (status) {
              return status! <= 500;
            }),
      );
      return response;
    } on DioException catch (dioError) {
      debugPrint(dioError.message);
    }
  }
}
