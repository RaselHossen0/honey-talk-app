import 'package:cached_network_image/cached_network_image.dart';
import 'package:fading_edge_scrollview/fading_edge_scrollview.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tingle/common/widget/preview_network_image_widget.dart';
import 'package:tingle/page/fake_audio_room_page/controller/fake_audio_room_controller.dart';
import 'package:tingle/utils/color.dart';
import 'package:tingle/utils/constant.dart';
import 'package:tingle/utils/font_style.dart';
import 'package:tingle/utils/utils.dart';

class FakeAudioRoomCommentWidget extends StatelessWidget {
  const FakeAudioRoomCommentWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<FakeAudioRoomController>(
      id: AppConstant.onChangeComment,
      builder: (controller) {
        final scrollController = controller.fakeAudioRoomModel?.scrollController;

        return Container(
          height: 100,
          width: Get.width / 1.6,
          color: AppColor.transparent,
          child: Align(
            alignment: Alignment.bottomLeft,
            child: FadingEdgeScrollView.fromSingleChildScrollView(
              gradientFractionOnStart: 0.1,
              gradientFractionOnEnd: 0.0,
              child: SingleChildScrollView(
                controller: scrollController,
                physics: const AlwaysScrollableScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: controller.fakeCommentList.map((indexData) {
                    return indexData.type == 1
                        ? LiveCommentTextWidget(
                            image: indexData.image,
                            name: indexData.user,
                            comment: indexData.message,
                          )
                        : LiveEmojiCommentWidget(
                            name: indexData.user,
                            emoji: indexData.emoji,
                            image: indexData.image,
                          );
                  }).toList(),
                ),
              ),
            ),
          ),
        );
      },
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
          "$roomName : Welcome to join the live. Any content related to porn, violence, gambling, illegal dealing will be banned.",
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
  const LiveCommentTextWidget({super.key, required this.name, required this.comment, required this.image});

  final String name;
  final String comment;
  final String image;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 10, bottom: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CachedNetworkImage(
              imageUrl: image,
              height: 32,
              width: 32,
              fit: BoxFit.cover,
              placeholder: (context, url) => ProfileImagePlaceHolder(),
              errorWidget: (context, url, error) => ProfileImagePlaceHolder(),
              imageBuilder: (context, imageProvider) {
                return Container(
                  height: 32,
                  width: 32,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColor.colorBorder.withValues(alpha: 0.8),
                    image: DecorationImage(image: imageProvider, fit: BoxFit.cover),
                  ),
                );
              }),
          10.width,
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

class LiveEmojiCommentWidget extends StatelessWidget {
  const LiveEmojiCommentWidget({super.key, required this.name, required this.emoji, required this.image});

  final String name;
  final String emoji;
  final String image;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 10, bottom: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CachedNetworkImage(
              imageUrl: image,
              height: 32,
              width: 32,
              fit: BoxFit.cover,
              placeholder: (context, url) => ProfileImagePlaceHolder(),
              errorWidget: (context, url, error) => ProfileImagePlaceHolder(),
              imageBuilder: (context, imageProvider) {
                return Container(
                  height: 32,
                  width: 32,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColor.colorBorder.withValues(alpha: 0.8),
                    image: DecorationImage(image: imageProvider, fit: BoxFit.cover),
                  ),
                );
              }),
          10.width,
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
          ),
        ],
      ),
    );
  }
}

// class _CommentItemUi extends StatelessWidget {
//   const _CommentItemUi({
//     super.key,
//     required this.name,
//     required this.image,
//     required this.commentText,
//     required this.isBanned,
//   });
//
//   final String name;
//   final String image;
//   final String commentText;
//   final bool isBanned;
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: Get.width / 2,
//       padding: EdgeInsets.symmetric(horizontal: 15),
//       margin: EdgeInsets.symmetric(vertical: 10),
//       decoration: const BoxDecoration(color: AppColor.transparent),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.start,
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Column(
//             mainAxisAlignment: MainAxisAlignment.start,
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Container(
//                 height: 38,
//                 width: 38,
//                 clipBehavior: Clip.antiAlias,
//                 decoration: BoxDecoration(shape: BoxShape.circle, color: AppColor.colorBorder.withValues(alpha: 0.8)),
//                 child: PreviewProfileImageWidget(image: image, isBanned: isBanned),
//               ),
//             ],
//           ),
//           10.width,
//           Expanded(
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.start,
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   name,
//                   maxLines: 1,
//                   style: AppFontStyle.styleW600(AppColor.white, 11.5),
//                 ),
//                 2.height,
//                 Text(
//                   commentText,
//                   style: AppFontStyle.styleW600(AppColor.white, 13.5),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
