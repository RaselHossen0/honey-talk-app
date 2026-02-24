import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tingle/common/shimmer/user_list_shimmer_widget.dart';
import 'package:tingle/common/widget/no_data_found_widget.dart';
import 'package:tingle/page/other_user_connection_page/controller/other_user_connection_controller.dart';
import 'package:tingle/page/other_user_connection_page/widget/other_user_connection_widget.dart';
import 'package:tingle/page/other_user_profile_bottom_sheet/view/other_user_profile_bottom_sheet.dart';
import 'package:tingle/utils/constant.dart';

class OtherUserFollowsWidget extends StatelessWidget {
  const OtherUserFollowsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<OtherUserConnectionController>(
      id: AppConstant.onChangeFollowUpdate,
      builder: (controller) => controller.isLoading
          ? UserListShimmerWidget()
          : controller.following.isEmpty
              ? NoDataFoundWidget()
              : SingleChildScrollView(
                  padding: EdgeInsets.zero,
                  child: ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: controller.following.length,
                    itemBuilder: (context, index) {
                      final indexData = controller.following[index];

                      return OtherUserListTileWidget(
                        id: indexData.id ?? "",
                        title: indexData.name ?? "",
                        subTitle: indexData.userName ?? "SUBTITLE",
                        leading: indexData.image ?? "LEADING",
                        isVerified: indexData.isVerified ?? false,
                        isFollow: indexData.isFollow ?? false,
                        isProfileImageBanned: indexData.isProfilePicBanned ?? false,
                        callback: () {
                          log("User ID: ${indexData.id}");
                          OtherUserProfileBottomSheet.show(context: context, userId: indexData.id ?? "");
                        },
                        age: indexData.age ?? 18,
                        coin: indexData.coin ?? 0,
                        uniqueId: indexData.uniqueId ?? "",
                        wealthLevelImage: indexData.wealthLevelImage ?? "",
                        isonline: indexData.isOnline ?? false,
                      );
                    },
                  ),
                ),
    );
  }
}
