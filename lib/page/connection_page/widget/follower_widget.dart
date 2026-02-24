import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tingle/common/shimmer/user_list_shimmer_widget.dart';
import 'package:tingle/common/widget/no_data_found_widget.dart';
import 'package:tingle/page/connection_page/controller/connection_controller.dart';
import 'package:tingle/page/connection_page/widget/connection_widget.dart';
import 'package:tingle/page/other_user_profile_bottom_sheet/view/other_user_profile_bottom_sheet.dart';

import 'package:tingle/utils/constant.dart';

class FollowersWidget extends StatelessWidget {
  const FollowersWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ConnectionController>(
      id: AppConstant.onChangeFollowUpdate,
      builder: (controller) {
        log("Data Refresh Followers");
        return controller.isLoading
            ? UserListShimmerWidget()
            : controller.followers.isEmpty
                ? NoDataFoundWidget()
                : SingleChildScrollView(
                    padding: EdgeInsets.zero,
                    child: ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: controller.followers.length,
                      itemBuilder: (context, index) {
                        final indexData = controller.followers[index];

                        return UserListTileWidget(
                          id: indexData.id ?? "",
                          title: indexData.name ?? "",
                          subTitle: indexData.userName ?? "SUBTITLE",
                          leading: indexData.image ?? "LEADING",
                          isVerified: indexData.isVerified ?? false,
                          isFollow: indexData.isFollow ?? false,
                          uniqueId: indexData.uniqueId ?? "",
                          isProfileImageBanned: indexData.isProfilePicBanned ?? false,
                          callback: () {
                            log("User ID: ${indexData.id}");

                            OtherUserProfileBottomSheet.show(context: context, userId: indexData.id ?? "");
                          },
                          age: indexData.age ?? 18,
                          coin: indexData.coin ?? 0,
                          wealthLevelImage: indexData.wealthLevelImage ?? "",
                          isonline: indexData.isOnline ?? false,
                        );
                      },
                    ),
                  );
      },
    );
  }
}
