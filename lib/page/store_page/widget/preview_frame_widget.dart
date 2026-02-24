import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tingle/common/widget/preview_network_image_widget.dart';

class FramePreviewWidget extends StatelessWidget {
  const FramePreviewWidget({super.key, required this.imageurl});
  final String imageurl;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.back();
      },
      child: CachedNetworkImage(
        imageUrl: imageurl,
        imageBuilder: (context, imageProvider) {
          return Container(
            height: Get.height,
            width: Get.width,
            decoration: BoxDecoration(image: DecorationImage(image: imageProvider)),
          );
        },
        placeholder: (context, url) => PostImagePlaceHolder(size: Get.height),
      ),
    );
  }
}
