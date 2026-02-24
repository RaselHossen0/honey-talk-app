import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tingle/common/widget/no_data_found_widget.dart';
import 'package:tingle/page/audio_room_page/controller/audio_room_controller.dart';
import 'package:tingle/page/audio_room_page/widget/audio_room_viewer_user_list_tile_widget.dart';
import 'package:tingle/utils/assets.dart';
import 'package:tingle/utils/color.dart';
import 'package:tingle/utils/constant.dart';
import 'package:tingle/utils/enums.dart';
import 'package:tingle/utils/font_style.dart';

class AudioRoomViewerDrawerWidget extends GetView<AudioRoomController> {
  const AudioRoomViewerDrawerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: MediaQuery.of(context).viewPadding.top),
      child: Drawer(
        width: 250,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(topLeft: Radius.circular(20)),
        ),
        child: Container(
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(),
          child: Column(
            children: [
              Container(
                height: 50,
                width: Get.width,
                alignment: Alignment.center,
                padding: EdgeInsets.only(left: 15, right: 10),
                decoration: BoxDecoration(
                  gradient: AppColor.pinkPurpleGradient,
                  border: Border(
                    top: BorderSide(color: AppColor.secondary),
                    left: BorderSide(color: AppColor.secondary),
                  ),
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(20)),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '${EnumLocal.txtOnlineAudiences.name.tr} (${controller.audioRoomModel?.liveViewers.length ?? 0})',
                      style: AppFontStyle.styleW600(AppColor.white, 13),
                    ),
                    GestureDetector(
                      onTap: () => controller.scaffoldKey.currentState?.closeEndDrawer(),
                      child: Container(
                        height: 30,
                        width: 30,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColor.primary.withValues(alpha: 0.8),
                        ),
                        child: Image.asset(AppAssets.icClose, color: AppColor.white, width: 16),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: GetBuilder<AudioRoomController>(
                  id: AppConstant.onChangeViewCount,
                  builder: (controller) => Container(
                    decoration: BoxDecoration(
                      color: AppColor.darkPurple,
                      border: Border(left: BorderSide(color: AppColor.secondary)),
                    ),
                    child: (controller.audioRoomModel?.liveViewers.isEmpty ?? true)
                        ? NoDataFoundWidget(
                            iconSize: 130,
                            color: AppColor.white,
                            titleSize: 11,
                          )
                        : ListView.builder(
                            padding: EdgeInsets.zero,
                            itemCount: controller.audioRoomModel?.liveViewers.length ?? 0,
                            itemBuilder: (context, index) {
                              final indexData = controller.audioRoomModel?.liveViewers[index];
                              return AudioRoomViewerUserListTileWidget(index: index, indexData: indexData);
                            },
                          ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
