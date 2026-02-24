import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:tingle/common/function/show_received_gift.dart';
import 'package:tingle/common/widget/scroll_fade_effect_widget.dart';
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
import 'package:tingle/utils/utils.dart';

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
          controller.fakeLiveModel?.isChannelMediaRelay == false
              ? ScrollFadeEffectWidget(
                  axis: Axis.vertical,
                  child: SingleChildScrollView(
                    // physics: const NeverScrollableScrollPhysics(),
                    child: Container(
                      color: AppColor.transparent,
                      height: Get.height,
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              GetBuilder<FakeLiveController>(
                                id: AppConstant.onToggleComment,
                                builder: (controller) => GestureDetector(
                                  behavior: HitTestBehavior.translucent, // Important!
                                  // Make sure this is active
                                  child: Container(
                                    color: Colors.transparent, // Use Flutter's built-in transparent
                                    height: Get.height / 3.3,
                                    width: Get.width,
                                    alignment: AlignmentDirectional.topStart,
                                    child: Visibility(
                                      visible: true,
                                      child: Container(
                                        height: Get.height / 3.3,
                                        width: Get.width / 1.8,
                                        color: Colors.transparent, // Also updated
                                        child: FakeLiveCommentWidget(),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              70.height,
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                )
              : SizedBox(),
          FakePkCameraWidget(),
          FakeButtonWidget(),
          GetBuilder<FakeLiveController>(
            id: AppConstant.onEventHandler,
            builder: (controller) => Visibility(
              visible: controller.fakeLiveModel?.isChannelMediaRelay == false,
              child: Positioned(
                bottom: 0,
                child: FakeCommentTextFieldWidget(
                  ispklive: false,
                ),
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
