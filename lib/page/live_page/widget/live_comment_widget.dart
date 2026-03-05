import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tingle/common/widget/scroll_fade_effect_widget.dart';
import 'package:tingle/page/audio_room_page/widget/audio_room_comment_widget.dart';
import 'package:tingle/page/live_page/controller/live_controller.dart';
import 'package:tingle/utils/color.dart';
import 'package:tingle/utils/constant.dart';

class LiveCommentWidget extends StatelessWidget {
  const LiveCommentWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LiveController>(
      id: AppConstant.onChangeComment,
      builder: (controller) => Container(
        height: double.infinity,
        width: Get.width / 1.8,
        color: AppColor.transparent,
        child: ScrollFadeEffectWidget(
          axis: Axis.vertical,
          child: ListView.builder(
            controller: controller.liveModel?.scrollController,
            itemCount: controller.liveModel?.liveComments.length ?? 0,
            physics: const BouncingScrollPhysics(),
            padding: EdgeInsets.zero,
            reverse: true,
            itemBuilder: (context, index) {
              final idx = (controller.liveModel!.liveComments.length - 1 - index);
              final indexData = controller.liveModel?.liveComments[idx];
              return indexData?.type == 1
                  ? LiveCommentTextWidget(
                      name: indexData?.name ?? "",
                      comment: indexData?.commentText ?? "",
                      image: indexData?.image ?? "",
                      isBanned: indexData?.isBanned ?? false,
                    )
                  : indexData?.type == 2
                      ? LiveRoomNameCommentWidget(roomName: controller.liveModel?.host1Name ?? "")
                      : indexData?.type == 3
                          ? LiveAnnouncementCommentWidget()
                          : LiveEmojiCommentWidget(
                              name: indexData?.name ?? "",
                              emoji: indexData?.emoji ?? "",
                            );
            },
          ),
        ),
      ),
    );
  }
}
