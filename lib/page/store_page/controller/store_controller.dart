import 'dart:developer';
import 'package:get/get.dart';
import 'package:tingle/firebase/authentication/firebase_access_token.dart';
import 'package:tingle/firebase/authentication/firebase_uid.dart';
import 'package:tingle/page/store_page/api/all_frame_api.dart';
import 'package:tingle/page/store_page/api/top_frame_api.dart';
import 'package:tingle/page/store_page/model/all_store_item_model.dart';
import 'package:tingle/page/store_page/model/top_frame_model.dart';
import 'package:tingle/utils/api_params.dart';

class StoreController extends GetxController {
  TopFramesModel? topFramesModel;
  AllStoreItemModel? allStoreItemModel;
  bool isLoading = false;
  String token = "";
  String uid = "";
  Recommended? recommended;
  @override
  void onInit() {
    log("STORE COME ");
    init();
    super.onInit();
  }

  void init() async {
    isLoading = true;

    log("STORE COME ");
    token = await FirebaseAccessToken.onGet() ?? "";
    uid = FirebaseUid.onGet() ?? "";
    topFramesModel = await FetchTopFramesApi.callApi();

    allStoreItemModel = await FetchAllFramesApi.callApi();
    isLoading = false;
    update([ApiParams.themeStore]);
  }
}
