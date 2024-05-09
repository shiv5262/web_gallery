import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:web_gallery_app/controllers/images_controller.dart';

import '../models/image_model.dart';
import '../screens/image_full_screen.dart';

class ImageCard extends StatelessWidget {
  final ImageModel imageModel;
  const ImageCard({required this.imageModel, super.key});

  @override
  Widget build(BuildContext context) {
    var imagesController = Get.find<ImagesController>();
    return Card(
      child: GestureDetector(
        onTap: () {
          imagesController.selectedImage = imageModel;
          Get.to(
            () => const ImageFullScreen(),
          );
        },
        child: Container(
          margin: const EdgeInsets.all(5),
          padding: const EdgeInsets.all(5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: CachedNetworkImage(
                  imageUrl: imageModel.previewURL!,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const Icon(
                        Icons.thumb_up,
                        color: Colors.blue,
                        size: 14,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Text(
                          '${imageModel.likes}',
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(right: 8.0),
                        child: Icon(
                          Icons.remove_red_eye_sharp,
                          color: Colors.blue,
                          size: 14,
                        ),
                      ),
                      Text(
                        '${imageModel.views}',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
