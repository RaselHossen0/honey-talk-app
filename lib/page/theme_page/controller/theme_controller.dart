import 'dart:developer';
import 'package:get/get.dart';
import 'package:tingle/page/store_page/api/top_frame_api.dart';
import 'package:tingle/page/store_page/model/top_frame_model.dart';
import 'package:tingle/utils/api_params.dart';

class ThemeController extends GetxController {
  TopFramesModel? topFramesModel;

  bool isLoading = false;
  @override
  void onInit() {
    log("STORE COME ");
    init();
    super.onInit();
  }

  init() async {
    isLoading = true;

    log("STORE COME ");

    topFramesModel = await FetchTopFramesApi.callApi();
    isLoading = false;
    update([ApiParams.themeStore]);
  }
}
