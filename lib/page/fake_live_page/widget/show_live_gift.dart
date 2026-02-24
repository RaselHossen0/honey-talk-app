import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tingle/common/widget/preview_network_image_widget.dart';
import 'package:tingle/common/function/show_received_gift.dart';
import 'package:tingle/utils/color.dart';
import 'package:tingle/utils/utils.dart';

class ShowLiveGift {
  static RxBool isShow = false.obs;
  static RxList<GiftModel> giftList = <GiftModel>[].obs;

  static void onGetNewGift(GiftModel gift) {
    Utils.showLog("GET NEW GIFT TO LIVE");
    giftList.add(gift);
    if (giftList.length == 1) _onShowGift();
  }

  static void _onShowGift() async {
    Utils.showLog("SHOW NEW GIFT TO LIVE");
    if (giftList.isNotEmpty) {
      isShow.value = true;
      (giftList[0].giftType == 3) ? await 2000.milliseconds.delay() : await 1500.milliseconds.delay();
      isShow.value = false;

      giftList.removeAt(0);

      await 500.seconds.delay();

      if (giftList.isNotEmpty) _onShowGift();
    }
  }

  static Widget onShow() {
    return Obx(
      () => isShow.value
          ? Container(
              height: giftList[0].giftType == 3 ? Get.height : 250,
              width: giftList[0].giftType == 3 ? Get.width : 250,
              color: AppColor.transparent,
              child: PreviewGiftWidget(url: giftList[0].giftUrl, type: giftList[0].giftType),
            )
          : Offstage(),
    );
  }
}
