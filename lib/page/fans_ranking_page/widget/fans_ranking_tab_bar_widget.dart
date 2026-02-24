import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';
import 'package:tingle/page/fans_ranking_page/controller/fans_ranking_controller.dart';
import 'package:tingle/utils/color.dart';
import 'package:tingle/utils/constant.dart';
import 'package:tingle/utils/font_style.dart';
import 'package:tingle/utils/utils.dart';

class FansRankingTabBarWidget extends StatelessWidget {
  const FansRankingTabBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<FansRankingController>(
      id: AppConstant.onChangeTabBar,
      builder: (controller) => Container(
        width: Get.width,
        color: AppColor.transparent,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _TabItemWidget(
              title: "Daily",
              isSelected: controller.selectedTabIndex == 0,
              callback: () => controller.onChangeTabBar(0),
            ),
            15.width,
            _TabItemWidget(
              title: "Weekly",
              isSelected: controller.selectedTabIndex == 1,
              callback: () => controller.onChangeTabBar(1),
            ),
            15.width,
            _TabItemWidget(
              title: "Monthly",
              isSelected: controller.selectedTabIndex == 2,
              callback: () => controller.onChangeTabBar(2),
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
