import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';
import 'package:tingle/utils/color.dart';
import 'package:tingle/utils/font_style.dart';
import 'package:tingle/utils/utils.dart';

class AlertMessageWidget extends StatelessWidget {
  const AlertMessageWidget({
    super.key,
    required this.title,
    required this.subTitle,
    required this.image,
    required this.gradient,
    required this.color,
    this.messageCount,
    this.dateTime,
    required this.callback,
    required this.imageSize,
  });

  final String title;
  final String subTitle;
  final String image;
  final Color color;
  final double imageSize;
  final Gradient gradient;
  final int? messageCount;
  final String? dateTime;
  final Callback callback;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: callback,
      child: Container(
        height: 80,
        width: Get.width,
        padding: const EdgeInsets.symmetric(horizontal: 15),
        decoration: BoxDecoration(
          color: AppColor.transparent,
          border: Border(bottom: BorderSide(color: AppColor.white.withValues(alpha: 0.5))),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: 55,
              width: 55,
              alignment: Alignment.center,
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: gradient,
              ),
              child: Image.asset(image, width: imageSize),
            ),
            12.width,
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Row(
                          children: [
                            Flexible(
                              fit: FlexFit.loose,
                              child: Text(
                                title,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: AppFontStyle.styleW700(AppColor.black, 16),
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                              margin: const EdgeInsets.only(left: 10),
                              decoration: BoxDecoration(
                                color: AppColor.white,
                                borderRadius: BorderRadius.circular(100),
                              ),
                              child: Text(
                                "Official",
                                style: AppFontStyle.styleW600(color, 10),
                              ),
                            ),
                          ],
                        ),
                      ),
                      10.width,
                      Visibility(
                        visible: messageCount != null && messageCount != 0,
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: const BoxDecoration(
                            color: AppColor.primary,
                            shape: BoxShape.circle,
                          ),
                          child: Text(
                            messageCount.toString(),
                            maxLines: 1,
                            style: AppFontStyle.styleW600(AppColor.white, 12),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text(
                          subTitle,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: AppFontStyle.styleW500(AppColor.lightGreyPurple, 12),
                        ),
                      ),
                      10.width,
                      Visibility(
                        visible: dateTime != null,
                        child: Text(
                          dateTime!,
                          style: AppFontStyle.styleW600(AppColor.lightGreyPurple, 12),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
