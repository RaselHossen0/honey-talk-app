import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tingle/common/shimmer/hashtag_shimmer_widget.dart';
import 'package:tingle/common/widget/preview_network_image_widget.dart';
import 'package:tingle/page/edit_video_page/controller/edit_video_controller.dart';
import 'package:tingle/page/edit_video_page/widget/edit_video_app_bar_widget.dart';
import 'package:tingle/page/upload_video_page/widget/mention_user_in_video_widget.dart';
import 'package:tingle/utils/assets.dart';
import 'package:tingle/utils/color.dart';
import 'package:tingle/utils/constant.dart';
import 'package:tingle/utils/enums.dart';
import 'package:tingle/utils/font_style.dart';
import 'package:tingle/utils/utils.dart';

class EditVideoView extends GetView<EditVideoController> {
  const EditVideoView({super.key});

  @override
  Widget build(BuildContext context) {
    Utils.onChangeStatusBar(brightness: Brightness.dark);
    return Scaffold(
      backgroundColor: AppColor.white,
      appBar: EditVideoAppBarWidget.onShow(context),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            15.height,
            Container(
              height: 210,
              width: 160,
              clipBehavior: Clip.antiAlias,
              margin: EdgeInsets.only(left: 15),
              decoration: BoxDecoration(
                color: AppColor.secondary.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(15),
              ),
              child: SizedBox(
                height: 210,
                width: 160,
                child: GetBuilder<EditVideoController>(
                  id: AppConstant.onChangeThumbnail,
                  builder: (controller) => controller.videoThumbnail == ""
                      ? PreviewPostImageWidget(
                          image: controller.videoThumbnailUrl,
                          fit: BoxFit.cover,
                        )
                      : Image.file(
                          File(controller.videoThumbnail),
                          errorBuilder: (context, error, stackTrace) => Offstage(),
                          fit: BoxFit.cover,
                        ),
                ),
              ),
            ),
            15.height,
            GestureDetector(
              onTap: () => controller.onChangeThumbnail(context),
              child: Container(
                height: 55,
                padding: const EdgeInsets.symmetric(horizontal: 15),
                margin: const EdgeInsets.only(bottom: 10, top: 5),
                decoration: BoxDecoration(
                  color: AppColor.secondary.withValues(alpha: 0.05),
                  border: Border(
                    top: BorderSide(color: AppColor.secondary.withValues(alpha: 0.05)),
                    bottom: BorderSide(color: AppColor.secondary.withValues(alpha: 0.05)),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Image.asset(AppAssets.icGallery, width: 20, color: AppColor.primary),
                        10.width,
                        Text(
                          EnumLocal.txtChangeThumbnail.name.tr,
                          style: AppFontStyle.styleW500(AppColor.black, 16),
                        ),
                      ],
                    ),
                    Image.asset(AppAssets.icArrowRight, width: 8, color: AppColor.secondary)
                  ],
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              margin: const EdgeInsets.only(bottom: 10),
              color: AppColor.secondary.withValues(alpha: 0.05),
              child: TextFormField(
                maxLines: 5,
                controller: controller.captionController,
                style: AppFontStyle.styleW600(AppColor.black, 15),
                cursorColor: AppColor.primary,
                keyboardType: TextInputType.multiline,
                decoration: InputDecoration(
                  hintText: EnumLocal.txtSaySomethingToRecordThisMoment.name.tr,
                  hintStyle: AppFontStyle.styleW400(AppColor.secondary, 15),
                  border: InputBorder.none,
                ),
              ),
            ),
            GestureDetector(
              onTap: () => Get.to(MentionUserInVideoWidget()),
              child: Container(
                height: 55,
                padding: const EdgeInsets.symmetric(horizontal: 15),
                margin: const EdgeInsets.only(bottom: 10, top: 5),
                decoration: BoxDecoration(
                  color: AppColor.secondary.withValues(alpha: 0.05),
                  border: Border(
                    top: BorderSide(color: AppColor.secondary.withValues(alpha: 0.05)),
                    bottom: BorderSide(color: AppColor.secondary.withValues(alpha: 0.05)),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    RichText(
                      text: TextSpan(
                        text: "@  ",
                        style: AppFontStyle.styleW700(AppColor.black, 18),
                        children: [
                          TextSpan(
                            text: EnumLocal.txtMention.name.tr,
                            style: AppFontStyle.styleW500(AppColor.black, 16),
                          ),
                        ],
                      ),
                    ),
                    Image.asset(AppAssets.icArrowRight, width: 8, color: AppColor.secondary)
                  ],
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                15.width,
                RichText(
                  text: TextSpan(
                    text: "#  ",
                    style: AppFontStyle.styleW700(AppColor.black, 18),
                    children: [
                      TextSpan(
                        text: EnumLocal.txtRecommendedTopics.name.tr,
                        style: AppFontStyle.styleW500(AppColor.black, 16),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            5.height,
            GetBuilder<EditVideoController>(
              id: AppConstant.onToggleHashtag,
              builder: (logic) => controller.isLoadingHashtag
                  ? HashtagShimmerWidget()
                  : Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Wrap(
                        spacing: 15,
                        alignment: WrapAlignment.start,
                        children: [
                          for (int index = 0; index < controller.hashtags.length; index++)
                            GestureDetector(
                              onTap: () => controller.onToggleHashtag(index),
                              child: Chip(
                                padding: const EdgeInsets.only(top: 7, bottom: 7, right: 7, left: 5),
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
                                deleteIconColor: AppColor.black,
                                elevation: 0,
                                autofocus: false,
                                deleteIcon: Padding(
                                  padding: const EdgeInsets.only(right: 4),
                                  child: Image.asset(AppAssets.icClose, color: AppColor.lightGreyPurple),
                                ),
                                backgroundColor: controller.selectedHashtagIds.contains(controller.hashtags[index].sId) ? AppColor.primary : AppColor.lightGrayBg,
                                side: BorderSide(width: 0.8, color: AppColor.transparent),
                                label: Text(
                                  controller.hashtags[index].hashTag ?? "",
                                  style: AppFontStyle.styleW700(controller.selectedHashtagIds.contains(controller.hashtags[index].sId) ? AppColor.white : AppColor.lightGreyPurple, 13),
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
            ),
            15.height,
          ],
        ),
      ),
    );
  }
}
