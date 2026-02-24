import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';
import 'package:tingle/common/widget/preview_network_image_widget.dart';
import 'package:tingle/utils/color.dart';
import 'package:tingle/utils/font_style.dart';
import 'package:tingle/utils/utils.dart';

class SendingPkRequestBottomSheet {
  static bool isOpenBottomSheet = false;

  static Future<void> onShow({
    required BuildContext context,
    required String h1Name,
    required String h1Image,
    required bool isBannedH1Image,
    required String h2Name,
    required String h2Image,
    required bool isBannedH2Image,
    required Callback callback,
  }) async {
    isOpenBottomSheet = true;
    await showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      enableDrag: false,
      isDismissible: false,
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
                color: AppColor.secondary.withValues(alpha: 0.1),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Spacer(),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          height: 4,
                          width: 35,
                          decoration: BoxDecoration(
                            color: AppColor.grayText,
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        10.height,
                        Text(
                          "Waiting for response...",
                          style: AppFontStyle.styleW700(AppColor.black, 17),
                        ),
                      ],
                    ),
                    const Spacer(),
                  ],
                ),
              ),
              20.height,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        Container(
                          height: 70,
                          width: 70,
                          clipBehavior: Clip.antiAlias,
                          decoration: BoxDecoration(shape: BoxShape.circle),
                          child: PreviewProfileImageWidget(
                            image: h1Image,
                            isBanned: isBannedH1Image,
                          ),
                        ),
                        5.height,
                        Text(
                          h1Name,
                          style: AppFontStyle.styleW700(AppColor.black, 15),
                        ),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: callback,
                    child: Container(
                      height: 40,
                      width: 70,
                      clipBehavior: Clip.antiAlias,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: AppColor.red,
                      ),
                      child: Icon(Icons.call_end_rounded, size: 28, color: AppColor.white),
                    ),
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        Container(
                          height: 70,
                          width: 70,
                          clipBehavior: Clip.antiAlias,
                          decoration: BoxDecoration(shape: BoxShape.circle),
                          child: PreviewProfileImageWidget(
                            image: h2Image,
                            isBanned: isBannedH2Image,
                          ),
                        ),
                        5.height,
                        Text(
                          h2Name,
                          style: AppFontStyle.styleW700(AppColor.black, 15),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              20.height,
              Text(
                "Once matched, the battle will start!",
                style: AppFontStyle.styleW600(AppColor.black, 16),
              ),
              25.height,
            ],
          ),
        ),
      ),
    ).whenComplete(() => isOpenBottomSheet = false);
  }
}
