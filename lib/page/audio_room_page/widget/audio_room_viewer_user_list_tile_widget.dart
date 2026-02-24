import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tingle/common/widget/custom_text_scrolling.dart';
import 'package:tingle/common/widget/preview_network_image_widget.dart';

import 'package:tingle/page/audio_room_page/controller/audio_room_controller.dart';
import 'package:tingle/page/audio_room_page/model/live_viewer_user_model.dart';
import 'package:tingle/page/other_user_profile_bottom_sheet/view/other_user_profile_bottom_sheet.dart';
import 'package:tingle/routes/app_routes.dart';
import 'package:tingle/utils/assets.dart';
import 'package:tingle/utils/color.dart';
import 'package:tingle/utils/database.dart';
import 'package:tingle/utils/enums.dart';
import 'package:tingle/utils/font_style.dart';
import 'package:tingle/utils/utils.dart';

class AudioRoomViewerUserListTileWidget extends StatefulWidget {
  const AudioRoomViewerUserListTileWidget({
    super.key,
    required this.index,
    this.indexData,
  });

  final int index;
  final LiveViewerUserModel? indexData;

  @override
  State<AudioRoomViewerUserListTileWidget> createState() => _AudioRoomViewerUserListTileWidgetState();
}

class _AudioRoomViewerUserListTileWidgetState extends State<AudioRoomViewerUserListTileWidget> {
  final controller = Get.find<AudioRoomController>();
  RxBool isFollow = false.obs;

  @override
  void initState() {
    isFollow.value = (widget.indexData?.isFollow ?? false);
    super.initState();
  }

  void onClickFollow() async {
    if (widget.indexData?.userId != Database.loginUserId) {
      isFollow.value = !isFollow.value;

      controller.audioRoomModel?.liveViewers[widget.index].isFollow = isFollow.value;
    } else {
      Utils.showToast(text: EnumLocal.txtYouCantFollowYourOwnAccount.name.tr);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (widget.indexData?.userId != Database.loginUserId) {
          controller.scaffoldKey.currentState?.closeEndDrawer();
          OtherUserProfileBottomSheet.show(context: context, userId: widget.indexData?.userId ?? "");
        } else {
          // GOTO OWN PROFILE PAGE
          controller.scaffoldKey.currentState?.closeEndDrawer();
          Get.toNamed(AppRoutes.previewUserProfilePage, arguments: widget.indexData?.userId ?? "");
        }
      },
      child: Container(
        height: 70,
        width: Get.width,
        padding: const EdgeInsets.symmetric(horizontal: 5),
        margin: const EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
          color: AppColor.transparent,
          border: Border(
            bottom: BorderSide(color: AppColor.secondary.withValues(alpha: 0.3)),
          ),
        ),
        child: Row(
          children: [
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: widget.indexData?.avatarFrame != null ? AppColor.transparent : AppColor.white),
                shape: BoxShape.circle,
              ),
              child: Container(
                height: 38,
                width: 38,
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(color: AppColor.transparent, shape: BoxShape.circle),
                child: PreviewProfileImageWithFrameWidget(
                  image: widget.indexData?.image,
                  isBanned: widget.indexData?.isProfilePicBanned,
                  margin: EdgeInsets.all(5),
                  frame: widget.indexData?.avatarFrame,
                  type: widget.indexData?.avtarFrameType,
                ),
              ),
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
                        child: CustomTextScrolling(
                          text: widget.indexData?.name ?? "",
                          style: AppFontStyle.styleW600(AppColor.white, 13),
                        ),
                      ),
                      Visibility(
                        visible: false,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 3),
                          child: Image.asset(AppAssets.icAuthoriseIcon, width: 18),
                        ),
                      ),
                    ],
                  ),
                  3.height,
                  Text(
                    widget.indexData?.userName ?? "",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: AppFontStyle.styleW500(AppColor.white, 10),
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
                      border: Border.all(color: isFollow.value ? AppColor.white : AppColor.transparent),
                      borderRadius: BorderRadius.circular(100),
                    ),
                    child: Row(
                      children: [
                        Image.asset(
                          isFollow.value ? AppAssets.icFollowing : AppAssets.icFollow,
                          width: 20,
                          color: AppColor.white,
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
