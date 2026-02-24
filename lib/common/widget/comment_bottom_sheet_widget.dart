import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';
import 'package:readmore/readmore.dart';
import 'package:tingle/common/model/fetch_comment_model.dart';
import 'package:tingle/common/shimmer/comment_shimmer_widget.dart';
import 'package:tingle/common/widget/no_data_found_widget.dart';
import 'package:tingle/common/widget/preview_network_image_widget.dart';

import 'package:tingle/page/login_page/api/fetch_login_user_profile_api.dart';
import 'package:tingle/utils/assets.dart';
import 'package:tingle/utils/color.dart';
import 'package:tingle/utils/enums.dart';
import 'package:tingle/utils/font_style.dart';
import 'package:tingle/utils/utils.dart';

class CommentBottomSheetWidget {
  static RxBool isLoading = false.obs;
  static FetchCommentModel? fetchCommentModel;
  static RxList<Comments> comments = <Comments>[].obs;
  static TextEditingController commentController = TextEditingController();
  static ScrollController scrollController = ScrollController();

  static Future<void> onGetComments({
    required String id,
    required String type, // [POST/VIDEO]
  }) async {
    isLoading.value = true;

    comments.value = fetchCommentModel?.comments ?? [];
    isLoading.value = false;
  }

  static Future<void> onSendComment({
    required String id,
    required String type,
  }) async {
    if (commentController.text.trim().isNotEmpty) {
      final commentText = commentController.text;

      comments.add(
        Comments(
          name: FetchLoginUserProfileApi.fetchLoginUserProfileModel?.user?.name ?? "",
          userImage: FetchLoginUserProfileApi.fetchLoginUserProfileModel?.user?.image ?? "",
          isProfilePicBanned: FetchLoginUserProfileApi.fetchLoginUserProfileModel?.user?.isProfilePicBanned ?? false,
          commentText: commentText,
          time: "Now",
        ),
      );

      commentController.clear();

      if (comments.length > 4) {
        scrollController.animateTo(
          scrollController.position.maxScrollExtent,
          duration: Duration(milliseconds: 500),
          curve: Curves.fastOutSlowIn,
        );
        await 500.milliseconds.delay();
        scrollController.animateTo(
          scrollController.position.maxScrollExtent,
          duration: Duration(milliseconds: 500),
          curve: Curves.fastOutSlowIn,
        );
      }
    }
  }

  static Future<int> onShow({
    required BuildContext context,
    required String type,
    required String id,
    required int commentCount,
  }) async {
    onGetComments(id: id, type: type);

    await showModalBottomSheet(
      isScrollControlled: true,
      scrollControlDisabledMaxHeightRatio: Get.height,
      context: context,
      backgroundColor: AppColor.transparent,
      builder: (context) => Padding(
        padding: MediaQuery.of(context).viewInsets,
        child: Container(
          height: 500,
          width: Get.width,
          clipBehavior: Clip.antiAlias,
          decoration: const BoxDecoration(
            color: AppColor.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(40),
              topRight: Radius.circular(40),
            ),
          ),
          child: Column(
            children: [
              Container(
                height: 65,
                color: AppColor.secondary.withValues(alpha: 0.08),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    50.width,
                    Expanded(
                      child: Center(
                        child: Text(
                          EnumLocal.txtComment.name.tr,
                          style: AppFontStyle.styleW700(AppColor.greyBlue, 18),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () => Get.back(),
                      child: Container(
                        height: 30,
                        width: 30,
                        margin: const EdgeInsets.only(right: 20),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColor.secondary.withValues(alpha: 0.6),
                        ),
                        child: Image.asset(width: 18, AppAssets.icClose, color: AppColor.white),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Obx(
                  () => isLoading.value
                      ? CommentShimmerWidget()
                      : comments.isEmpty
                          ? NoDataFoundWidget()
                          : SingleChildScrollView(
                              controller: scrollController,
                              child: ListView.builder(
                                itemCount: comments.length,
                                shrinkWrap: true,
                                padding: const EdgeInsets.only(top: 15, left: 15, right: 15),
                                physics: NeverScrollableScrollPhysics(),
                                itemBuilder: (context, index) => Padding(
                                  padding: const EdgeInsets.only(bottom: 20),
                                  child: Column(
                                    children: [
                                      Row(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          Container(
                                            height: 45,
                                            width: 45,
                                            padding: EdgeInsets.all(1),
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              border: Border.all(color: AppColor.secondary),
                                            ),
                                            child: Container(
                                              height: 45,
                                              width: 45,
                                              clipBehavior: Clip.antiAlias,
                                              decoration: BoxDecoration(shape: BoxShape.circle),
                                              child: PreviewProfileImageWidget(
                                                image: comments[index].userImage,
                                                isBanned: comments[index].isProfilePicBanned,
                                              ),
                                            ),
                                          ),
                                          12.width,
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                Row(
                                                  children: [
                                                    Expanded(
                                                      child: Text(
                                                        (comments[index].name ?? ""),
                                                        maxLines: 1,
                                                        overflow: TextOverflow.ellipsis,
                                                        style: AppFontStyle.styleW600(AppColor.black, 15),
                                                      ),
                                                    ),
                                                    // Container(
                                                    //   height: 25,
                                                    //   width: 25,
                                                    //   alignment: Alignment.center,
                                                    //   decoration: BoxDecoration(
                                                    //     color: AppColor.transparent,
                                                    //     shape: BoxShape.circle,
                                                    //   ),
                                                    //   child: Image.asset(
                                                    //     AppAssets.icLikeBorder,
                                                    //     width: 20,
                                                    //     color: AppColor.secondary,
                                                    //   ),
                                                    // ),
                                                    // 5.width,
                                                    // Container(
                                                    //   height: 25,
                                                    //   width: 25,
                                                    //   alignment: Alignment.center,
                                                    //   decoration: BoxDecoration(
                                                    //     color: AppColor.transparent,
                                                    //     shape: BoxShape.circle,
                                                    //   ),
                                                    //   child: Image.asset(
                                                    //     AppAssets.icCircleVert,
                                                    //     width: 20,
                                                    //     color: AppColor.secondary,
                                                    //   ),
                                                    // ),
                                                  ],
                                                ),
                                                Text(
                                                  (comments[index].time ?? ""),
                                                  maxLines: 1,
                                                  overflow: TextOverflow.ellipsis,
                                                  style: AppFontStyle.styleW600(AppColor.secondary, 10),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          57.width,
                                          Expanded(
                                            child: ReadMoreText(
                                              (comments[index].commentText ?? ""),
                                              trimMode: TrimMode.Line,
                                              trimLines: 3,
                                              style: AppFontStyle.styleW500(AppColor.black, 14),
                                              colorClickableText: AppColor.primary,
                                              trimCollapsedText: 'Show more',
                                              trimExpandedText: ' Show less',
                                              moreStyle: AppFontStyle.styleW500(AppColor.primary, 14),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                ),
              ),
              Obx(
                () => isLoading.value
                    ? Offstage()
                    : CommentTextFieldUi(
                        controller: commentController,
                        onSend: () => onSendComment(id: id, type: type),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
    return comments.isEmpty ? commentCount : comments.length;
  }
}

class CommentTextFieldUi extends StatelessWidget {
  const CommentTextFieldUi({
    super.key,
    required this.onSend,
    required this.controller,
  });

  final Callback onSend;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      width: Get.width,
      padding: EdgeInsets.symmetric(vertical: 15),
      decoration: BoxDecoration(
        color: AppColor.white,
        boxShadow: [
          BoxShadow(
            color: AppColor.secondary.withValues(alpha: 0.2),
            blurRadius: 4,
            offset: Offset(-2, 0),
          )
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: Container(
              height: 50,
              width: Get.width,
              alignment: Alignment.center,
              padding: const EdgeInsets.only(left: 20, right: 15),
              margin: EdgeInsets.symmetric(horizontal: 15),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: AppColor.secondary.withValues(alpha: 0.1),
              ),
              child: TextFormField(
                controller: controller,
                cursorColor: AppColor.secondary,
                maxLines: 1,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: EnumLocal.txtSaySomething.name.tr,
                  hintStyle: AppFontStyle.styleW400(AppColor.secondary, 14.5),
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: onSend,
            child: Container(
              height: 50,
              width: 50,
              padding: EdgeInsets.only(bottom: 3),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: AppColor.primaryGradient,
              ),
              child: Image.asset(width: 30, AppAssets.icSend),
            ),
          ),
          15.width,
        ],
      ),
    );
  }
}
