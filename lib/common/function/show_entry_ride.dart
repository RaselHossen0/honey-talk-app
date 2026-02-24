import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tingle/common/widget/preview_network_image_widget.dart';
import 'package:tingle/utils/color.dart';
import 'package:tingle/utils/utils.dart';

class ShowEntryRide {
  static RxBool isShow = false.obs;
  static RxList<EntryRideModel> rideList = <EntryRideModel>[].obs;

  static void onGetNewRide(EntryRideModel ride) {
    Utils.showLog("GET NEW RIDE USER TO AUDIO ROOM");

    if (ride.entryRide.trim().isNotEmpty) {
      rideList.add(ride);
      if (rideList.length == 1) _onShowGiftTime();
    }
  }

  static void _onShowGiftTime() async {
    Utils.showLog("SHOW NEW GIFT TO AUDIO ROOM");

    if (rideList.isNotEmpty) {
      isShow.value = true;

      (rideList[0].entryRideType == 3) ? await 8000.milliseconds.delay() : await 1500.milliseconds.delay();

      await Future.delayed(Duration(seconds: 1));

      isShow.value = false;

      if (rideList.isNotEmpty) rideList.removeAt(0);

      await 500.seconds.delay();

      if (rideList.isNotEmpty) _onShowGiftTime();
    }
  }

  static Widget onShowRide() {
    return Obx(
      () => isShow.value
          ? AnimatedOpacity(
              opacity: 0.99,
              curve: Curves.easeInToLinear,
              duration: Duration(milliseconds: 500),
              child: Container(
                height: Get.height,
                width: Get.height,
                color: AppColor.transparent,
                child: PreviewGiftWidget(url: rideList[0].entryRide, type: rideList[0].entryRideType),
              ),
            )
          : Offstage(),
    );
  }
}

class EntryRideModel {
  int entryRideType;
  String entryRide;
  EntryRideModel({required this.entryRideType, required this.entryRide});
}
