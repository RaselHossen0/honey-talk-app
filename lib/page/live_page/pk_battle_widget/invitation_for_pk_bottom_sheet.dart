import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';
import 'package:tingle/common/widget/preview_network_image_widget.dart';
import 'package:tingle/utils/color.dart';
import 'package:tingle/utils/font_style.dart';
import 'package:tingle/utils/utils.dart';

class InvitationForPkBottomSheet {
  static bool isOpenBottomSheet = false;
  static Future<void> onShow({
    required String name,
    required String image,
    required String uniqueId,
    required bool isBanned,
    required Callback accept,
    required Callback reject,
  }) async {
    isOpenBottomSheet = true;
    await showModalBottomSheet(
      isScrollControlled: true,
      context: Get.context!,
      isDismissible: false,
      enableDrag: false,
      backgroundColor: AppColor.transparent,
      builder: (context) => PopScope(
        canPop: false,
        child: Container(
          height: 250,
          width: Get.width,
          clipBehavior: Clip.antiAlias,
          decoration: const BoxDecoration(
            color: AppColor.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(40),
              topRight: Radius.circular(40),
            ),
          ),
          child: Column(
            children: [
              Container(
                height: 65,
                width: Get.width,
                color: AppColor.secondary.withValues(alpha: 0.1),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          height: 4,
                          width: 35,
                          decoration: BoxDecoration(
                            color: AppColor.grayText.withAlpha(76),
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        10.height,
                        Text(
                          "Invitation For Pk Battle",
                          style: AppFontStyle.styleW700(AppColor.black, 17),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              15.height,
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          height: 65,
                          width: 65,
                          clipBehavior: Clip.antiAlias,
                          decoration: BoxDecoration(shape: BoxShape.circle),
                          child: PreviewProfileImageWidget(image: image, isBanned: isBanned),
                        ),
                        10.width,
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              name,
                              style: AppFontStyle.styleW700(AppColor.black, 17),
                            ),
                            2.height,
                            Text(
                              "ID: $uniqueId",
                              style: AppFontStyle.styleW600(AppColor.grayText, 12),
                            ),
                          ],
                        ),
                      ],
                    ),
                    10.height,
                    Center(
                      child: Text(
                        "Join Pk battle to again more exposure and coins!",
                        style: AppFontStyle.styleW700(AppColor.black, 15),
                      ),
                    ),
                    15.height,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: reject,
                            child: Container(
                              height: 45,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: AppColor.red,
                                borderRadius: BorderRadius.circular(30),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.call_end_rounded,
                                    color: AppColor.white,
                                    size: 28,
                                  ),
                                  10.width,
                                  Text(
                                    "Reject",
                                    style: AppFontStyle.styleW700(AppColor.white, 16),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        10.width,
                        Expanded(
                          child: GestureDetector(
                            onTap: accept,
                            child: Container(
                              height: 45,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: AppColor.green,
                                borderRadius: BorderRadius.circular(30),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.phone_rounded,
                                    color: AppColor.white,
                                    size: 28,
                                  ),
                                  8.width,
                                  Text(
                                    "Accept",
                                    style: AppFontStyle.styleW700(AppColor.white, 16),
                                  ),
                                ],
                              ),
                            ),
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
      ),
    ).whenComplete(() => isOpenBottomSheet = false);
  }
}
