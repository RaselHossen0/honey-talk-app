import 'dart:developer';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:tingle/firebase/authentication/firebase_access_token.dart';
import 'package:tingle/firebase/authentication/firebase_uid.dart';
import 'package:tingle/page/backpack_page/api/fetch_purchased_frame_api.dart';
import 'package:tingle/page/backpack_page/model/fetch_purchased_model.dart';
import 'package:tingle/utils/api_params.dart';

class BackpackController extends GetxController {
  bool isLoading = false;
  String token = "";
  String uid = "";
  FetchPurchasedFrameModel? fetchPurchasedFrameModel;
  String formatDateTime(DateTime dateTime, {String format = 'dd-MM-yyyy HH:mm:ss'}) {
    return DateFormat(format).format(dateTime);
  }

  int isActiveFrame = -1;
  int isActiveRide = -1;
  int isActiveTheme = -1;
  int isExpiredFrame = -1;
  int isExpiredRide = -1;
  int isExpiredTheme = -1;
  int isSelectedFrame = -1;
  int isSelectedRide = -1;
  int isSelectedTheme = -1;
  @override
  void onInit() {
    isLoading = true;

    init();
    // TODO: implement onInit
    super.onInit();
  }

  Future<void> init() async {
    token = await FirebaseAccessToken.onGet() ?? "";
    uid = FirebaseUid.onGet() ?? "";
    fetchPurchasedFrameModel = await FetchPurchasedFrameApi.callApi(token: token, uid: uid);
    if (fetchPurchasedFrameModel != null) {
      fetchPurchasedFrameModel?.data?.avatarFrames?.active?.asMap().forEach(
        (index, element) {
          if (element.isSelected == true) {
            log("Selected Frame ${element.toJson()}");
            isActiveFrame = index;
            isSelectedFrame = index;
          }
        },
      );
      fetchPurchasedFrameModel?.data?.rides?.active?.asMap().forEach(
        (index, element) {
          if (element.isSelected == true) {
            log("Selected rides ${element.toJson()}");
            isActiveRide = index;
            isSelectedRide = index;
          }
        },
      );
      fetchPurchasedFrameModel?.data?.themes?.active?.asMap().forEach(
        (index, element) {
          if (element.isSelected == true) {
            log("Selected theme ${element.toJson()}");
            isActiveTheme = index;
            isSelectedTheme = index;
          }
        },
      );
    }

    isLoading = false;
    update([ApiParams.backpack]);
  }
}
