import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';

import 'package:tingle/common/shimmer/user_list_shimmer_widget.dart';
import 'package:tingle/common/widget/no_data_found_widget.dart';
import 'package:tingle/common/widget/preview_network_image_widget.dart';
import 'package:tingle/custom/function/custom_format_number.dart';

import 'package:tingle/page/other_user_profile_bottom_sheet/view/other_user_profile_bottom_sheet.dart';
import 'package:tingle/page/search_page/controller/search_controller.dart' as controller;
import 'package:tingle/utils/assets.dart';
import 'package:tingle/utils/color.dart';
import 'package:tingle/utils/constant.dart';
import 'package:tingle/utils/database.dart';
import 'package:tingle/utils/enums.dart';
import 'package:tingle/utils/font_style.dart';
import 'package:tingle/utils/utils.dart';

class SearchUserWidget extends StatelessWidget {
  const SearchUserWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<controller.SearchController>(
      id: AppConstant.onGetSearchUser,
      builder: (controller) => controller.isLoadingUser
          ? UserListShimmerWidget()
          : controller.searchUsers.isEmpty
              ? NoDataFoundWidget()
              : SingleChildScrollView(
                  padding: EdgeInsets.zero,
                  child: ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: controller.searchUsers.length,
                    itemBuilder: (context, index) {
                      final indexData = controller.searchUsers[index];

                      return UserListTileWidget(
                        userId: indexData.id ?? "",
                        title: indexData.name ?? "",
                        subTitle: indexData.userName ?? "",
                        leading: indexData.image ?? "",
                        isVerified: false,
                        isProfileImageBanned: indexData.isProfilePicBanned ?? false,
                        isFollow: indexData.isFollow ?? false,
                        wealthLevelImage: indexData.wealthLevel ?? "",
                        coin: indexData.coin ?? 0,
                        uniqueId: indexData.uniqueId ?? "",
                        age: indexData.age ?? 0,
                        callback: () async {
                          controller.onCreateSearchHistory(indexData.name ?? "");
                          controller.onVisitProfile(indexData.id ?? "");
                          OtherUserProfileBottomSheet.show(context: context, userId: indexData.id ?? "");
                        },
                      );
                    },
                  ),
                ),
    );
  }
}

class UserListTileWidget extends StatefulWidget {
  const UserListTileWidget({
    super.key,
    required this.userId,
    required this.title,
    required this.subTitle,
    required this.leading,
    required this.wealthLevelImage,
    required this.callback,
    required this.isVerified,
    required this.isProfileImageBanned,
    required this.isFollow,
    required this.coin,
    required this.uniqueId,
    required this.age,
  });

  final String userId;
  final String title;
  final String subTitle;
  final String leading;
  final String wealthLevelImage;
  final int coin;
  final String uniqueId;
  final Callback callback;
  final bool isVerified;
  final bool isProfileImageBanned;
  final bool isFollow;
  final int age;

  @override
  State<UserListTileWidget> createState() => _UserListTileWidgetState();
}

class _UserListTileWidgetState extends State<UserListTileWidget> {
  RxBool isFollow = false.obs;

  @override
  void initState() {
    isFollow.value = widget.isFollow;
    super.initState();
  }

  void onClickFollow() async {
    if (widget.userId != Database.loginUserId) {
      isFollow.value = !isFollow.value;
    } else {
      Utils.showToast(text: EnumLocal.txtYouCantFollowYourOwnAccount.name.tr);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.callback,
      child: Container(
        height: 80,
        width: Get.width,
        padding: const EdgeInsets.symmetric(horizontal: 15),
        decoration: BoxDecoration(
          color: AppColor.transparent,
          border: Border(
            bottom: BorderSide(color: AppColor.secondary.withValues(alpha: 0.1)),
          ),
        ),
        child: Row(
          children: [
            Container(
              height: 60,
              width: 60,
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(color: AppColor.transparent, shape: BoxShape.circle),
              child: PreviewProfileImageWidget(image: widget.leading, isBanned: widget.isProfileImageBanned),
            ),
            12.width,
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Flexible(
                        fit: FlexFit.loose,
                        child: Text(
                          widget.title,
                          maxLines: 1,
                          style: AppFontStyle.styleW700(AppColor.black, 13),
                        ),
                      ),
                      Visibility(
                        visible: widget.isVerified,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 3),
                          child: Image.asset(AppAssets.icAuthoriseIcon, width: 18),
                        ),
                      ),
                    ],
                  ),
                  3.height,
                  Row(
                    children: [
                      Container(
                        height: 18,
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        decoration: BoxDecoration(
                          color: AppColor.primary,
                          borderRadius: BorderRadius.circular(100),
                        ),
                        child: Row(
                          children: [
                            Image.asset(AppAssets.icFemale, width: 10),
                            3.width,
                            Text(
                              CustomFormatNumber.onConvert(widget.age),
                              style: AppFontStyle.styleW600(AppColor.white, 10),
                            ),
                          ],
                        ),
                      ),
                      5.width,
                      PreviewWealthLevelImage(image: widget.wealthLevelImage),
                      5.width,
                      Container(
                        height: 18,
                        padding: const EdgeInsets.only(left: 5, right: 8),
                        decoration: BoxDecoration(
                          color: AppColor.lightYellow.withValues(alpha: 0.2),
                          borderRadius: BorderRadius.circular(100),
                        ),
                        child: Row(
                          children: [
                            Image.asset(AppAssets.icCoinStar, width: 12),
                            3.width,
                            Text(
                              CustomFormatNumber.onConvert(widget.coin),
                              style: AppFontStyle.styleW600(AppColor.lightYellow, 10),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  3.height,
                  Text(
                    "ID: ${widget.uniqueId}",
                    maxLines: 1,
                    style: AppFontStyle.styleW600(AppColor.lightGreyPurple, 10),
                  ),
                ],
              ),
            ),
            12.width,
            GestureDetector(
              onTap: onClickFollow,
              child: Obx(
                () => Container(
                  height: 80,
                  color: AppColor.transparent,
                  alignment: Alignment.center,
                  child: Container(
                    height: 35,
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    decoration: BoxDecoration(
                      color: isFollow.value ? AppColor.transparent : AppColor.primary,
                      border: Border.all(color: isFollow.value ? AppColor.primary : AppColor.white),
                      borderRadius: BorderRadius.circular(100),
                    ),
                    child: Row(
                      children: [
                        Image.asset(isFollow.value ? AppAssets.icFollowing : AppAssets.icFollow, width: 20, color: isFollow.value ? AppColor.primary : AppColor.white),
                        5.width,
                        Text(
                          isFollow.value ? EnumLocal.txtFollowing.name.tr : EnumLocal.txtFollow.name.tr,
                          style: AppFontStyle.styleW600(isFollow.value ? AppColor.primary : AppColor.white, 12),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
