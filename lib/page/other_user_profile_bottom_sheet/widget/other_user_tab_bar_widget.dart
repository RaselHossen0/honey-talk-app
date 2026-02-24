import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';
import 'package:tingle/page/other_user_profile_bottom_sheet/view/other_user_profile_bottom_sheet.dart';
import 'package:tingle/page/other_user_profile_bottom_sheet/widget/other_user_profile_data_tab_widget.dart';
import 'package:tingle/page/other_user_profile_bottom_sheet/widget/other_user_profile_details_widget.dart';
import 'package:tingle/page/other_user_profile_bottom_sheet/widget/other_user_profile_moments_tab_widget.dart';
import 'package:tingle/page/other_user_profile_bottom_sheet/widget/other_user_profile_won_mom_tab_widget.dart';
import 'package:tingle/utils/color.dart';
import 'package:tingle/utils/enums.dart';
import 'package:tingle/utils/font_style.dart';
import 'package:tingle/utils/utils.dart';

class OtherUserProfileTabBarWidget extends StatelessWidget {
  const OtherUserProfileTabBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Column(
        children: [
          OtherUserProfileDetailsWidget(),
          15.height,
          Container(
            height: 50,
            width: Get.width,
            padding: const EdgeInsets.symmetric(horizontal: 15),
            color: AppColor.colorBorder.withAlpha(128),
            child: Row(
              children: [
                _TabItemWidget(
                  title: EnumLocal.txtData.name.tr,
                  isSelected: OtherUserProfileBottomSheet.selectedTabIndex.value == 0,
                  onTap: () {
                    OtherUserProfileBottomSheet.onTabBar(0);
                  },
                ),
                _TabItemWidget(
                  title: EnumLocal.txtMoments.name.tr,
                  isSelected: OtherUserProfileBottomSheet.selectedTabIndex.value == 1,
                  onTap: () {
                    OtherUserProfileBottomSheet.onTabBar(1);
                  },
                ),
                _TabItemWidget(
                  title: EnumLocal.txtWonderfulMoments.name.tr,
                  isSelected: OtherUserProfileBottomSheet.selectedTabIndex.value == 2,
                  onTap: () {
                    OtherUserProfileBottomSheet.onTabBar(2);
                  },
                ),
              ],
            ),
          ),
          15.height,
          IndexedStack(
            index: OtherUserProfileBottomSheet.selectedTabIndex.value,
            children: [
              OtherUserProfileDataTabWidget(),
              OtherUserProfileMomentsTabWidget(),
              OtherUserProfileWonMomTabWidget(),
            ],
          ),
        ],
      );
    });
  }
}

class _TabItemWidget extends StatelessWidget {
  const _TabItemWidget({
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
