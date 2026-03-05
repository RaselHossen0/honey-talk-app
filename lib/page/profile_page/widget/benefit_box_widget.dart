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
      margin: const EdgeInsets.symmetric(horizontal: 15),
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
        final items = [
          _BenefitItem(EnumLocal.txtReward.name.tr, AppAssets.icRewardIcon, AppColor.rewardGradient, () {}),
          _BenefitItem(EnumLocal.txtRanking.name.tr, AppAssets.icRankingIcon, AppColor.rankingGradient, () => Get.toNamed(AppRoutes.rankingPage)?.then((value) {
            Utils.onChangeStatusBar(brightness: Brightness.dark);
            logic.scrollController.jumpTo(0.0);
          })),
          _BenefitItem(EnumLocal.txtMyStore.name.tr, AppAssets.icMyStoreIcon, AppColor.storeGradient, () => Get.toNamed(AppRoutes.storePage)?.then((value) {
            logic.scrollController.jumpTo(0.0);
            Utils.onChangeStatusBar(brightness: Brightness.dark);
          })),
          _BenefitItem(EnumLocal.txtInvite.name.tr, AppAssets.icInviteIcon, AppColor.inviteGradient, () {}),
        ];
        return ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          padding: const EdgeInsets.symmetric(vertical: 8),
          itemCount: items.length,
          separatorBuilder: (_, __) => Divider(height: 1, color: AppColor.secondary.withValues(alpha: 0.08)),
          itemBuilder: (context, index) {
            final item = items[index];
            return _BenefitListTile(
              title: item.title,
              image: item.image,
              gradient: item.gradient,
              callback: item.callback,
            );
          },
        );
      }),
    );
  }
}

class _BenefitItem {
  final String title;
  final String image;
  final Gradient gradient;
  final Callback callback;
  _BenefitItem(this.title, this.image, this.gradient, this.callback);
}

class _BenefitListTile extends StatelessWidget {
  const _BenefitListTile({
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
    return ListTile(
      onTap: callback,
      contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 4),
      leading: Container(
        height: 44,
        width: 44,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          gradient: gradient,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(width: 1, color: AppColor.white),
          boxShadow: [
            BoxShadow(
              color: AppColor.secondary.withValues(alpha: 0.05),
              spreadRadius: 1,
              blurRadius: 2,
            ),
          ],
        ),
        child: Image.asset(image, width: 22),
      ),
      title: Text(
        title,
        style: AppFontStyle.styleW600(AppColor.lightGreyPurple, 14),
      ),
      trailing: Icon(Icons.chevron_right, color: AppColor.secondary.withValues(alpha: 0.5), size: 24),
    );
  }
}
