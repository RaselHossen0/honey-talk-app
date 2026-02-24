import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tingle/page/upload_feed_page/controller/upload_feed_controller.dart';
import 'package:tingle/common/shimmer/hashtag_shimmer_widget.dart';
import 'package:tingle/page/upload_feed_page/widget/upload_feed_app_bar_widget.dart';
import 'package:tingle/utils/assets.dart';
import 'package:tingle/utils/color.dart';
import 'package:tingle/utils/constant.dart';
import 'package:tingle/utils/enums.dart';
import 'package:tingle/utils/font_style.dart';
import 'package:tingle/utils/utils.dart';

class UploadFeedView extends GetView<UploadFeedController> {
  const UploadFeedView({super.key});

  @override
  Widget build(BuildContext context) {
    Utils.onChangeStatusBar(brightness: Brightness.dark);

    return Scaffold(
      backgroundColor: AppColor.white,
      appBar: UploadFeedAppBarWidget.onShow(context),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 180,
              width: Get.width,
              color: AppColor.transparent,
              child: GetBuilder<UploadFeedController>(
                id: AppConstant.onChangeImages,
                builder: (logic) => ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: logic.selectedImages.length < 5 ? (logic.selectedImages.length + 1) : logic.selectedImages.length,
                  padding: EdgeInsets.only(left: 15, top: 15, bottom: 15),
                  itemBuilder: (context, index) => Padding(
                    padding: EdgeInsets.only(right: 15),
                    child: (index == (logic.selectedImages.length) && logic.selectedImages.length < 5)
                        ? GestureDetector(
                            onTap: () => controller.onSelectNewImage(context),
                            child: Container(
                              width: 135,
                              decoration: BoxDecoration(
                                color: AppColor.secondary.withValues(alpha: 0.05),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Center(
                                child: Image.asset(
                                  AppAssets.icAdd,
                                  color: AppColor.secondary.withValues(alpha: 0.5),
                                  width: 35,
                                ),
                              ),
                            ),
                          )
                        : SizedBox(
                            width: 135,
                            child: Stack(
                              clipBehavior: Clip.none,
                              children: [
                                Container(
                                  height: 180,
                                  clipBehavior: Clip.antiAlias,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: AspectRatio(
                                    aspectRatio: 1,
                                    child: Image.file(File(controller.selectedImages[index]), fit: BoxFit.cover),
                                  ),
                                ),
                                Positioned(
                                  top: -8,
                                  right: -8,
                                  child: GestureDetector(
                                    onTap: () => logic.onCancelImage(index),
                                    child: Container(
                                      height: 50,
                                      width: 50,
                                      color: AppColor.transparent,
                                      alignment: Alignment.topRight,
                                      child: Container(
                                        height: 30,
                                        width: 30,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: AppColor.black,
                                          border: Border.all(color: AppColor.white, width: 2),
                                        ),
                                        child: Center(
                                          child: Image.asset(
                                            AppAssets.icClose,
                                            color: AppColor.white,
                                            width: 15,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
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
            GetBuilder<UploadFeedController>(
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
                                  style: AppFontStyle.styleW700(
                                      controller.selectedHashtagIds.contains(controller.hashtags[index].sId) ? AppColor.white : AppColor.lightGreyPurple, 13),
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
