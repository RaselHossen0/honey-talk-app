import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:tingle/common/function/show_entry_ride.dart';
import 'package:tingle/common/function/show_received_gift.dart';
import 'package:tingle/page/live_page/controller/live_controller.dart';
import 'package:tingle/page/live_page/widget/button_widget.dart';
import 'package:tingle/page/live_page/widget/camera_widget.dart';
import 'package:tingle/page/live_page/widget/comment_text_field_widget.dart';
import 'package:tingle/page/live_page/widget/live_app_bar_widget.dart';
import 'package:tingle/page/live_page/widget/live_comment_widget.dart';
import 'package:tingle/page/live_page/widget/live_viewer_drawer_widget.dart';
import 'package:tingle/page/live_page/widget/shadow_widget.dart';
import 'package:tingle/page/live_page/widget/show_live_gift.dart';
import 'package:tingle/utils/assets.dart';
import 'package:tingle/utils/color.dart';
import 'package:tingle/utils/constant.dart';
import 'package:tingle/utils/database.dart';
import 'package:tingle/utils/utils.dart';

class LiveView extends GetView<LiveController> {
  const LiveView({super.key});

  @override
  Widget build(BuildContext context) {
    Utils.onChangeStatusBar(brightness: Brightness.light);
    return Scaffold(
      key: controller.scaffoldKey,
      backgroundColor: AppColor.black,
      endDrawer: controller.liveModel?.host1UserId == Database.loginUserId ? LiveViewerDrawerWidget() : null,
      body: Stack(
        alignment: Alignment.center,
        children: [
          LiveCameraWidget(),
          ShadowWidget(),
          PkCameraWidget(),
          Positioned(
            left: 0,
            bottom: 80,
            child: Container(
              height: Get.height / 3.5,
              width: Get.width / 1.8,
              color: AppColor.transparent,
              child: LiveCommentWidget(),
            ),
          ),
          GetBuilder<LiveController>(
            id: AppConstant.onEventHandler,
            builder: (controller) => Visibility(
              visible: controller.liveModel?.isChannelMediaRelay == false,
              child: Positioned(
                bottom: 0,
                child: CommentTextFieldWidget(),
              ),
            ),
          ),
          ShowLiveGift.onShow(),
          ShowReceivedGift.onShowGift(),
          ShowReceivedGift.onShowSenderDetails(),
          ShowEntryRide.onShowRide(),
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
          ButtonWidget(),
          LiveAppBarWidget(),
        ],
      ),
    );
  }
}
