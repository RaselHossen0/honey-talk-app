import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';
import 'package:tingle/page/profile_page/controller/profile_controller.dart';
import 'package:tingle/routes/app_routes.dart';
import 'package:tingle/utils/assets.dart';
import 'package:tingle/utils/color.dart';
import 'package:tingle/utils/enums.dart';
import 'package:tingle/utils/font_style.dart';
import 'package:tingle/utils/utils.dart';

class BenefitBoxWidget extends StatelessWidget {
  const BenefitBoxWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width,
      margin: EdgeInsets.symmetric(horizontal: 15),
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: AppColor.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: AppColor.secondary.withValues(alpha: 0.08),
            blurRadius: 2,
            spreadRadius: 3,
          ),
        ],
      ),
      child: GetBuilder<ProfileController>(builder: (logic) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ItemWidget(
                  title: EnumLocal.txtReward.name.tr,
                  gradient: AppColor.rewardGradient,
                  image: AppAssets.icRewardIcon,
                  callback: () {},
                ),
                ItemWidget(
                  title: EnumLocal.txtRanking.name.tr,
                  gradient: AppColor.rankingGradient,
                  image: AppAssets.icRankingIcon,
                  callback: () => Get.toNamed(AppRoutes.rankingPage)?.then((value) {
                    Utils.onChangeStatusBar(brightness: Brightness.dark);
                    logic.scrollController.jumpTo(0.0);
                  }),
                ),
                ItemWidget(
                  title: EnumLocal.txtMyStore.name.tr,
                  gradient: AppColor.storeGradient,
                  image: AppAssets.icMyStoreIcon,
                  callback: () => Get.toNamed(AppRoutes.storePage)?.then((value) {
                    logic.scrollController.jumpTo(0.0);
                    Utils.onChangeStatusBar(brightness: Brightness.dark);
                  }),
                ),
                ItemWidget(
                  title: EnumLocal.txtInvite.name.tr,
                  gradient: AppColor.inviteGradient,
                  image: AppAssets.icInviteIcon,
                  callback: () {},
                ),
              ],
            ),
          ],
        );
      }),
    );
  }
}

class ItemWidget extends StatelessWidget {
  const ItemWidget({
    super.key,
    required this.title,
    required this.image,
    required this.gradient,
    required this.callback,
  });

  final String title;

  final String image;
  final Gradient gradient;
  final Callback callback;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: callback,
      child: Column(
        children: [
          Container(
            height: 54,
            width: 54,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              gradient: gradient,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(width: 1, color: AppColor.white),
              boxShadow: [
                BoxShadow(
                  color: AppColor.secondary.withValues(alpha: 0.05),
                  spreadRadius: 2,
                  blurRadius: 2,
                ),
              ],
            ),
            child: Image.asset(
              image,
              width: 26,
            ),
          ),
          5.height,
          Text(
            title,
            style: AppFontStyle.styleW600(AppColor.lightGreyPurple, 11),
          )
        ],
      ),
    );
  }
}
