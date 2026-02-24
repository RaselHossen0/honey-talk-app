import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';
import 'package:tingle/common/widget/loading_widget.dart';
import 'package:tingle/utils/color.dart';
import 'package:tingle/utils/utils.dart';

class CommonShare {
  static Future onShare({String? id, String? title, String? filePath}) async {
    try {
      Get.dialog(const LoadingWidget(color: AppColor.primary), barrierDismissible: false); // Start Loading...
      await Share.share(title ?? " ");
      Get.back(); // Stop Loading...
      Utils.showLog("Share Method Called Success...");
    } catch (e) {
      Get.back(); // Stop Loading...
      Utils.showLog("Share Method Called Failed => $e");
    }
  }
}
