import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tingle/common/widget/preview_network_image_widget.dart';
import 'package:tingle/common/widget/scroll_fade_effect_widget.dart';
import 'package:tingle/page/audio_room_page/controller/audio_room_controller.dart';
import 'package:tingle/utils/color.dart';
import 'package:tingle/utils/constant.dart';
import 'package:tingle/utils/enums.dart';
import 'package:tingle/utils/font_style.dart';
import 'package:tingle/utils/utils.dart';

class AudioRoomCommentWidget extends StatelessWidget {
  const AudioRoomCommentWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AudioRoomController>(
      id: AppConstant.onChangeComment,
      builder: (controller) => ScrollFadeEffectWidget(
        axis: Axis.vertical,
        child: SingleChildScrollView(
          controller: controller.audioRoomModel?.scrollController,
          child: ListView.builder(
            itemCount: controller.audioRoomModel?.liveComments.length ?? 0,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            padding: EdgeInsets.zero,
            itemBuilder: (context, index) {
              final indexData = controller.audioRoomModel?.liveComments[index];
              return indexData?.type == 1
                  ? LiveCommentTextWidget(
                      name: indexData?.name ?? "",
                      comment: indexData?.commentText ?? "",
                      image: indexData?.image ?? "",
                      isBanned: indexData?.isBanned ?? false,
                    )
                  : indexData?.type == 2
                      ? LiveRoomNameCommentWidget(roomName: controller.audioRoomModel?.roomName ?? "")
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

class LiveRoomNameCommentWidget extends StatelessWidget {
  const LiveRoomNameCommentWidget({super.key, required this.roomName});

  final String roomName;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 10, bottom: 10),
      child: Container(
        width: Get.width / 2,
        decoration: BoxDecoration(
          color: AppColor.black.withValues(alpha: 0.3),
          borderRadius: BorderRadius.circular(10),
        ),
        padding: EdgeInsets.all(15),
        child: Text(
          "$roomName : ${EnumLocal.txtWelcomeToJoinTheLiveAnyContentRelated.name.tr}",
          style: AppFontStyle.styleW500(AppColor.lightGreen, 12),
        ),
      ),
    );
  }
}

class LiveAnnouncementCommentWidget extends StatelessWidget {
  const LiveAnnouncementCommentWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 10, bottom: 10),
      child: Container(
        decoration: BoxDecoration(
          color: AppColor.black.withValues(alpha: 0.2),
          borderRadius: BorderRadius.circular(100),
        ),
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: Text(
          "Announcement : Welcome to room",
          style: AppFontStyle.styleW500(AppColor.lightYellowGreen, 11),
        ),
      ),
    );
  }
}

class LiveCommentTextWidget extends StatelessWidget {
  const LiveCommentTextWidget({super.key, required this.name, required this.comment, required this.image, required this.isBanned});

  final String name;
  final String image;
  final bool isBanned;
  final String comment;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 10, bottom: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 30,
            width: 30,
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(shape: BoxShape.circle),
            child: PreviewProfileImageWidget(image: image, isBanned: isBanned),
          ),
          5.width,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: AppFontStyle.styleW500(AppColor.lightBlue, 11),
                ),
                3.height,
                Container(
                  decoration: BoxDecoration(
                    color: AppColor.black.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(10),
                      bottomRight: Radius.circular(10),
                      bottomLeft: Radius.circular(10),
                    ),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  child: Text(
                    comment,
                    style: AppFontStyle.styleW500(AppColor.white, 11),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class FakeLiveCommentTextWidget extends StatelessWidget {
  const FakeLiveCommentTextWidget({
    super.key,
    required this.name,
    required this.comment,
    required this.image,
    required this.isBanned,
  });

  final String name;
  final String image;
  final bool isBanned;
  final String comment;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, bottom: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 30,
            width: 30,
            clipBehavior: Clip.antiAlias,
            decoration: const BoxDecoration(shape: BoxShape.circle),
            child: PreviewProfileImageWidget(image: image, isBanned: isBanned),
          ),
          const SizedBox(width: 5),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: AppFontStyle.styleW500(AppColor.lightBlue, 11),
                ),
                const SizedBox(height: 3),
                Container(
                  decoration: BoxDecoration(
                    color: AppColor.black.withAlpha(33),
                    borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(10),
                      bottomRight: Radius.circular(10),
                      bottomLeft: Radius.circular(10),
                    ),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  child: Text(
                    comment,
                    style: AppFontStyle.styleW500(AppColor.white, 11),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class LiveEmojiCommentWidget extends StatelessWidget {
  const LiveEmojiCommentWidget({super.key, required this.name, required this.emoji});

  final String name;
  final String emoji;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 10, bottom: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            name,
            style: AppFontStyle.styleW500(AppColor.lightBlue, 11),
          ),
          3.height,
          Container(
            decoration: BoxDecoration(
              color: AppColor.black.withValues(alpha: 0.2),
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(10),
                bottomRight: Radius.circular(10),
                bottomLeft: Radius.circular(10),
              ),
            ),
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: SizedBox(
              height: 50,
              width: 50,
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: PreviewProfileImageWidget(image: emoji),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
