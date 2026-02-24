import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';
import 'package:tingle/page/ranking_page/controller/ranking_controller.dart';
import 'package:tingle/utils/color.dart';
import 'package:tingle/utils/constant.dart';
import 'package:tingle/utils/enums.dart';
import 'package:tingle/utils/font_style.dart';
import 'package:tingle/utils/utils.dart';

class RichTabBarWidget extends StatelessWidget {
  const RichTabBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<RankingController>(
      id: AppConstant.onChangeRichTabBar,
      builder: (controller) => Container(
        height: 40,
        width: Get.width,
        color: AppColor.transparent,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _TabItemWidget(
              title: EnumLocal.txtDaily.name.tr,
              isSelected: controller.selectedRichTabIndex == 0,
              callback: () => controller.onChangeRichTabBar(0),
            ),
            15.width,
            _TabItemWidget(
              title: EnumLocal.txtWeekly.name.tr,
              isSelected: controller.selectedRichTabIndex == 1,
              callback: () => controller.onChangeRichTabBar(1),
            ),
            15.width,
            _TabItemWidget(
              title: EnumLocal.txtMonthly.name.tr,
              isSelected: controller.selectedRichTabIndex == 2,
              callback: () => controller.onChangeRichTabBar(2),
            ),
          ],
        ),
      ),
    );
  }
}

class GiftTabBarWidget extends StatelessWidget {
  const GiftTabBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<RankingController>(
      id: AppConstant.onChangeGiftTabBar,
      builder: (controller) => Container(
        height: 40,
        width: Get.width,
        color: AppColor.transparent,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _TabItemWidget(
              title: EnumLocal.txtDaily.name.tr,
              isSelected: controller.selectedGiftTabIndex == 0,
              callback: () => controller.onChangeGiftTabBar(0),
            ),
            15.width,
            _TabItemWidget(
              title: EnumLocal.txtWeekly.name.tr,
              isSelected: controller.selectedGiftTabIndex == 1,
              callback: () => controller.onChangeGiftTabBar(1),
            ),
            15.width,
            _TabItemWidget(
              title: EnumLocal.txtMonthly.name.tr,
              isSelected: controller.selectedGiftTabIndex == 2,
              callback: () => controller.onChangeGiftTabBar(2),
            ),
          ],
        ),
      ),
    );
  }
}

class GiftSubTabBarWidget extends StatelessWidget {
  const GiftSubTabBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<RankingController>(
      id: AppConstant.onChangeGiftTabBar,
      builder: (controller) => Container(
        height: 40,
        width: Get.width,
        color: AppColor.transparent,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _SubTabItemWidget(
              title: EnumLocal.txtTopSender.name.tr,
              isSelected: controller.selectedGiftSubTabIndex == 0,
              callback: () => controller.onChangeGiftSubTabBar(0),
            ),
            15.width,
            _SubTabItemWidget(
              title: EnumLocal.txtTopReceiver.name.tr,
              isSelected: controller.selectedGiftSubTabIndex == 1,
              callback: () => controller.onChangeGiftSubTabBar(1),
            ),
          ],
        ),
      ),
    );
  }
}

class _TabItemWidget extends StatelessWidget {
  const _TabItemWidget({
    required this.title,
    required this.isSelected,
    required this.callback,
  });

  final String title;
  final bool isSelected;
  final Callback callback;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: callback,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 6),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          color: AppColor.white.withValues(alpha: 0.2),
          border: Border.all(color: isSelected ? AppColor.white : AppColor.transparent),
        ),
        child: Text(
          title,
          style: AppFontStyle.styleW500(AppColor.white, 13),
        ),
      ),
    );
  }
}

class _SubTabItemWidget extends StatelessWidget {
  const _SubTabItemWidget({
    required this.title,
    required this.isSelected,
    required this.callback,
  });

  final String title;
  final bool isSelected;
  final Callback callback;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: callback,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 6),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: isSelected ? AppColor.white : AppColor.transparent,
          border: Border.all(color: isSelected ? AppColor.transparent : AppColor.white),
        ),
        child: Text(
          title,
          style: AppFontStyle.styleW500(isSelected ? AppColor.primary : AppColor.white, 13),
        ),
      ),
    );
  }
}
