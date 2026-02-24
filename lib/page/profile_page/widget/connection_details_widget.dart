import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';
import 'package:tingle/custom/function/custom_format_number.dart';
import 'package:tingle/page/profile_page/controller/profile_controller.dart';
import 'package:tingle/routes/app_routes.dart';
import 'package:tingle/utils/api_params.dart';
import 'package:tingle/utils/color.dart';
import 'package:tingle/utils/constant.dart';
import 'package:tingle/utils/enums.dart';
import 'package:tingle/utils/font_style.dart';
import 'package:tingle/utils/utils.dart';

class ConnectionDetailsWidget extends StatelessWidget {
  const ConnectionDetailsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProfileController>(
      id: AppConstant.onGetProfile,
      builder: (controller) => Container(
        height: 74,
        width: Get.width,
        margin: const EdgeInsets.symmetric(horizontal: 15),
        decoration: BoxDecoration(
          color: AppColor.white.withValues(alpha: 0.5),
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: AppColor.secondary.withValues(alpha: 0.1),
              blurRadius: 2,
              spreadRadius: 2,
            ),
          ],
        ),
        child: Row(
          children: [
            ItemWidget(
              title: EnumLocal.txtFriend.name.tr,
              count: (controller.fetchUserProfileModel?.user?.totalFriends ?? 0).toInt(),
              callback: () {
                Get.toNamed(AppRoutes.connectionPage, arguments: {ApiParams.tabIndex: 0})?.then((value) {
                  Utils.onChangeStatusBar(brightness: Brightness.dark);
                  controller.scrollController.jumpTo(0.0);
                });
              },
            ),
            VerticalDivider(
              color: AppColor.grayText.withValues(alpha: 0.3),
              indent: 15,
              endIndent: 15,
            ),
            ItemWidget(
              title: EnumLocal.txtFollow.name.tr,
              count: (controller.fetchUserProfileModel?.user?.totalFollowing ?? 0).toInt(),
              callback: () {
                Get.toNamed(AppRoutes.connectionPage, arguments: {ApiParams.tabIndex: 1})?.then((value) {
                  Utils.onChangeStatusBar(brightness: Brightness.dark);
                  controller.scrollController.jumpTo(0.0);
                });
              },
            ),
            VerticalDivider(
              color: AppColor.grayText.withValues(alpha: 0.3),
              indent: 15,
              endIndent: 15,
            ),
            ItemWidget(
              title: EnumLocal.txtFollowers.name.tr,
              count: (controller.fetchUserProfileModel?.user?.totalFollowers ?? 0).toInt(),
              callback: () {
                Get.toNamed(AppRoutes.connectionPage, arguments: {ApiParams.tabIndex: 2})?.then((value) {
                  Utils.onChangeStatusBar(brightness: Brightness.dark);
                  controller.scrollController.jumpTo(0.0);
                });
              },
            ),
            VerticalDivider(
              color: AppColor.grayText.withValues(alpha: 0.3),
              indent: 15,
              endIndent: 15,
            ),
            ItemWidget(
              title: EnumLocal.txtVisitors.name.tr,
              count: (controller.fetchUserProfileModel?.user?.totalVisitors ?? 0).toInt(),
              callback: () {
                Get.toNamed(AppRoutes.connectionPage, arguments: {ApiParams.tabIndex: 3})?.then((value) {
                  Utils.onChangeStatusBar(brightness: Brightness.dark);
                  controller.scrollController.jumpTo(0.0);
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}

class ItemWidget extends StatelessWidget {
  const ItemWidget({super.key, required this.title, required this.count, required this.callback});

  final String title;
  final int count;
  final Callback callback;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        overlayColor: WidgetStatePropertyAll(AppColor.transparent),
        onTap: callback,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              CustomFormatNumber.onConvert(count),
              style: AppFontStyle.styleW700(AppColor.greyBlue, 14),
            ),
            10.height,
            Text(
              title,
              style: AppFontStyle.styleW500(AppColor.grayText, 10),
            ),
          ],
        ),
      ),
    );
  }
}
