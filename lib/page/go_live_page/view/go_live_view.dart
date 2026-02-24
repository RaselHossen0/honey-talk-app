import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tingle/page/go_live_page/controller/go_live_controller.dart';
import 'package:tingle/page/go_live_page/widget/camera_widget.dart';
import 'package:tingle/page/preview_created_reels_page/widget/preview_created_reels_widget.dart';
import 'package:tingle/utils/color.dart';
import 'package:tingle/utils/enums.dart';
import 'package:tingle/utils/utils.dart';

class GoLiveView extends StatelessWidget {
  const GoLiveView({super.key});

  @override
  Widget build(BuildContext context) {
    Utils.onChangeStatusBar(brightness: Brightness.light);
    return Scaffold(
      body: Container(
        height: Get.height,
        width: Get.width,
        color: AppColor.black,
        child: SizedBox(
          height: Get.height,
          width: Get.width,
          child: Stack(
            children: [
              CameraWidget(),
              Positioned(
                bottom: 50,
                child: SizedBox(
                  width: Get.width,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: Get.width / 5),
                    child: GetBuilder<GoLiveController>(
                      builder: (controller) => AppButtonUi(
                        fontSize: 18,
                        gradient: AppColor.primaryGradient,
                        title: EnumLocal.txtGoLive.name.tr,
                        callback: controller.onClickGoLive,
                      ),
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
