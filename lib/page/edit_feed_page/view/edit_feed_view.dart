import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tingle/common/widget/preview_network_image_widget.dart';
import 'package:tingle/page/edit_feed_page/controller/edit_feed_controller.dart';
import 'package:tingle/page/edit_feed_page/widget/edit_feed_app_bar_widget.dart';
import 'package:tingle/common/shimmer/hashtag_shimmer_widget.dart';
import 'package:tingle/page/upload_feed_page/widget/mention_user_in_post_widget.dart';
import 'package:tingle/utils/assets.dart';
import 'package:tingle/utils/color.dart';
import 'package:tingle/utils/constant.dart';
import 'package:tingle/utils/enums.dart';
import 'package:tingle/utils/font_style.dart';
import 'package:tingle/utils/utils.dart';

class EditFeedView extends GetView<EditFeedController> {
  const EditFeedView({super.key});

  @override
  Widget build(BuildContext context) {
    Utils.onChangeStatusBar(brightness: Brightness.dark);

    return Scaffold(
      backgroundColor: AppColor.white,
      appBar: EditFeedAppBarWidget.onShow(context),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 180,
              width: Get.width,
              color: AppColor.transparent,
              child: GetBuilder<EditFeedController>(
                id: AppConstant.onChangeImages,
                builder: (logic) => ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: logic.postImages.length,
                  padding: EdgeInsets.only(left: 15, top: 15, bottom: 15),
                  itemBuilder: (context, index) => Padding(
                    padding: EdgeInsets.only(right: 15),
                    child: Container(
                      width: 135,
                      height: 180,
                      clipBehavior: Clip.antiAlias,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: PreviewPostImageWidget(
                        image: logic.postImages[index].url,
                        isBanned: logic.postImages[index].isBanned,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
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
              onTap: () => Get.to(MentionUserInPostWidget()),
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
            GetBuilder<EditFeedController>(
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
          ],
        ),
      ),
    );
  }
}
