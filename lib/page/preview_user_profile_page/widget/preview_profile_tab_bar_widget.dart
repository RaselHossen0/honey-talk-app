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
        height: 44,
        width: Get.width,
        color: AppColor.white,
        child: Row(
          children: [
            _TabItemWidget(
              title: EnumLocal.txtInformation.name.tr,
              isSelected: controller.selectedTabIndex == 0,
              callback: () => controller.onChangeTab(0),
            ),
            _TabItemWidget(
              title: "${EnumLocal.txtVideo.name.tr}(${controller.userVideos.length})",
              isSelected: controller.selectedTabIndex == 1,
              callback: () => controller.onChangeTab(1),
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
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: isSelected ? AppColor.pink : AppColor.transparent,
              width: 3,
            ),
          ),
        ),
        child: Text(
          title,
          style: isSelected
              ? AppFontStyle.styleW600(AppColor.pink, 14)
              : AppFontStyle.styleW500(AppColor.grayText, 14),
        ),
      ),
    );
  }
}
