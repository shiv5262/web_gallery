import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:web_gallery_app/apis/get_images.dart';

import '../models/image_model.dart';

class ImagesController extends SuperController {
  RxList<ImageModel> imageList = <ImageModel>[].obs;
  RxList<ImageModel> searchList = <ImageModel>[].obs;
  TextEditingController searchTextController = TextEditingController();

  ImageModel? selectedImage;
  int pageNumber = 0;

  int searchPageNumber = 0;

  int pageNumberForSearch = 1;

  Rx<String> searchErrorText = ''.obs;
  RxBool showSearchList = false.obs;
  Timer? typingStopTimer;

  clearSearchField() {
    searchTextController.clear();
  }

  Future<void> getImages() async {
    pageNumber = 1;
    return await getImagesByPageNumber(pageNumber, true);
  }

  Future<void> getImagesByPageNumber(int pageNumber, bool clearExisting) async {
    try {
      if (clearExisting) {
        imageList.clear();
      }
      var response = await GetImagesApi().getImages(pageNumber: pageNumber);
      if (response.statusCode == 200) {
        List data = response.data['hits'];
        for (var image in data) {
          imageList.add(ImageModel.fromJson(image));
        }
      } else {}
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> loadMoreImages() async {
    return await getImagesByPageNumber(++pageNumber, false);
  }

  Future<void> getSearchImagesByPageNumber(
      int pageNumber, bool clearExisting) async {
    try {
      searchErrorText.value = '';
      String searchText = searchTextController.text;
      showSearchList.value = true;
      if (clearExisting) {
        searchList.clear();
      }
      var response = await GetImagesApi()
          .searchImages(searchText: searchText, pageNumber: pageNumber);
      if (response.statusCode == 200) {
        List data = response.data['hits'];
        if (data.isEmpty) {
          searchErrorText.value = 'No results found';
        } else {
          for (var image in data) {
            searchList.add(ImageModel.fromJson(image));
          }
        }
      }
    } catch (e) {
      searchErrorText.value = 'Something went wrong.';
      print(e.toString());
    }
  }

  Future<void> searchImages() async {
    searchPageNumber = 1;
    return await getSearchImagesByPageNumber(pageNumber, true);
  }

  Future<void> loadMoreSearchimages() async {
    return await getSearchImagesByPageNumber(++searchPageNumber, false);
  }

  onChangeSearchHandler() {
    const duration = Duration(
      seconds: 1,
    );
    if (typingStopTimer != null) {
      typingStopTimer!.cancel();
    }
    typingStopTimer = Timer(
      duration,
      () => searchImages(),
    );
  }

  @override
  void onInit() {
    getImages();
    super.onInit();
  }

  @override
  void onDetached() {
    // TODO: implement onDetached
  }

  @override
  void onHidden() {
    // TODO: implement onHidden
  }

  @override
  void onInactive() {
    // TODO: implement onInactive
  }

  @override
  void onPaused() {
    // TODO: implement onPaused
  }

  @override
  void onResumed() {
    // TODO: implement onResumed
  }
}
