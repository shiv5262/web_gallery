import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:web_gallery_app/controllers/images_controller.dart';
import 'package:web_gallery_app/widgets/image_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var imagesController = Get.find<ImagesController>();
    final currentCount = (MediaQuery.of(context).size.width ~/ 200).toInt();
    const minCount = 2;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text('Image Gallery'),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(40),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              style: const TextStyle(color: Colors.white),
              onChanged: (_) => imagesController.onChangeSearchHandler(),
              controller: imagesController.searchTextController,
              textAlignVertical: TextAlignVertical.center,
              decoration: InputDecoration(
                prefixIcon: const Icon(
                  Icons.search,
                  color: Colors.white,
                ),
                suffixIcon: IconButton(
                    onPressed: () {
                      imagesController.searchTextController.clear();
                      imagesController.showSearchList.value = false;
                      imagesController.searchErrorText.value = '';
                    },
                    icon: const Icon(
                      Icons.close,
                      color: Colors.white,
                    )),
                fillColor: Colors.grey.shade900,
                filled: true,
                hintText: 'Search Images',
                hintStyle: const TextStyle(color: Colors.grey),
                contentPadding: const EdgeInsets.only(top: 3),
                labelStyle: const TextStyle(color: Colors.white),
                border: OutlineInputBorder(
                  borderSide: const BorderSide(width: 1, color: Colors.white),
                  borderRadius: BorderRadius.circular(25),
                ),
              ),
            ),
          ),
        ),
      ),
      body: Obx(
        () => imagesController.imageList.isEmpty
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : imagesController.searchErrorText.isEmpty
                ? GridView.builder(
                    shrinkWrap: true,
                    physics: const ScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: max(currentCount, minCount),
                      crossAxisSpacing: 5,
                      mainAxisSpacing: 5,
                    ),
                    itemCount: imagesController.showSearchList.value
                        ? imagesController.searchList.length
                        : imagesController.imageList.length,
                    itemBuilder: (context, index) {
                      if (imagesController.showSearchList.value &&
                          index == imagesController.searchList.length - 10) {
                        imagesController.loadMoreSearchimages();
                      } else if (index ==
                          imagesController.imageList.length - 10) {
                        imagesController.loadMoreImages();
                      }
                      return Hero(
                        tag: imagesController.showSearchList.value
                            ? imagesController.searchList[index].previewURL!
                            : imagesController.imageList[index].previewURL!,
                        child: ImageCard(
                          imageModel: imagesController.showSearchList.value
                              ? imagesController.searchList[index]
                              : imagesController.imageList[index],
                        ),
                      );
                    },
                  )
                : Center(
                    child: Text(
                      'No result found.',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
      ),
    );
  }
}
