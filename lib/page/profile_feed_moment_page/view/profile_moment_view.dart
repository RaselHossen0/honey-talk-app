import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tingle/common/widget/no_data_found_widget.dart';
import 'package:tingle/custom/widget/custom_dark_background_widget.dart';
import 'package:tingle/page/profile_feed_moment_page/controller/profile_moment_controller.dart';
import 'package:tingle/page/profile_feed_moment_page/shimmer/profile_moment_shimmer_widget.dart';
import 'package:tingle/page/profile_feed_moment_page/wigdet/profile_moment_item_widget.dart';
import 'package:tingle/utils/color.dart';
import 'package:tingle/utils/constant.dart';
import 'package:tingle/utils/enums.dart';
import 'package:tingle/utils/font_style.dart';
import 'package:tingle/utils/utils.dart';

class ProfileMomentView extends GetView<ProfileMomentController> {
  const ProfileMomentView({super.key});

  @override
  Widget build(BuildContext context) {
    Utils.onChangeStatusBar(brightness: Brightness.light);
    return Scaffold(
      backgroundColor: AppColor.white,
      body: Stack(
        children: [
          const CustomDarkBackgroundWidget(),
          SafeArea(
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  child: Row(
                    children: [
                      IconButton(
                        onPressed: () => Get.back(),
                        icon: const Icon(Icons.arrow_back_ios_new_rounded, color: AppColor.white),
                      ),
                      const Spacer(),
                      Text(
                        EnumLocal.txtMoments.name.tr,
                        style: AppFontStyle.styleW600(AppColor.white, 18),
                      ),
                      const Spacer(),
                      const SizedBox(width: 48), // balance back button
                    ],
                  ),
                ),

                /// 🔥 Use Expanded to fix layout issue
                Expanded(
                  child: GetBuilder<ProfileMomentController>(
                    id: AppConstant.onGetMoment,
                    builder: (controller) => RefreshIndicator(
                      color: AppColor.primary,
                      onRefresh: () async => controller.onRefreshMoment(),
                      child: controller.isLoadingMoment
                          ? const ProfileMomentShimmerWidget()
                          : controller.moments.isEmpty
                              ? ListView(
                                  physics: const AlwaysScrollableScrollPhysics(),
                                  children: const [NoDataFoundWidget()],
                                )
                              : ListView.builder(
                                  controller: controller.momentScrollController,
                                  itemCount: controller.moments.length,
                                  padding: const EdgeInsets.symmetric(horizontal: 15),
                                  itemBuilder: (context, index) {
                                    final moment = controller.moments[index];
                                    return ProfileMomentItemWidget(post: moment);
                                  },
                                ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
