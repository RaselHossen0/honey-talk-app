import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tingle/page/preview_user_profile_page/controller/preview_user_profile_controller.dart';
import 'package:tingle/page/preview_user_profile_page/shimmer/preview_user_profile_shimmer_widget.dart';
import 'package:tingle/page/preview_user_profile_page/widget/preview_profile_app_bar_widget.dart';
import 'package:tingle/page/preview_user_profile_page/widget/preview_profile_data_tab_widget.dart';
import 'package:tingle/page/preview_user_profile_page/widget/preview_profile_details_widget.dart';
import 'package:tingle/page/preview_user_profile_page/widget/preview_profile_moments_tab_widget.dart';
import 'package:tingle/page/preview_user_profile_page/widget/preview_profile_tab_bar_widget.dart';
import 'package:tingle/page/preview_user_profile_page/widget/preview_profile_won_mom_tab_widget.dart';
import 'package:tingle/utils/color.dart';
import 'package:tingle/utils/constant.dart';
import 'package:tingle/utils/utils.dart';

class PreviewUserProfileView extends GetView<PreviewUserProfileController> {
  const PreviewUserProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    Utils.onChangeStatusBar(brightness: Brightness.light);
    return Scaffold(
      body: GetBuilder<PreviewUserProfileController>(
        id: AppConstant.onGetProfile,
        builder: (controller) => controller.isLoading
            ? PreviewUserProfileShimmerWidget()
            : Stack(
                children: [
                  RefreshIndicator(
                    onRefresh: () async => controller.init(),
                    color: AppColor.primary,
                    backgroundColor: AppColor.white,
                    child: SingleChildScrollView(
                      child: SizedBox(
                        height: Get.height + 1,
                        width: Get.width,
                        child: RefreshIndicator(
                          onRefresh: () async => controller.init(),
                          color: AppColor.primary,
                          backgroundColor: AppColor.white,
                          child: SingleChildScrollView(
                            controller: controller.scrollController,
                            child: Column(
                              children: [
                                PreviewProfileDetailsWidget(),
                                15.height,
                                PreviewProfileTabBarWidget(),
                                15.height,
                                GetBuilder<PreviewUserProfileController>(
                                  id: AppConstant.onChangeTab,
                                  builder: (controller) => controller.selectedTabIndex == 0
                                      ? PreviewProfileDataTabWidget()
                                      : controller.selectedTabIndex == 1
                                          ? PreviewProfileMomentsTabWidget()
                                          : PreviewProfileWonMomTabWidget(),
                                ),
                                15.height,
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 0,
                    child: Container(
                      height: 200,
                      width: Get.width,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            AppColor.black.withValues(alpha: 0.7),
                            AppColor.transparent,
                          ],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        ),
                      ),
                    ),
                  ),
                  PreviewProfileAppBarWidget(),
                ],
              ),
      ),
    );
  }
}
