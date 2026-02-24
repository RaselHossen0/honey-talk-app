import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tingle/custom/widget/custum_frame_image.dart';
import 'package:tingle/utils/api_params.dart';

class PreviewThemView extends StatelessWidget {
  final int type;
  final String imagePath;
  final String itemType;
  final String framePath;

  const PreviewThemView({
    super.key,
    required this.type,
    required this.imagePath,
    required this.itemType,
    required this.framePath,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Center(
        child: InkWell(
          onTap: () {
            log("onTap OFF");
            Get.back();
          },
          child: SizedBox(
            height: itemType == ApiParams.themes ? Get.height : Get.width,
            width: Get.width,
            child: CustomSVGAFrameWidget(
              type: type,
              itemType: itemType.toString(),
              height: Get.height,
              width: Get.width,
              imagePath: imagePath,
              framePath: "",
              svgapadding: EdgeInsets.zero,
            ),
          ),
        ),
      ),
    );
  }
}
