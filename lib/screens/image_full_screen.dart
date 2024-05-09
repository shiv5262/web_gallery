import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:web_gallery_app/controllers/images_controller.dart';

class ImageFullScreen extends StatelessWidget {
  const ImageFullScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var imagesController = Get.find<ImagesController>();
    return Hero(
      tag: imagesController.selectedImage!.previewURL!,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          leading: IconButton(
            onPressed: () => Get.back(),
            icon: const Icon(
              Icons.close,
            ),
          ),
        ),
        body: Center(
          child: CachedNetworkImage(
            imageUrl: imagesController.selectedImage!.largeImageURL!,
            errorWidget: (context, url, error) => const Icon(Icons.error),
            placeholder: (context, url) => SizedBox(
              width: Get.height,
              height: Get.height,
              child: Shimmer.fromColors(
                baseColor: Colors.grey,
                highlightColor: Colors.grey.shade200,
                child: Container(
                  color: Colors.black,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
