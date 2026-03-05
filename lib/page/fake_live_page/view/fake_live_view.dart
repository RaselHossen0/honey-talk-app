import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:tingle/common/function/show_received_gift.dart';
import 'package:tingle/page/fake_live_page/controller/fake_live_controller.dart';
import 'package:tingle/page/fake_live_page/widget/fake_button_widget.dart';
import 'package:tingle/page/fake_live_page/widget/fake_camera_widget.dart';

import 'package:tingle/page/fake_live_page/widget/fake_comment_text_field_widget.dart';
import 'package:tingle/page/fake_live_page/widget/fake_live_app_bar_widget.dart';
import 'package:tingle/page/fake_live_page/widget/fake_live_comment_widget.dart';
import 'package:tingle/page/fake_live_page/widget/shadow_widget.dart';
import 'package:tingle/page/fake_live_page/widget/show_live_gift.dart';
import 'package:tingle/utils/assets.dart';
import 'package:tingle/utils/color.dart';
import 'package:tingle/utils/constant.dart';

class FakeLiveView extends GetView<FakeLiveController> {
  const FakeLiveView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.black,
      body: Stack(
        alignment: Alignment.center,
        children: [
          FakeLiveCameraWidget(),
          ShadowWidget(),
          GetBuilder<FakeLiveController>(
            id: AppConstant.onEventHandler,
            builder: (c) => Visibility(
              visible: c.fakeLiveModel?.isChannelMediaRelay != true,
              child: Positioned(
                left: 0,
                bottom: 115,
                child: Container(
                  height: Get.height / 2.5,
                  width: Get.width / 1.8,
                  color: AppColor.transparent,
                  child: FakeLiveCommentWidget(),
                ),
              ),
            ),
          ),
          FakePkCameraWidget(),
          FakeButtonWidget(),
          GetBuilder<FakeLiveController>(
            id: AppConstant.onEventHandler,
            builder: (controller) => Positioned(
              bottom: 0,
              child: FakeCommentTextFieldWidget(
                ispklive: controller.fakeLiveModel?.isChannelMediaRelay == true,
              ),
            ),
          ),
          ShowLiveGift.onShow(),
          ShowReceivedGift.onShowGift(),
          ShowReceivedGift.onShowSenderDetails(),
          FakeLiveAppBarWidget(),
          Obx(
            () => Visibility(
              visible: controller.isShowPkAnimation.value,
              child: Lottie.asset(AppAssets.lottiePk, width: 200),
            ),
          ),
          Obx(
            () => AnimatedPositioned(
              duration: const Duration(seconds: 1, milliseconds: 500),
              right: controller.isShowPkAnimation.value ? 300 : -50,
              child: Padding(
                padding: EdgeInsets.only(bottom: 50),
                child: controller.isShowPkAnimation.value ? Image.asset(AppAssets.imgPkSideBlue, width: 200, fit: BoxFit.cover, height: 45) : Offstage(),
              ),
            ),
          ),
          Obx(
            () => AnimatedPositioned(
              duration: const Duration(seconds: 1, milliseconds: 500),
              left: controller.isShowPkAnimation.value ? 300 : -50,
              child: Padding(
                padding: EdgeInsets.only(top: 50),
                child: controller.isShowPkAnimation.value ? Image.asset(AppAssets.imgPkSidePink, width: 200, fit: BoxFit.cover, height: 45) : Offstage(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
