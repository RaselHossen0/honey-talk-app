import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';
import 'package:tingle/utils/color.dart';
import 'package:tingle/utils/font_style.dart';

class FakeOtherUserProfileTabBarWidget extends StatelessWidget {
  final int selectedTabIndex;
  final ValueChanged<int>? onTabChanged;

  const FakeOtherUserProfileTabBarWidget({
    super.key,
    required this.selectedTabIndex,
    this.onTabChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: Get.width,
      padding: const EdgeInsets.symmetric(horizontal: 15),
      color: AppColor.colorBorder.withValues(alpha: 0.5),
      child: Row(
        children: [
          TabItemWidget(
            title: "Data",
            isSelected: selectedTabIndex == 0,
            onTap: () => onTabChanged?.call(0),
          ),
          TabItemWidget(
            title: "Moments",
            isSelected: selectedTabIndex == 1,
            onTap: () => onTabChanged?.call(1),
          ),
          TabItemWidget(
            title: "Wonderful moments",
            isSelected: selectedTabIndex == 2,
            onTap: () => onTabChanged?.call(2),
          ),
        ],
      ),
    );
  }
}

class TabItemWidget extends StatelessWidget {
  const TabItemWidget({
    super.key,
    required this.title,
    required this.isSelected,
    required this.onTap,
  });

  final String title;
  final bool isSelected;
  final Callback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
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
