import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';
import 'package:tingle/common/widget/preview_network_image_widget.dart';
import 'package:tingle/custom/function/custom_format_number.dart';
import 'package:tingle/utils/assets.dart';
import 'package:tingle/utils/color.dart';
import 'package:tingle/utils/enums.dart';
import 'package:tingle/utils/font_style.dart';
import 'package:tingle/utils/utils.dart';

class YouWinPkBottomSheet {
  static bool isOpenBottomSheet = false;
  static Future<void> onShow({
    required String h1Name,
    required String h1Image,
    required String h2Name,
    required String h2Image,
    required bool h1IsBanned,
    required bool h2IsBanned,
    required int h1Rank,
    required int h2Rank,
    required Callback battleAgainCallback,
    required bool isHost,
  }) async {
    isOpenBottomSheet = true;
    await showModalBottomSheet(
      isScrollControlled: true,
      context: Get.context!,
      backgroundColor: AppColor.black.withValues(alpha: 0.9),
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
      builder: (context) => Container(
        height: Get.height,
        width: Get.width,
        clipBehavior: Clip.antiAlias,
        decoration: const BoxDecoration(color: AppColor.transparent, borderRadius: BorderRadius.all(Radius.zero)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Image.asset(
              AppAssets.imgWin,
              fit: BoxFit.cover,
              height: 180,
              width: 180,
            ),
            10.height,
            Image.asset(
              AppAssets.imgYouAreBattleWinner,
              fit: BoxFit.cover,
              height: 120,
            ),
            20.height,
            SizedBox(
              height: 210,
              width: Get.width,
              child: Stack(
                children: [
                  Image.asset(
                    AppAssets.imgWinBg,
                    fit: BoxFit.cover,
                    height: 230,
                    width: Get.width,
                  ),
                  Positioned(
                    top: 20,
                    left: 10,
                    child: Image.asset(
                      AppAssets.imgCongrats,
                      fit: BoxFit.cover,
                      width: 100,
                    ),
                  ),
                  Positioned(
                    top: 60,
                    left: 15,
                    child: Image.asset(
                      AppAssets.imgYouWin,
                      fit: BoxFit.cover,
                      width: 170,
                    ),
                  ),
                  Positioned(
                    top: 10,
                    right: 15,
                    child: Image.asset(
                      AppAssets.imgWinEmoji,
                      fit: BoxFit.cover,
                      width: 160,
                    ),
                  ),
                  Positioned(
                    bottom: 15,
                    child: SizedBox(
                      width: Get.width,
                      child: Container(
                        height: 70,
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        margin: EdgeInsets.symmetric(horizontal: 15),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              padding: EdgeInsets.all(1),
                              decoration: BoxDecoration(
                                color: AppColor.primary,
                                shape: BoxShape.circle,
                              ),
                              child: Container(height: 50, width: 50, clipBehavior: Clip.antiAlias, decoration: BoxDecoration(shape: BoxShape.circle), child: PreviewProfileImageWidget()),
                            ),
                            10.width,
                            Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Image.asset(
                                    AppAssets.imgResultPk,
                                    width: 60,
                                  ),
                                  5.height,
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          h1Name,
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: AppFontStyle.styleW600(AppColor.black, 13),
                                        ),
                                      ),
                                      15.width,
                                      Expanded(
                                        child: Text(
                                          h2Name,
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: AppFontStyle.styleW600(AppColor.black, 13),
                                        ),
                                      ),
                                    ],
                                  ),
                                  5.height,
                                  Container(
                                    height: 17,
                                    width: Get.width,
                                    decoration: BoxDecoration(
                                      color: AppColor.transparent,
                                      borderRadius: BorderRadius.circular(100),
                                    ),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          flex: h1Rank + 50,
                                          child: Container(
                                            height: 17,
                                            alignment: Alignment.center,
                                            padding: EdgeInsets.only(left: 3),
                                            decoration: BoxDecoration(
                                              color: AppColor.lightBlue,
                                              borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(100),
                                                bottomLeft: Radius.circular(100),
                                              ),
                                            ),
                                            child: Row(
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              children: [
                                                Padding(
                                                  padding: const EdgeInsets.only(top: 2, right: 2),
                                                  child: Image.asset(AppAssets.icCircleBlurStar, width: 15),
                                                ),
                                                Text(
                                                  CustomFormatNumber.onConvert(h1Rank),
                                                  style: AppFontStyle.styleW700(AppColor.white, 10),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          flex: h2Rank + 50,
                                          child: Container(
                                            height: 17,
                                            alignment: Alignment.center,
                                            padding: EdgeInsets.only(right: 3),
                                            decoration: BoxDecoration(
                                              color: AppColor.pink,
                                              borderRadius: BorderRadius.only(
                                                topRight: Radius.circular(100),
                                                bottomRight: Radius.circular(100),
                                              ),
                                            ),
                                            child: Row(
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              mainAxisAlignment: MainAxisAlignment.end,
                                              children: [
                                                Text(
                                                  CustomFormatNumber.onConvert(h2Rank),
                                                  style: AppFontStyle.styleW700(AppColor.white, 10),
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets.only(top: 2, left: 2),
                                                  child: Image.asset(AppAssets.icCircleBlurStar, width: 15),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            10.width,
                            Container(
                              padding: EdgeInsets.all(1),
                              decoration: BoxDecoration(
                                color: AppColor.primary,
                                shape: BoxShape.circle,
                              ),
                              child: Container(
                                height: 50,
                                width: 50,
                                clipBehavior: Clip.antiAlias,
                                decoration: BoxDecoration(shape: BoxShape.circle),
                                child: PreviewProfileImageWidget(),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            GestureDetector(
              onTap: () => Get.back(),
              child: Container(
                height: 100,
                width: Get.width,
                padding: EdgeInsets.symmetric(horizontal: 15),
                decoration: BoxDecoration(color: AppColor.white),
                child: Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        child: Container(
                          height: 55,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: AppColor.red,
                            borderRadius: BorderRadius.circular(50),
                          ),
                          child: Text(
                            EnumLocal.txtCancel.name.tr,
                            style: AppFontStyle.styleW600(AppColor.white, 16),
                          ),
                        ),
                      ),
                    ),
                    Visibility(
                      visible: isHost,
                      child: Expanded(
                        child: GestureDetector(
                          onTap: battleAgainCallback,
                          child: Container(
                            height: 55,
                            margin: EdgeInsets.only(left: 15),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: AppColor.primary,
                              borderRadius: BorderRadius.circular(50),
                            ),
                            child: Text(
                              "Battle again !",
                              style: AppFontStyle.styleW600(AppColor.white, 16),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    ).whenComplete(() => isOpenBottomSheet = false);
  }
}
