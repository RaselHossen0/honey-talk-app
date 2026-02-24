import 'dart:developer';
import 'package:get/get.dart';
import 'package:tingle/utils/api_params.dart';

class PreviewThemeController extends GetxController {
  bool isLoading = false;
  String itemType = "";
  String imagePath = "";
  String framePath = "";
  int type = 0;
  @override
  void onInit() async {
    isLoading = true;
    var data = await Get.arguments;
    if (data != null) {
      type = Get.arguments[ApiParams.previewThemeType] ?? 0;
      itemType = Get.arguments[ApiParams.previewThemeItemType] ?? "";
      imagePath = Get.arguments[ApiParams.previewThemeImagePath] ?? "";
      framePath = Get.arguments[ApiParams.previewThemeFramePath] ?? "";
    }

    update([ApiParams.previewUpdate]);

    Future.delayed(
      Duration(seconds: 1),
      () {
        isLoading = false;
        update([ApiParams.previewUpdate]);
      },
    );
    log("Preview  COME ");

    super.onInit();
  }
}
