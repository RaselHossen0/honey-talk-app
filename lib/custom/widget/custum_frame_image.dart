import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_svga/flutter_svga.dart';
import 'package:tingle/utils/api_params.dart';

import '../../common/widget/preview_network_image_widget.dart';
// Update with actual path

class CustomSVGAFrameWidget extends StatelessWidget {
  final String imagePath;
  final String? framePath;
  final String? itemType;
  final int type;
  final double width;
  final double height;
  final EdgeInsets? svgapadding;
  final EdgeInsets? imagepadding;
  final BorderRadius? borderRadius;

  const CustomSVGAFrameWidget({
    super.key,
    required this.imagePath,
    required this.itemType,
    this.framePath,
    required this.type,
    this.width = 50,
    this.height = 50,
    this.svgapadding,
    this.imagepadding,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    if (type == 3) {
      return framePath != null && framePath!.isNotEmpty
          ? Padding(
              padding: imagepadding ?? EdgeInsets.zero,
              child: CachedNetworkImage(
                imageUrl: framePath!,
                width: width + 10,
                height: height + 10,
                fit: BoxFit.cover,
                imageBuilder: (context, imageProvider) {
                  return Container(
                    width: width + 30,
                    height: height + 30,
                    decoration: BoxDecoration(
                      borderRadius: borderRadius ?? BorderRadius.circular(15),
                      image: DecorationImage(image: imageProvider, fit: BoxFit.cover),
                    ),
                  );
                },
                errorWidget: (context, url, error) => const PostImagePlaceHolder(),
                placeholder: (context, url) => const PostImagePlaceHolder(),
              ),
            )
          : Padding(
              padding: svgapadding ?? EdgeInsets.all(6.0),
              child: SizedBox(
                height: height + 10,
                width: width + 10,
                child: Center(
                  child: SVGAEasyPlayer(
                    resUrl: imagePath,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            );
    } else if (itemType == ApiParams.themes) {
      return Padding(
        padding: imagepadding ?? EdgeInsets.zero,
        child: CachedNetworkImage(
          imageUrl: imagePath,
          width: width + 30,
          height: height + 30,
          fit: BoxFit.cover,
          errorWidget: (context, url, error) => const PostImagePlaceHolder(),
          placeholder: (context, url) => const PostImagePlaceHolder(),
          imageBuilder: (context, imageProvider) {
            return Container(
              width: width + 30,
              height: height + 30,
              decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                borderRadius: borderRadius ?? BorderRadius.circular(15),
                image: DecorationImage(image: imageProvider, fit: BoxFit.cover),
              ),
            );
          },
        ),
      );
    } else {
      return Padding(
        padding: imagepadding ?? EdgeInsets.zero,
        child: CachedNetworkImage(
          imageUrl: imagePath,
          width: width + 30,
          height: height + 30,
          fit: BoxFit.cover,
          errorWidget: (context, url, error) => const PostImagePlaceHolder(),
          placeholder: (context, url) => const PostImagePlaceHolder(),
          imageBuilder: (context, imageProvider) {
            return Container(
              width: width + 30,
              height: height + 30,
              decoration: BoxDecoration(
                borderRadius: borderRadius ?? BorderRadius.circular(15),
                image: DecorationImage(image: imageProvider, fit: BoxFit.cover),
              ),
            );
          },
        ),
      );
    }
  }
}
