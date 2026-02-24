import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tingle/utils/color.dart';
import 'package:tingle/utils/utils.dart';
import 'package:tingle/utils/enums.dart';
import 'package:tingle/utils/font_style.dart';

/// Shows the notification permission pop-up when user taps "Turn on" on the banner.
class NotificationPopupWidget {
  static void show() {
    Get.dialog(
      barrierDismissible: false,
      Dialog(
        backgroundColor: AppColor.transparent,
        insetPadding: const EdgeInsets.symmetric(horizontal: 24),
        child: Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: AppColor.white,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GestureDetector(
                    onTap: Get.back,
                    child: Icon(Icons.close, size: 22, color: AppColor.darkGrey),
                  ),
                ],
              ),
              Icon(Icons.notifications_active, size: 56, color: AppColor.pink),
              16.height,
              Text(
                '${EnumLocal.txtDontMissExcitement.name.tr.split('!').first}!',
                style: AppFontStyle.styleW600(AppColor.darkGrey, 16),
                textAlign: TextAlign.center,
              ),
              8.height,
              Text(
                EnumLocal.txtRealtimeMessagesReminder.name.tr,
                style: AppFontStyle.styleW500(AppColor.grayText, 13),
                textAlign: TextAlign.center,
                maxLines: 2,
              ),
              24.height,
              GestureDetector(
                onTap: () {
                  Get.back();
                  // TODO: Request notification permission
                },
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  decoration: BoxDecoration(
                    color: AppColor.pink,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Center(
                    child: Text(
                      EnumLocal.txtTurnOnNow.name.tr,
                      style: AppFontStyle.styleW600(AppColor.white, 14),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
