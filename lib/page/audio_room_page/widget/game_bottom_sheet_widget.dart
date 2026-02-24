import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';
import 'package:tingle/common/widget/loading_widget.dart';
import 'package:tingle/utils/assets.dart';
import 'package:tingle/utils/color.dart';
import 'package:tingle/utils/enums.dart';
import 'package:tingle/utils/font_style.dart';
import 'package:tingle/utils/utils.dart';
import 'package:webview_flutter/webview_flutter.dart';

class GameBottomSheetWidget {
  static RxBool isLoading = true.obs;

  static WebViewController? webViewController;

  static void onInitializeWebView({required String link}) async {
    isLoading.value = true;

    webViewController = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(AppColor.white)
      ..loadRequest(Uri.parse(link)).then(
        (value) => isLoading.value = false,
      );
  }

  static Future<void> onShow() async {
    await showModalBottomSheet(
      isScrollControlled: true,
      context: Get.context!,
      backgroundColor: AppColor.transparent,
      builder: (context) => Container(
        height: 180,
        width: Get.width,
        decoration: BoxDecoration(
          color: AppColor.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(40),
            topRight: Radius.circular(40),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              height: 55,
              color: AppColor.secondary.withValues(alpha: 0.08),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  50.width,
                  Expanded(
                    child: Center(
                      child: Text(
                        EnumLocal.txtGames.name.tr,
                        style: AppFontStyle.styleW700(AppColor.greyBlue, 18),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () => Get.back(),
                    child: Container(
                      height: 30,
                      width: 30,
                      margin: const EdgeInsets.only(right: 20),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColor.secondary.withValues(alpha: 0.6),
                      ),
                      child: Image.asset(width: 18, AppAssets.icClose, color: AppColor.white),
                    ),
                  ),
                ],
              ),
            ),
            20.height,
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  _GameItemWidget(
                    icon: AppAssets.icFerryGame,
                    name: "Casino",
                    callback: () => onShowWebView(
                      height: 580,
                      link: "https://roulettecasinogame.codderlab.com/?id=680b486a63652ed618fe0ff0",
                      name: "Casino",
                    ),
                  ),
                  _GameItemWidget(
                    icon: AppAssets.icCasinoGame,
                    name: "Ferry Wheel",
                    callback: () => onShowWebView(
                      height: 550,
                      link: "https://ferrywheelgame.codderlab.com/?id=680b486a63652ed618fe0ff0",
                      name: "Ferry Wheel",
                    ),
                  ),
                  _GameItemWidget(
                    icon: AppAssets.icPattiGame,
                    name: "Teen Patti",
                    callback: () => onShowWebView(
                      height: 370,
                      link: "https://teenpatti.codderlab.com/?id=680b486a63652ed618fe0ff0",
                      name: "Teen Patti",
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  static Future<void> onShowWebView({required String name, required double height, required String link}) async {
    Get.back();
    onInitializeWebView(link: link);
    await showModalBottomSheet(
      isScrollControlled: true,
      context: Get.context!,
      backgroundColor: AppColor.transparent,
      builder: (context) => Container(
        height: height,
        width: Get.width,
        decoration: BoxDecoration(
          color: AppColor.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(40),
            topRight: Radius.circular(40),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              height: 50,
              color: AppColor.secondary.withValues(alpha: 0.08),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  50.width,
                  Expanded(
                    child: Center(
                      child: Text(
                        name,
                        style: AppFontStyle.styleW700(AppColor.greyBlue, 17),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () => Get.back(),
                    child: Container(
                      height: 28,
                      width: 28,
                      margin: const EdgeInsets.only(right: 20),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColor.secondary.withValues(alpha: 0.6),
                      ),
                      child: Image.asset(width: 18, AppAssets.icClose, color: AppColor.white),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Obx(
                () => Stack(
                  fit: StackFit.expand,
                  children: [
                    LoadingWidget(),
                    isLoading.value == false && webViewController != null ? WebViewWidget(controller: webViewController!) : Offstage(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _GameItemWidget extends StatelessWidget {
  const _GameItemWidget({required this.icon, required this.name, required this.callback});

  final String icon;
  final String name;
  final Callback callback;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: callback,
        child: Container(
          color: AppColor.transparent,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                icon,
                width: 55,
              ),
              5.height,
              Text(
                name,
                style: AppFontStyle.styleW600(AppColor.black, 12),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
