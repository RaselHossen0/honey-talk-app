import 'dart:developer';

import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';
import 'package:tingle/common/shimmer/user_list_shimmer_widget.dart';
import 'package:tingle/common/widget/no_data_found_widget.dart';
import 'package:tingle/page/connection_page/controller/connection_controller.dart';
import 'package:tingle/page/connection_page/widget/connection_widget.dart';
import 'package:tingle/page/other_user_profile_bottom_sheet/view/other_user_profile_bottom_sheet.dart';
import 'package:tingle/utils/assets.dart';
import 'package:tingle/utils/color.dart';
import 'package:tingle/utils/constant.dart';
import 'package:tingle/utils/font_style.dart';
import 'package:tingle/utils/utils.dart';

class SearchTextFieldConnectionWidget extends StatelessWidget {
  const SearchTextFieldConnectionWidget({
    super.key,
    required this.onClickClear,
    required this.controller,
    required this.onChanged,
    required this.isShowClearIcon,
    required this.onTap,
    required this.hintText,
  });

  final Callback onClickClear;
  final Callback onTap;
  final TextEditingController controller;
  final Function(String value) onChanged;
  final bool isShowClearIcon;
  final String hintText;

  @override
  Widget build(BuildContext context) {
    Utils.onChangeStatusBar(brightness: Brightness.dark);
    return Container(
      height: 45,
      width: Get.width,
      padding: const EdgeInsets.only(left: 12, right: 12),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: AppColor.secondary.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(100),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            height: 20,
            width: 20,
            AppAssets.icSearch,
            color: AppColor.secondary,
          ),
          12.width,
          Expanded(
            child: TextFormField(
              controller: controller,
              cursorColor: AppColor.secondary,
              maxLines: 1,
              onTap: onTap,
              onChanged: onChanged,
              style: AppFontStyle.styleW600(AppColor.black, 15),
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.only(bottom: 5),
                border: InputBorder.none,
                hintText: hintText,
                hintStyle: AppFontStyle.styleW500(AppColor.secondary, 15),
              ),
            ),
          ),
          controller.text.isEmpty
              ? SizedBox()
              : GestureDetector(
                  onTap: isShowClearIcon ? () {} : onClickClear,
                  child: isShowClearIcon
                      ? SizedBox(
                          height: 22,
                          width: 22,
                          child: CircularProgressIndicator(
                            strokeWidth: 3,
                            color: AppColor.primary,
                          ),
                        )
                      : Container(
                          height: 22,
                          width: 22,
                          decoration: BoxDecoration(
                            color: isShowClearIcon ? AppColor.red : AppColor.secondary.withValues(alpha: 0.8),
                            shape: BoxShape.circle,
                          ),
                          child: Center(
                            child: Image.asset(
                              height: 15,
                              width: 15,
                              AppAssets.icClose,
                              color: AppColor.white,
                            ),
                          ),
                        ),
                ),
        ],
      ),
    );
  }
}

class SearchConnectionWidget extends StatelessWidget {
  const SearchConnectionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ConnectionController>(
      id: AppConstant.onSearchConnection,
      builder: (controller) => controller.isSearchLoading
          ? UserListShimmerWidget()
          : controller.searchData.isEmpty
              ? NoDataFoundWidget()
              : SingleChildScrollView(
                  padding: EdgeInsets.zero,
                  child: ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: controller.searchData.length,
                    itemBuilder: (context, index) {
                      final indexData = controller.searchData[index];

                      return UserListTileWidget(
                        id: indexData.id ?? "",
                        title: indexData.name ?? "",
                        subTitle: indexData.userName ?? "SUBTITLE",
                        leading: indexData.image ?? "LEADING",
                        isVerified: indexData.isVerified ?? false,
                        isFollow: indexData.isFollow ?? false,
                        age: indexData.age ?? 18,
                        coin: indexData.coin ?? 0,
                        isProfileImageBanned: indexData.isProfilePicBanned ?? false,
                        callback: () {
                          log("User ID: ${indexData.id}");
                          OtherUserProfileBottomSheet.show(context: context, userId: indexData.id ?? "");
                        },
                        wealthLevelImage: indexData.wealthLevelImage ?? "",
                        isonline: indexData.isOnline ?? false,
                        uniqueId: indexData.uniqueId ?? "",
                      );
                    },
                  ),
                ),
    );
  }
}
