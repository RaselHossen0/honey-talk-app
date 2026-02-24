import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';
import 'package:tingle/page/preview_user_profile_page/controller/preview_user_profile_controller.dart';
import 'package:tingle/utils/color.dart';
import 'package:tingle/utils/constant.dart';
import 'package:tingle/utils/enums.dart';
import 'package:tingle/utils/font_style.dart';

class PreviewProfileTabBarWidget extends StatelessWidget {
  const PreviewProfileTabBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PreviewUserProfileController>(
      id: AppConstant.onChangeTab,
      builder: (controller) => Container(
        height: 50,
        width: Get.width,
        // padding: EdgeInsets.symmetric(horizontal: 15),
        color: AppColor.colorBorder.withValues(alpha: 0.5),
        child: Row(
          children: [
            _TabItemWidget(
              title: EnumLocal.txtData.name.tr,
              isSelected: controller.selectedTabIndex == 0,
              callback: () => controller.onChangeTab(0),
            ),
            _TabItemWidget(
              title: EnumLocal.txtMoments.name.tr,
              isSelected: controller.selectedTabIndex == 1,
              callback: () => controller.onChangeTab(1),
            ),
            _TabItemWidget(
              title: EnumLocal.txtWonderfulMoments.name.tr,
              isSelected: controller.selectedTabIndex == 2,
              callback: () => controller.onChangeTab(2),
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
        margin: const EdgeInsets.only(right: 10),
        padding: const EdgeInsets.only(left: 15, right: 15, top: 8, bottom: 8),
        decoration: BoxDecoration(
          color: isSelected ? AppColor.primary : AppColor.transparent,
          borderRadius: BorderRadius.circular(100),
        ),
        child: Text(
          title,
          style: isSelected ? AppFontStyle.styleW600(AppColor.white, 14) : AppFontStyle.styleW500(AppColor.secondary, 14),
        ),
      ),
    );
  }
}
