import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';
import 'package:tingle/common/widget/preview_network_image_widget.dart';

import 'package:tingle/page/connection_page/controller/connection_controller.dart';
import 'package:tingle/utils/assets.dart';
import 'package:tingle/utils/color.dart';
import 'package:tingle/utils/constant.dart';
import 'package:tingle/utils/database.dart';
import 'package:tingle/utils/enums.dart';
import 'package:tingle/utils/font_style.dart';
import 'package:tingle/utils/utils.dart';

class UserListTileWidget extends StatefulWidget {
  const UserListTileWidget({
    super.key,
    required this.id,
    required this.title,
    required this.subTitle,
    required this.leading,
    required this.callback,
    required this.isVerified,
    required this.isProfileImageBanned,
    required this.isFollow,
    required this.isonline,
    required this.wealthLevelImage,
    required this.coin,
    required this.uniqueId,
    required this.age,
  });
  final String id;
  final String title;
  final String subTitle;
  final String leading;
  final String uniqueId;
  final String wealthLevelImage;
  final bool isVerified;
  final int coin;
  final int age;
  final Callback callback;
  final bool isFollow;
  final bool isProfileImageBanned;
  final bool isonline;

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
    if (widget.id != Database.loginUserId) {
      isFollow.value = !isFollow.value;
      Utils.showLog("FOLLOW TAP ${isFollow.value}");
    }
  }

  followUpdate() {
    isFollow.value = widget.isFollow;
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ConnectionController>(
      id: AppConstant.onChangeFollowUpdate,
      builder: (controller) {
        followUpdate();
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
                Stack(
                  children: [
                    Container(
                      height: 60,
                      width: 60,
                      clipBehavior: Clip.antiAlias,
                      decoration: BoxDecoration(color: AppColor.transparent, borderRadius: BorderRadius.all(Radius.circular(10))),
                      child: PreviewProfileImageWidget(image: widget.leading, isBanned: widget.isProfileImageBanned),
                    ),
                    widget.isonline
                        ? Positioned(
                            bottom: 3,
                            right: 3,
                            child: Container(
                              height: 15,
                              width: 15,
                              decoration: BoxDecoration(border: Border.all(color: AppColor.white, width: 1.2), shape: BoxShape.circle, color: AppColor.green),
                            ))
                        : SizedBox(),
                  ],
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
                              style: AppFontStyle.styleW700(AppColor.black, 15),
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
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                            decoration: BoxDecoration(
                              color: AppColor.primary,
                              borderRadius: BorderRadius.circular(100),
                            ),
                            child: Row(
                              children: [
                                Image.asset(AppAssets.icFemale, width: 10),
                                3.width,
                                Text(
                                  "${widget.age}",
                                  style: AppFontStyle.styleW600(AppColor.white, 10),
                                ),
                              ],
                            ),
                          ),
                          5.width,
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                            decoration: BoxDecoration(
                              color: AppColor.lightGrayBg,
                              borderRadius: BorderRadius.circular(100),
                            ),
                            child: widget.wealthLevelImage.isNotEmpty
                                ? Image.asset(AppAssets.icLotus, width: 15)
                                : Row(
                                    children: [
                                      Image.asset(AppAssets.icLotus, width: 15),
                                      3.width,
                                      Text(
                                        "25",
                                        style: AppFontStyle.styleW600(AppColor.mediumBlue, 10),
                                      ),
                                    ],
                                  ),
                          ),
                          5.width,
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                            decoration: BoxDecoration(
                              color: AppColor.lightYellow.withValues(alpha: 0.2),
                              borderRadius: BorderRadius.circular(100),
                            ),
                            child: Row(
                              children: [
                                Image.asset(AppAssets.icCoinStar, width: 15),
                                3.width,
                                Text(
                                  "${widget.coin}",
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
                        style: AppFontStyle.styleW600(AppColor.lightGreyPurple, 12),
                      ),
                    ],
                  ),
                ),
                12.width,
                Obx(
                  () => GestureDetector(
                    onTap: onClickFollow,
                    child: !isFollow.value
                        ? Container(
                            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                            decoration: BoxDecoration(
                              color: AppColor.primary,
                              borderRadius: BorderRadius.circular(100),
                            ),
                            child: Text(
                              EnumLocal.txtFollow.name.tr,
                              style: AppFontStyle.styleW600(AppColor.white, 12),
                            ),
                          )
                        : Container(
                            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                            decoration: BoxDecoration(
                              color: AppColor.primary.withValues(alpha: 0.08),
                              borderRadius: BorderRadius.circular(100),
                            ),
                            child: Text(
                              EnumLocal.txtFollowing.name.tr,
                              style: AppFontStyle.styleW600(AppColor.primary, 12),
                            ),
                          ),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
