import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tingle/common/function/format_message_time.dart';
import 'package:tingle/common/widget/preview_network_image_widget.dart';
import 'package:tingle/utils/color.dart';
import 'package:tingle/utils/font_style.dart';

class ReceiverImageWidget extends StatelessWidget {
  const ReceiverImageWidget({super.key, required this.image, required this.time, required this.isBanned, required this.receiverImage, required this.receiverImageIsBanned});

  final String image;
  final String time;
  final bool isBanned;
  final String receiverImage;
  final bool receiverImageIsBanned;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Container(
          height: 30,
          width: 30,
          padding: const EdgeInsets.all(2),
          margin: EdgeInsets.only(right: 5, bottom: 15),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: AppColor.secondary),
          ),
          child: Container(
            clipBehavior: Clip.antiAlias,
            decoration: const BoxDecoration(shape: BoxShape.circle),
            child: PreviewProfileImageWidget(image: receiverImage, isBanned: receiverImageIsBanned),
          ),
        ),
        GestureDetector(
          child: Container(
            margin: EdgeInsets.only(bottom: 15),
            decoration: BoxDecoration(
              color: AppColor.transparent,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Container(
              height: 200,
              width: Get.width / 2.5,
              decoration: BoxDecoration(
                color: AppColor.transparent,
                borderRadius: BorderRadius.vertical(bottom: Radius.circular(20)),
              ),
              child: Stack(
                clipBehavior: Clip.antiAlias,
                alignment: Alignment.center,
                children: [
                  Container(
                    height: 250,
                    width: Get.width / 2.5,
                    clipBehavior: Clip.antiAlias,
                    decoration: BoxDecoration(
                      color: AppColor.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: PreviewPostImageWidget(image: image, fit: BoxFit.cover, isBanned: isBanned),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: LayoutBuilder(builder: (context, box) {
                      return Container(
                        height: box.maxHeight / 4,
                        width: box.maxWidth,
                        clipBehavior: Clip.antiAlias,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          gradient: LinearGradient(
                            colors: [AppColor.transparent, AppColor.black.withValues(alpha: 0.8)],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                          ),
                        ),
                      );
                    }),
                  ),
                  Positioned(
                    bottom: 8,
                    right: 15,
                    child: Text(
                      FormatMessageTime.onConvert(time),
                      style: AppFontStyle.styleW500(AppColor.white, 10),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
