import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';
import 'package:tingle/common/widget/preview_network_image_widget.dart';
import 'package:tingle/utils/assets.dart';
import 'package:tingle/utils/color.dart';
import 'package:tingle/utils/font_style.dart';
import 'package:tingle/utils/utils.dart';

class MessageUserWidget extends StatelessWidget {
  const MessageUserWidget({
    super.key,
    required this.title,
    required this.subTitle,
    required this.leading,
    this.messageCount,
    this.dateTime,
    required this.callback,
    required this.isVerified,
    required this.isProfileImageBanned,
    this.wealthLevel,
    this.isOnline,
  });

  final String title;
  final String subTitle;
  final String leading;
  final int? messageCount;
  final String? dateTime;
  final Callback callback;
  final bool isVerified;
  final bool isProfileImageBanned;
  final int? wealthLevel;
  final bool? isOnline;

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
          border: Border(bottom: BorderSide(color: AppColor.white.withValues(alpha: 0.3))),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  height: 55,
                  width: 55,
                  clipBehavior: Clip.antiAlias,
                  decoration: const BoxDecoration(shape: BoxShape.circle),
                  child: PreviewProfileImageWidget(image: leading, isBanned: isProfileImageBanned),
                ),
                if (isOnline == true)
                  Positioned(
                    right: 0,
                    bottom: 0,
                    child: Container(
                      width: 14,
                      height: 14,
                      decoration: BoxDecoration(
                        color: AppColor.green,
                        shape: BoxShape.circle,
                        border: Border.all(color: AppColor.white, width: 2),
                      ),
                    ),
                  ),
              ],
            ),
            12.width,
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Flexible(
                        fit: FlexFit.loose,
                        child: Text(
                          title,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: AppFontStyle.styleW700(AppColor.black, 15),
                        ),
                      ),
                      if (wealthLevel != null && wealthLevel! > 0)
                        Padding(
                          padding: const EdgeInsets.only(left: 3),
                          child: Text(
                            "👑$wealthLevel",
                            style: AppFontStyle.styleW600(AppColor.pink, 12),
                          ),
                        ),
                      Visibility(
                        visible: isVerified,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 3),
                          child: Image.asset(AppAssets.icAuthoriseIcon, width: 16),
                        ),
                      ),
                    ],
                  ),
                  3.height,
                  Text(
                    subTitle,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: AppFontStyle.styleW500(AppColor.lightGreyPurple, 11),
                  ),

                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.start,
                  //   crossAxisAlignment: CrossAxisAlignment.start,
                  //   children: [
                  //     Expanded(
                  //       child: Text(
                  //         subTitle,
                  //         maxLines: 1,
                  //         overflow: TextOverflow.ellipsis,
                  //         style: AppFontStyle.styleW500(AppColor.lightGreyPurple, 12),
                  //       ),
                  //     ),
                  //     10.width,
                  //     Visibility(
                  //       visible: dateTime != null,
                  //       child: Text(
                  //         dateTime!,
                  //         style: AppFontStyle.styleW600(AppColor.lightGreyPurple, 12),
                  //       ),
                  //     ),
                  //   ],
                  // ),
                ],
              ),
            ),
            10.width,
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (dateTime != null && dateTime!.isNotEmpty)
                  Text(
                    dateTime!,
                    style: AppFontStyle.styleW500(AppColor.lightGreyPurple, 11),
                  ),
                4.height,
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
                5.height,
              ],
            ),
          ],
        ),
      ),
    );
  }
}
