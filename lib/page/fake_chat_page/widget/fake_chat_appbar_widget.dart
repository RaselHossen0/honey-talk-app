import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tingle/common/widget/preview_network_image_widget.dart';
import 'package:tingle/page/fake_other_user_profile_bottom_sheet/view/fake_other_user_profile_bottom_sheet.dart';
import 'package:tingle/page/other_user_profile_bottom_sheet/view/other_user_profile_bottom_sheet.dart';
import 'package:tingle/utils/assets.dart';
import 'package:tingle/utils/color.dart';
import 'package:tingle/utils/font_style.dart';
import 'package:tingle/utils/utils.dart';

class FakeChatAppBarWidget {
  static PreferredSize appBar({
    required BuildContext context,
    required String name,
    required String image,
    required bool isVerify,
    required bool isBanned,
    required String userid,
  }) {
    return PreferredSize(
      preferredSize: const Size.fromHeight(100),
      child: Container(
        height: 100,
        padding: EdgeInsets.only(top: MediaQuery.of(context).viewPadding.top, right: 12),
        alignment: Alignment.center,
        width: Get.width,
        decoration: BoxDecoration(color: AppColor.white, boxShadow: [
          BoxShadow(
            color: AppColor.secondary.withValues(alpha: 0.1),
            blurRadius: 2,
            spreadRadius: 2,
          )
        ]),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: Get.back,
              child: Container(
                height: 45,
                width: 45,
                alignment: Alignment.center,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColor.transparent,
                ),
                child: Image.asset(AppAssets.icArrowLeft, width: 10),
              ),
            ),
            GestureDetector(
              onTap: () {
                log("LOGGGER 0111 $userid");
                FakeOtherUserProfileBottomSheet.show(
                  context: context,
                  userId: userid,
                );
              },
              child: Container(
                height: 47,
                width: 47,
                padding: const EdgeInsets.all(2),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: AppColor.secondary),
                ),
                child: Container(
                  clipBehavior: Clip.antiAlias,
                  decoration: const BoxDecoration(shape: BoxShape.circle),
                  child: PreviewProfileImageWidget(image: image, isBanned: isBanned),
                ),
              ),
            ),
            12.width,
            Expanded(
              child: GestureDetector(
                onTap: () {
                  log("LOGGGER  $userid");
                  if (userid.contains("user")) {
                    FakeOtherUserProfileBottomSheet.show(
                      context: context,
                      userId: userid,
                    );
                  } else {
                    OtherUserProfileBottomSheet.show(
                      context: context,
                      userId: userid,
                    );
                  }
                  // OtherUserProfileBottomSheet.show(context: context, userId: userid, isFake: false);
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Flexible(
                      fit: FlexFit.loose,
                      child: Text(
                        name,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: AppFontStyle.styleW700(AppColor.black, 16),
                      ),
                    ),
                    3.height,
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                          decoration: BoxDecoration(
                            color: AppColor.green.withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(100),
                          ),
                          child: Row(
                            children: [
                              const Icon(Icons.circle, size: 10, color: AppColor.green),
                              3.width,
                              Text(
                                "Online",
                                style: AppFontStyle.styleW600(AppColor.green, 10),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
