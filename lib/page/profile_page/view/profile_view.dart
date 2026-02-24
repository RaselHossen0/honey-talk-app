import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tingle/custom/widget/custom_light_background_widget.dart';
import 'package:tingle/page/profile_page/controller/profile_controller.dart';
import 'package:tingle/page/profile_page/shimmer/profile_shimmer_widget.dart';
import 'package:tingle/page/profile_page/widget/benefit_box_widget.dart';
import 'package:tingle/page/profile_page/widget/coin_and_point_details_widget.dart';
import 'package:tingle/page/profile_page/widget/connection_details_widget.dart';
import 'package:tingle/page/profile_page/widget/general_setting_widget.dart';
import 'package:tingle/page/profile_page/widget/profile_app_bar_widget.dart';
import 'package:tingle/page/profile_page/widget/profile_details_widget.dart';
import 'package:tingle/utils/constant.dart';
import 'package:tingle/utils/utils.dart';

class ProfileView extends GetView<ProfileController> {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    Utils.onChangeStatusBar(brightness: Brightness.dark);
    Utils.onChangeExtendBody(false);
    controller.init();
    return Scaffold(
      body: Stack(
        children: [
          const CustomLightBackgroundWidget(),
          SizedBox(
            height: Get.height,
            width: Get.width,
            child: Column(
              children: [
                const ProfileAppBarWidget(),
                GetBuilder<ProfileController>(
                  id: AppConstant.onGetProfile,
                  builder: (controller) => controller.isLoading
                      ? ProfileShimmerWidget()
                      : Expanded(
                          child: RefreshIndicator(
                            onRefresh: () async => await controller.init(),
                            child: SingleChildScrollView(
                              controller: controller.scrollController,
                              child: Column(
                                children: [
                                  12.height,
                                  const ProfileDetailsWidget(),
                                  15.height,
                                  const ConnectionDetailsWidget(),
                                  15.height,
                                  const CoinAndPointDetailsWidget(),
                                  15.height,
                                  const BenefitBoxWidget(),
                                  15.height,
                                  const GeneralSettingWidget(),
                                  15.height,
                                ],
                              ),
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
