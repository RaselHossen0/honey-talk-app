import 'dart:developer';

import 'package:animated_flip_counter/animated_flip_counter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';
import 'package:readmore/readmore.dart';

import 'package:tingle/common/function/common_share.dart';
import 'package:tingle/common/function/country_flag_icon.dart';
import 'package:tingle/common/widget/comment_bottom_sheet_widget.dart';
import 'package:tingle/common/widget/delete_dialog_widget.dart';
import 'package:tingle/common/widget/loading_widget.dart';
import 'package:tingle/common/widget/report_bottom_sheet_widget.dart';
import 'package:tingle/common/widget/more_option_bottom_sheet.dart';
import 'package:tingle/custom/function/custom_format_number.dart';
import 'package:tingle/common/widget/preview_network_image_widget.dart';
import 'package:tingle/page/feed_page/model/fetch_post_model.dart';
import 'package:tingle/routes/app_routes.dart';
import 'package:tingle/utils/api_params.dart';
import 'package:tingle/utils/assets.dart';
import 'package:tingle/utils/color.dart';
import 'package:tingle/utils/database.dart';
import 'package:tingle/utils/enums.dart';
import 'package:tingle/utils/font_style.dart';
import 'package:tingle/utils/utils.dart';

import 'preview_profile_moment_post_widget.dart';

class ProfileMomentItemWidget extends StatefulWidget {
  const ProfileMomentItemWidget({super.key, this.post});

  final Post? post;

  @override
  State<ProfileMomentItemWidget> createState() => _FeedItemWidgetState();
}

class _FeedItemWidgetState extends State<ProfileMomentItemWidget> {
  RxBool isLike = false.obs;
  RxBool isFollow = false.obs;
  RxInt likeCount = 0.obs;
  RxInt commentCount = 0.obs;
  RxInt shareCount = 0.obs;

  @override
  void initState() {
    isLike.value = widget.post?.isLike ?? false;
    isFollow.value = widget.post?.isFollow ?? false;
    likeCount.value = (widget.post?.totalLikes ?? 0).toInt();
    commentCount.value = (widget.post?.totalComments ?? 0).toInt();
    shareCount.value = (widget.post?.shareCount ?? 0).toInt();
    super.initState();
  }

  void onToggleLike() async {
    isLike.value ? likeCount-- : likeCount++;
    isLike.value = !isLike.value;
  }

  void onClickComment() async {
    commentCount.value = await CommentBottomSheetWidget.onShow(context: context, type: ApiParams.post, id: widget.post?.id ?? "", commentCount: commentCount.value);
  }

  void onClickShare() async {
    await CommonShare.onShare(id: widget.post?.id ?? "", title: widget.post?.name ?? "", filePath: widget.post?.postImage?[0].url ?? "");

    shareCount++;
  }

  void onClickProfile() {
    // OtherUserProfileBottomSheet.show(context: context, userId: widget.post?.userId ?? "");

    Utils.showLog("******* POST ID => ${widget.post?.id ?? ""}");
  }

  void onClickMore() {
    widget.post?.userId == Database.loginUserId
        ? MoreOptionBottomSheet.show(
            context: context,
            reportCallBack: () {
              Get.back();
              ReportBottomSheetWidget.onShow(
                context: context,
                id: widget.post?.id ?? "",
                type: ApiParams.post,
              );
            },
            deleteCallBack: () {
              Get.back();

              DeleteDialogWidget.onShow(
                height: 435,
                title: EnumLocal.txtDeletePost.name.tr,
                description: EnumLocal.txtDeletePostVideoContent.name.tr,
                callBack: () async {
                  Get.dialog(const LoadingWidget(), barrierDismissible: false); // Start Loading...

                  Get.back(); // Stop Loading...
                },
              );
            },
            editCallBack: () {
              Get.back();
              Get.toNamed(
                AppRoutes.editFeedPage,
                arguments: {
                  ApiParams.postId: widget.post?.postId ?? "",
                  ApiParams.postImage: widget.post?.postImage ?? "",
                  ApiParams.caption: widget.post?.caption ?? "",
                  ApiParams.hashTagId: widget.post?.hashTagId ?? "",
                },
              )?.then(
                (value) => Utils.onChangeStatusBar(brightness: Brightness.light),
              );
            },
          )
        : ReportBottomSheetWidget.onShow(
            context: context,
            id: widget.post?.id ?? "",
            type: ApiParams.post,
          );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width,
      clipBehavior: Clip.antiAlias,
      margin: const EdgeInsets.only(bottom: 15),
      decoration: BoxDecoration(
        color: AppColor.white,
        borderRadius: BorderRadius.circular(32),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: onClickProfile,
            child: Container(
              height: 70,
              width: Get.width,
              padding: const EdgeInsets.only(left: 15, right: 15, top: 10, bottom: 10),
              decoration: BoxDecoration(
                color: AppColor.colorBorder.withValues(alpha: 0.3),
                borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
              ),
              child: Row(
                children: [
                  Container(
                    height: 47,
                    width: 47,
                    padding: const EdgeInsets.all(2),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: AppColor.secondary),
                    ),
                    child: Container(
                      clipBehavior: Clip.antiAlias,
                      decoration: const BoxDecoration(shape: BoxShape.circle),
                      child: PreviewProfileImageWidget(
                        image: widget.post?.userImage,
                        isBanned: widget.post?.isProfilePicBanned,
                      ),
                    ),
                  ),
                  12.width,
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          children: [
                            Flexible(
                              fit: FlexFit.loose,
                              child: Text(
                                widget.post?.name ?? "",
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: AppFontStyle.styleW700(AppColor.black, 16),
                              ),
                            ),
                            Visibility(
                              visible: true,
                              child: Padding(
                                padding: const EdgeInsets.only(left: 5),
                                child: Text(
                                  CountryFlagIcon.onShow(widget.post?.countryFlagImage ?? ""),
                                  style: AppFontStyle.styleW700(AppColor.white, 16),
                                ),
                              ),
                            ),
                          ],
                        ),
                        3.height,
                        Expanded(
                          child: Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                                decoration: BoxDecoration(
                                  color: AppColor.purple,
                                  borderRadius: BorderRadius.circular(100),
                                ),
                                child: Row(
                                  children: [
                                    Image.asset(
                                      widget.post?.gender?.toLowerCase() == ApiParams.male ? AppAssets.icFemale : AppAssets.icFemale,
                                      width: 10,
                                    ),
                                    3.width,
                                    Text(
                                      (widget.post?.age ?? 0).toString(),
                                      style: AppFontStyle.styleW600(AppColor.white, 10),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: onClickMore,
                    child: Container(
                      height: 40,
                      width: 40,
                      alignment: Alignment.center,
                      decoration: const BoxDecoration(shape: BoxShape.circle),
                      child: Image.asset(
                        AppAssets.icVerticalVert,
                        width: 4,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          15.height,
          SizedBox(
            height: Get.width / 2,
            child: ListView.builder(
              itemCount: widget.post?.postImage?.length ?? 0,
              shrinkWrap: true,
              padding: EdgeInsets.only(left: 15),
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) => GestureDetector(
                onTap: () {
                  log("onTap => ${widget.post?.postImage?[index].url ?? ""}");
                  Get.to(FullScreenPostPreview(posts: widget.post?.postImage ?? [], initialIndex: index));
                },
                child: Container(
                  clipBehavior: Clip.antiAlias,
                  height: Get.width / 2,
                  width: Get.width / 2.4,
                  margin: EdgeInsets.only(right: 10),
                  decoration: BoxDecoration(color: AppColor.secondary.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(15)),
                  child: PreviewPostImageWidget(
                    isBanned: widget.post?.postImage?[index].isBanned ?? false,
                    image: widget.post?.postImage?[index].url ?? "",
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ),
          15.height,
          Visibility(
            visible: widget.post?.caption?.trim().isNotEmpty ?? false,
            child: Padding(
              padding: const EdgeInsets.only(left: 15, right: 15, bottom: 5),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: ReadMoreText(
                      widget.post?.caption ?? "",
                      trimMode: TrimMode.Line,
                      trimLines: 3,
                      style: AppFontStyle.styleW500(AppColor.greyBlue, 15),
                      colorClickableText: AppColor.primary,
                      trimCollapsedText: ' Show more',
                      trimExpandedText: ' Show less',
                      moreStyle: AppFontStyle.styleW500(AppColor.primary, 15),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Visibility(
            visible: widget.post?.hashTag?.isNotEmpty ?? false,
            child: Padding(
              padding: const EdgeInsets.only(left: 15, right: 15, bottom: 5),
              child: Column(
                children: [
                  8.height,
                  Wrap(
                    spacing: 8.0, // gap between adjacent chips
                    runSpacing: 4.0, // gap between lines
                    children: <Widget>[
                      for (int index = 0; index < (widget.post?.hashTag?.length ?? 0); index++)
                        Container(
                          padding: const EdgeInsets.only(left: 12, right: 12, top: 2, bottom: 2),
                          margin: EdgeInsets.only(bottom: 3),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(color: AppColor.secondary.withValues(alpha: 0.5), width: 1),
                          ),
                          child: Text.rich(
                            TextSpan(
                              children: [
                                TextSpan(
                                  text: widget.post?.hashTag?[index] ?? "",
                                  style: AppFontStyle.styleW500(AppColor.secondary, 12),
                                ),
                              ],
                            ),
                          ),
                        ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          10.height,
          Container(
            height: 60,
            color: AppColor.colorBorder.withValues(alpha: 0.3),
            width: Get.width,
            child: Row(
              children: [
                5.width,
                Obx(
                  () => IconButtonWidget(
                    icon: isLike.value ? AppAssets.icLikeFill : AppAssets.icLikeBorder,
                    count: likeCount.value,
                    iconSize: 25,
                    callback: onToggleLike,
                  ),
                ),
                Obx(
                  () => IconButtonWidget(
                    icon: AppAssets.icCommentBorder,
                    count: commentCount.value,
                    iconSize: 24,
                    callback: onClickComment,
                  ),
                ),
                Obx(
                  () => IconButtonWidget(
                    icon: AppAssets.icShareBorder,
                    count: shareCount.value,
                    iconSize: 22,
                    callback: onClickShare,
                  ),
                ),
                Spacer(),
                10.width,
                Text(
                  widget.post?.time ?? "",
                  style: AppFontStyle.styleW500(AppColor.secondary, 13),
                ),
                15.width,
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class IconButtonWidget extends StatelessWidget {
  const IconButtonWidget({
    super.key,
    required this.icon,
    required this.count,
    required this.iconSize,
    required this.callback,
  });

  final String icon;
  final int count;
  final double iconSize;
  final Callback callback;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: callback,
      child: Container(
        color: AppColor.transparent,
        height: 50,
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(icon, width: iconSize),
            8.width,
            (count < 1000)
                ? AnimatedFlipCounter(
                    duration: Duration(milliseconds: 500),
                    value: count, // pass in a value like 2014
                    textStyle: AppFontStyle.styleW600(AppColor.secondary, 15),
                  )
                : Text(
                    CustomFormatNumber.onConvert(count),
                    style: AppFontStyle.styleW600(AppColor.secondary, 15),
                  ),
          ],
        ),
      ),
    );
  }
}
