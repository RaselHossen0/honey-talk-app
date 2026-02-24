import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';
import 'package:tingle/common/widget/preview_network_image_widget.dart';
import 'package:tingle/utils/color.dart';
import 'package:tingle/utils/font_style.dart';
import 'package:tingle/utils/utils.dart';

class FakeAudioRoomSeatRequestDialogWidget {
  static Future<void> onShow({
    required String name,
    required String image,
    required int position,
    required bool isMediaBanned,
    required Callback onAccept,
    required Callback onDecline,
  }) async {
    Get.dialog(
      barrierColor: AppColor.black.withValues(alpha: 0.85),
      barrierDismissible: false,
      Dialog(
        backgroundColor: AppColor.transparent,
        elevation: 0,
        child: PopScope(
          canPop: false,
          child: Container(
            height: 280,
            width: 310,
            decoration: BoxDecoration(
              color: AppColor.white,
              borderRadius: BorderRadius.circular(15),
            ),
            child: Stack(
              clipBehavior: Clip.none,
              alignment: Alignment.center,
              children: [
                Container(
                  height: 270,
                  width: 310,
                  color: AppColor.transparent,
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  child: Column(
                    children: [
                      80.height,
                      Text(
                        "Audio request received from\n$name",
                        maxLines: 2,
                        textAlign: TextAlign.center,
                        style: AppFontStyle.styleW700(AppColor.black, 16),
                      ),
                      5.height,
                      Divider(color: AppColor.colorBorder),
                      5.height,
                      GestureDetector(
                        onTap: onAccept,
                        child: Container(
                          height: 50,
                          width: Get.width,
                          decoration: BoxDecoration(
                            gradient: AppColor.primaryGradient,
                            borderRadius: BorderRadius.circular(5),
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            "Accept",
                            textAlign: TextAlign.center,
                            style: AppFontStyle.styleW700(AppColor.white, 16),
                          ),
                        ),
                      ),
                      8.height,
                      GestureDetector(
                        onTap: onDecline,
                        child: Container(
                          height: 50,
                          width: Get.width,
                          decoration: BoxDecoration(
                            color: AppColor.primary.withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            "Decline",
                            textAlign: TextAlign.center,
                            style: AppFontStyle.styleW700(AppColor.black, 16),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  top: -60,
                  child: Container(
                    height: 120,
                    width: 120,
                    clipBehavior: Clip.antiAlias,
                    padding: EdgeInsets.all(2),
                    decoration: BoxDecoration(
                      gradient: AppColor.primaryGradient,
                      shape: BoxShape.circle,
                    ),
                    child: Container(
                      height: 120,
                      width: 120,
                      clipBehavior: Clip.antiAlias,
                      decoration: BoxDecoration(
                        color: AppColor.black,
                        shape: BoxShape.circle,
                      ),
                      child: PreviewProfileImageWidget(
                        image: image,
                        isBanned: isMediaBanned,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
