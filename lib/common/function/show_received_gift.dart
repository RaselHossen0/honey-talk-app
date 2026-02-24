import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tingle/common/widget/preview_network_image_widget.dart';
import 'package:tingle/utils/color.dart';
import 'package:tingle/utils/constant.dart';
import 'package:tingle/utils/font_style.dart';
import 'package:tingle/utils/utils.dart';

class ShowReceivedGift {
  static RxBool isShow = false.obs;
  static RxList<GiftModel> giftList = <GiftModel>[].obs;
  static RxDouble senderDetailsPosition = (-500.0).obs;

  static void onGetNewGift(GiftModel gift) {
    Utils.showLog("GET NEW GIFT TO AUDIO ROOM");
    giftList.add(gift);
    if (giftList.length == 1) _onShowGiftTime();
  }

  static void _onShowGiftTime() async {
    Utils.showLog("SHOW NEW GIFT TO AUDIO ROOM");

    if (giftList.isNotEmpty) {
      isShow.value = true;

      senderDetailsPosition.value = 0;

      (giftList[0].giftType == 3) ? await 8000.milliseconds.delay() : await 1500.milliseconds.delay();

      senderDetailsPosition.value = -500;

      await Future.delayed(Duration(seconds: 1));

      isShow.value = false;

      if (giftList.isNotEmpty) giftList.removeAt(0);

      await 500.seconds.delay();

      if (giftList.isNotEmpty) _onShowGiftTime();
    }
  }

  static Widget onShowGift() {
    return Obx(
      () => isShow.value
          ? AnimatedOpacity(
              opacity: 0.99,
              curve: Curves.easeInToLinear,
              duration: Duration(milliseconds: 500),
              child: Container(
                height: giftList[0].giftType == 3 ? Get.height : 250,
                width: giftList[0].giftType == 3 ? Get.width : 250,
                color: AppColor.transparent,
                child: PreviewGiftWidget(url: giftList[0].giftUrl, type: giftList[0].giftType),
              ),
            )
          : Offstage(),
    );
  }

  static Widget onShowSenderDetails() {
    return Obx(
      () => isShow.value
          ? AnimatedPositioned(
              duration: Duration(milliseconds: 1000),
              right: senderDetailsPosition.value,
              curve: Curves.easeInOut,
              child: Container(
                height: 55,
                margin: EdgeInsets.only(top: Get.height / 3),
                padding: EdgeInsets.all(3),
                width: Get.width / 2,
                decoration: BoxDecoration(
                  color: AppColor.lighterYellow,
                  boxShadow: [
                    BoxShadow(
                      color: AppColor.lightYellow.withValues(alpha: 0.3),
                      blurRadius: 10,
                      spreadRadius: 10,
                    ),
                  ],
                  border: Border(
                    top: BorderSide(color: AppColor.orange.withValues(alpha: 0.5), width: 3),
                    left: BorderSide(color: AppColor.orange.withValues(alpha: 0.5), width: 3),
                    bottom: BorderSide(color: AppColor.orange.withValues(alpha: 0.5), width: 3),
                  ),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(100),
                    bottomLeft: Radius.circular(100),
                  ),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      height: 45,
                      width: 45,
                      padding: EdgeInsets.all(1),
                      decoration: BoxDecoration(
                        border: Border.all(color: AppColor.white),
                        shape: BoxShape.circle,
                      ),
                      child: Container(
                        height: 45,
                        width: 45,
                        clipBehavior: Clip.antiAlias,
                        decoration: BoxDecoration(
                          gradient: AppColor.lightYellowOrangeGradient,
                          shape: BoxShape.circle,
                        ),
                        child: PreviewProfileImageWidget(
                          image: giftList[0].senderImage,
                          isBanned: giftList[0].senderProfilePicBanned,
                        ),
                      ),
                    ),
                    5.width,
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            giftList[0].senderName,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: AppFontStyle.styleW700(AppColor.orange, 14),
                          ),
                          Flexible(
                            fit: FlexFit.loose,
                            child: Text(
                              "ID: ${giftList[0].senderUniqueId}",
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: AppFontStyle.styleW600(AppColor.brown, 11),
                            ),
                          ),
                        ],
                      ),
                    ),
                    5.width,
                    Text(
                      "X${giftList[0].giftCount}",
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        fontFamily: AppConstant.appFontExtraBold,
                        fontStyle: FontStyle.italic,
                        foreground: Paint()
                          ..shader = LinearGradient(
                            colors: [AppColor.orange, AppColor.orange],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ).createShader(const Rect.fromLTWH(10, 0, 0, 10)),
                        shadows: [
                          const Shadow(
                            offset: Offset(3, 3),
                            blurRadius: 3,
                            color: Colors.black,
                          ),
                          const Shadow(
                            offset: Offset(1, 1),
                            blurRadius: 0,
                            color: Colors.white,
                          ),
                        ],
                      ),
                    ),
                    10.width,
                  ],
                ),
              ),
            )
          : Offstage(),
    );
  }
}

class GiftModel {
  int giftType;
  String giftUrl;
  int giftCount;
  String senderName;
  String senderImage;
  bool senderProfilePicBanned;
  String senderUniqueId;
  GiftModel({
    required this.giftType,
    required this.giftUrl,
    required this.giftCount,
    required this.senderName,
    required this.senderImage,
    required this.senderProfilePicBanned,
    required this.senderUniqueId,
  });
}
