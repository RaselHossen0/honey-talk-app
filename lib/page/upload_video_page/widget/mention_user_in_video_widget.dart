import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tingle/common/widget/loading_widget.dart';
import 'package:tingle/common/widget/no_data_found_widget.dart';
import 'package:tingle/page/upload_feed_page/widget/mention_user_list_tile_widget.dart';
import 'package:tingle/page/upload_video_page/controller/upload_video_controller.dart';
import 'package:tingle/page/upload_video_page/widget/mention_app_bar_widget.dart';
import 'package:tingle/utils/color.dart';
import 'package:tingle/utils/constant.dart';
import 'package:tingle/utils/enums.dart';
import 'package:tingle/utils/font_style.dart';

class MentionUserInVideoWidget extends StatelessWidget {
  const MentionUserInVideoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<UploadVideoController>();
    return Scaffold(
      backgroundColor: AppColor.white,
      body: Column(
        children: [
          MentionAppBarWidget(),
          Container(
            height: 50,
            width: Get.width,
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.symmetric(horizontal: 15),
            color: AppColor.secondary.withValues(alpha: 0.1),
            child: Text(
              "${EnumLocal.txtFollowEachOther.name.tr} ${controller.friends.length}",
              style: AppFontStyle.styleW600(AppColor.black, 16),
            ),
          ),
          Expanded(
            child: GetBuilder<UploadVideoController>(
              id: AppConstant.onGetFriend,
              builder: (controller) => controller.isLoadingFriend
                  ? LoadingWidget()
                  : controller.friends.isEmpty
                      ? NoDataFoundWidget()
                      : SingleChildScrollView(
                          child: ListView.builder(
                            itemCount: controller.friends.length,
                            shrinkWrap: true,
                            padding: EdgeInsets.zero,
                            physics: NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              final indexData = controller.friends[index];
                              return MentionUserListTileWidget(
                                name: indexData.name ?? "",
                                userName: indexData.userName ?? "",
                                image: indexData.image ?? "",
                                callback: () => controller.onChangeMentionUser(indexData.id ?? ""),
                                isSelected: controller.mentionedUserIds.contains(indexData.id ?? ""),
                                isVerified: indexData.isVerified ?? false,
                                isProfileImageBanned: indexData.isProfilePicBanned ?? false,
                              );
                            },
                          ),
                        ),
            ),
          ),
        ],
      ),
    );
  }
}
