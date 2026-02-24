import 'package:animated_flip_counter/animated_flip_counter.dart';
import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';
import 'package:readmore/readmore.dart';
import 'package:tingle/common/function/common_share.dart';
import 'package:tingle/common/widget/comment_bottom_sheet_widget.dart';
import 'package:tingle/common/widget/delete_dialog_widget.dart';
import 'package:tingle/common/widget/loading_widget.dart';
import 'package:tingle/page/other_user_profile_bottom_sheet/view/other_user_profile_bottom_sheet.dart';
import 'package:tingle/common/widget/preview_network_image_widget.dart';
import 'package:tingle/common/widget/report_bottom_sheet_widget.dart';
import 'package:tingle/common/widget/more_option_bottom_sheet.dart';
import 'package:tingle/page/feed_page/widget/feed_app_bar_widget.dart';
import 'package:tingle/page/feed_video_page/model/fetch_video_model.dart';
import 'package:tingle/routes/app_routes.dart';
import 'package:tingle/utils/api_params.dart';
import 'package:tingle/utils/assets.dart';
import 'package:tingle/utils/color.dart';
import 'package:tingle/utils/database.dart';
import 'package:tingle/utils/enums.dart';
import 'package:tingle/utils/font_style.dart';
import 'package:tingle/utils/utils.dart';
import 'package:vibration/vibration.dart';
import 'package:video_player/video_player.dart';

class FeedVideoItemWidget extends StatefulWidget {
  const FeedVideoItemWidget({
    super.key,
    required this.index,
    required this.currentIndex,
    required this.videoData,
    required this.isInsertBottomBarSpace,
  });

  final int index;
  final int currentIndex;
  final bool isInsertBottomBarSpace;
  final VideoData videoData;

  @override
  State<FeedVideoItemWidget> createState() => _FeedVideoItemWidgetState();
}

class _FeedVideoItemWidgetState extends State<FeedVideoItemWidget> with SingleTickerProviderStateMixin {
  ChewieController? chewieController;
  VideoPlayerController? videoPlayerController;

  RxBool isBuffering = false.obs;
  RxBool isVideoLoading = true.obs;

  RxBool isLike = false.obs;
  RxBool isFollow = false.obs;

  RxInt likeCount = 0.obs;
  RxInt commentCount = 0.obs;
  RxInt shareCount = 0.obs;

  RxBool isPlaying = false.obs;
  RxBool isShowIcon = false.obs;

  Animation<double>? animation;
  AnimationController? animationController;
  RxBool toggleLikeIconAnimation = false.obs;

  RxBool isReadMore = false.obs;

  @override
  void initState() {
    Utils.isCurrentlyVideoPage.value = true;

    isLike.value = widget.videoData.isLike ?? false;
    isFollow.value = widget.videoData.isFollow ?? false;
    likeCount.value = widget.videoData.totalLikes ?? 0;
    commentCount.value = widget.videoData.totalComments ?? 0;
    shareCount.value = widget.videoData.shareCount ?? 0;

    onInitAnimation();
    initializeVideoPlayer();
    super.initState();
  }

  @override
  void dispose() {
    animationController?.dispose();
    onDisposeVideoPlayer();
    super.dispose();
  }

  void onInitAnimation() {
    animationController = AnimationController(
      duration: const Duration(seconds: 4),
      vsync: this,
    )..repeat();
    if (animationController != null) {
      animation = Tween(begin: 0.0, end: 1.0).animate(animationController!);
    }
  }

  void onToggleLike() async {
    isLike.value ? likeCount-- : likeCount++;
    isLike.value = !isLike.value;
    Vibration.vibrate(duration: 50, amplitude: 128);
    onToggleLikeIcon();
  }

  void onToggleFollow() async {
    if (widget.videoData.userId != Database.loginUserId) {
      isFollow.value = !isFollow.value;
    }
  }

  void onToggleLikeIcon() async {
    toggleLikeIconAnimation.value = true;
    await 500.milliseconds.delay();
    toggleLikeIconAnimation.value = false;
  }

  void onClickComment() async {
    Utils.isCurrentlyVideoPage.value = false;
    commentCount.value = await CommentBottomSheetWidget.onShow(
      context: context,
      type: ApiParams.video,
      id: widget.videoData.id ?? "",
      commentCount: commentCount.value,
    );
  }

  void onClickShare() async {
    Utils.isCurrentlyVideoPage.value = false;
    await CommonShare.onShare(id: widget.videoData.id ?? "", title: widget.videoData.name ?? "", filePath: widget.videoData.videoUrl ?? "");

    shareCount++;
  }

  void onClickMore() async {
    Utils.isCurrentlyVideoPage.value = false;

    widget.videoData.userId == Database.loginUserId
        ? MoreOptionBottomSheet.show(
            context: context,
            reportCallBack: () {
              Get.back();
              ReportBottomSheetWidget.onShow(context: context, id: widget.videoData.id ?? "", type: ApiParams.video);
            },
            deleteCallBack: () {
              Get.back();

              DeleteDialogWidget.onShow(
                height: 435,
                title: EnumLocal.txtDeleteVideo.name.tr,
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
                AppRoutes.editVideoPage,
                arguments: {
                  ApiParams.videoId: widget.videoData.id ?? "",
                  ApiParams.video: widget.videoData.videoUrl ?? "",
                  ApiParams.image: widget.videoData.videoImage ?? "",
                  ApiParams.time: widget.videoData.videoTime ?? 0,
                  ApiParams.caption: widget.videoData.caption ?? "",
                  ApiParams.hashTagId: widget.videoData.hashTagId ?? "",
                },
              )?.then(
                (value) => Utils.onChangeStatusBar(brightness: Brightness.light),
              );
            },
          )
        : ReportBottomSheetWidget.onShow(
            context: context,
            id: widget.videoData.id ?? "",
            type: ApiParams.video,
          );
  }

  Future<void> initializeVideoPlayer() async {
    try {
      String videoPath = (widget.videoData.videoUrl ?? "");

      // videoPlayerController = VideoPlayerController.networkUrl(Uri.parse("https://codderlab.blr1.digitaloceanspaces.com/loopbox/Lag%20Ja%20Gale%20Episode%201%2018%20Web%20Series%20ULLU.mp4"));
      videoPlayerController = VideoPlayerController.networkUrl(Uri.parse(videoPath));

      await videoPlayerController?.initialize();

      if (videoPlayerController != null && (videoPlayerController?.value.isInitialized ?? false)) {
        chewieController = ChewieController(
          videoPlayerController: videoPlayerController!,
          looping: true,
          allowedScreenSleep: false,
          allowMuting: false,
          showControlsOnInitialize: false,
          showControls: false,
          maxScale: 1,
        );

        if (chewieController != null) {
          isVideoLoading.value = false;
          (widget.index == widget.currentIndex && Utils.isCurrentlyVideoPage.value) ? onPlayVideo() : null; // Use => First Time Video Playing...
        } else {
          isVideoLoading.value = true;
        }

        videoPlayerController?.addListener(
          () {
            // Use => If Video Buffering then show loading....
            (videoPlayerController?.value.isBuffering ?? false) ? isBuffering.value = true : isBuffering.value = false;

            // if (  Utils. isCurrentlyVideoPage.value == true || Get.currentRoute == AppRoutes.bottomBarPage || Get.currentRoute == AppRoutes.previewUserProfilePage) {
            //   // onPlayVideo();
            // } else {
            // }

            if (Utils.isCurrentlyVideoPage.value == false) {
              onStopVideo(); // Use => On Change Routes...
            }
          },
        );
      }

      Utils.showLog(">>>> Reels Video Initialization Success => ${widget.index}");
    } catch (e) {
      onDisposeVideoPlayer();
      Utils.showLog("Reels Video Initialization Failed !!! ${widget.index} => $e");
    }
  }

  void onStopVideo() {
    isPlaying.value = false;
    videoPlayerController?.pause();
  }

  void onPlayVideo() {
    isPlaying.value = true;
    videoPlayerController?.play();
  }

  void onClickProfile() {
    Utils.isCurrentlyVideoPage.value = false;
  }

  void onClickVideo() async {
    if (isVideoLoading.value == false) {
      videoPlayerController!.value.isPlaying ? onStopVideo() : onPlayVideo();
      isShowIcon.value = true;
      await 2.seconds.delay();
      isShowIcon.value = false;
    }
    if (Utils.isCurrentlyVideoPage.value == false) {
      Utils.isCurrentlyVideoPage.value = true; // Use => On Back Reels Page...
    }
  }

  void onClickPlayPause() async {
    videoPlayerController!.value.isPlaying ? onStopVideo() : onPlayVideo();
    if (Utils.isCurrentlyVideoPage.value == false) {
      Utils.isCurrentlyVideoPage.value = true; // Use => On Back Reels Page...
    }
  }

  void onClickMusic() async {
    // Get.toNamed(
    //   AppRoutes.audioWiseVideosPage,
    //   arguments: {ApiParams.songId: widget.videoData.songId ?? ""},
    // );
  }

  void onDisposeVideoPlayer() {
    try {
      onStopVideo();
      videoPlayerController?.dispose();
      chewieController?.dispose();
      chewieController = null;
      videoPlayerController = null;
      isVideoLoading.value = true;
    } catch (e) {
      Utils.showLog(">>>> On Dispose VideoPlayer Error => $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.index == widget.currentIndex) {
      // Use => Play Current Video On Scrolling...
      isReadMore.value = false;
      (isVideoLoading.value == false && Utils.isCurrentlyVideoPage.value) ? onPlayVideo() : null;
    } else {
      // Restart Previous Video On Scrolling...
      isVideoLoading.value == false ? videoPlayerController?.seekTo(Duration.zero) : null;
      onStopVideo(); // Stop Previous Video On Scrolling...
    }

    return Container(
      height: Get.height,
      width: Get.width,
      color: AppColor.black,
      child: Stack(
        children: [
          Container(
            height: Get.height,
            width: Get.width,
            color: AppColor.transparent,
            child: Obx(
              () => isVideoLoading.value
                  ? Align(alignment: Alignment.bottomCenter, child: LinearProgressIndicator(color: AppColor.primary))
                  : GestureDetector(
                      onTap: onClickVideo,
                      child: SizedBox.expand(
                        child: FittedBox(
                          fit: BoxFit.cover,
                          child: SizedBox(
                            width: videoPlayerController?.value.size.width ?? 0,
                            height: videoPlayerController?.value.size.height ?? 0,
                            child: Chewie(controller: chewieController!),
                          ),
                        ),
                      ),
                    ),
            ),
          ),
          (widget.videoData.isBanned ?? false)
              ? Container(
                  color: AppColor.black,
                  height: Get.height,
                  width: Get.width,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      SizedBox(
                        height: Get.height,
                        width: Get.width,
                        child: PreviewPostImageWidget(
                          isBanned: true,
                          image: widget.videoData.videoImage,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Image.asset(
                        AppAssets.icNone,
                        height: 150,
                        width: 150,
                        color: AppColor.red,
                      ),
                    ],
                  ),
                )
              : Obx(
                  () => isShowIcon.value
                      ? Align(
                          alignment: Alignment.center,
                          child: GestureDetector(
                            onTap: onClickPlayPause,
                            child: Container(
                              height: 70,
                              width: 70,
                              padding: EdgeInsets.only(left: isPlaying.value ? 0 : 3),
                              decoration: BoxDecoration(color: AppColor.black.withValues(alpha: 0.2), shape: BoxShape.circle),
                              child: Center(
                                child: Image.asset(
                                  isPlaying.value ? AppAssets.icPause : AppAssets.icPlay,
                                  width: 26,
                                  height: 26,
                                  color: AppColor.white,
                                ),
                              ),
                            ),
                          ),
                        )
                      : const Offstage(),
                ),
          Positioned(
            top: 0,
            child: Container(
              height: Get.height / 4,
              width: Get.width,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [AppColor.transparent, AppColor.black.withValues(alpha: 0.8)],
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            child: Container(
              height: Get.height / 2.5,
              width: Get.width,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [AppColor.transparent, AppColor.black.withValues(alpha: 0.8)],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
            ),
          ),
          Positioned(
            right: 15,
            child: Container(
              padding: EdgeInsets.only(top: 30, bottom: widget.isInsertBottomBarSpace ? 65 : 40),
              height: Get.height,
              child: Column(
                children: [
                  const Spacer(),
                  Obx(
                    () => SizedBox(
                      height: 40,
                      width: 40,
                      child: Center(
                        child: AnimatedContainer(
                          duration: Duration(milliseconds: 300),
                          height: toggleLikeIconAnimation.value ? 15 : 50,
                          width: toggleLikeIconAnimation.value ? 15 : 50,
                          alignment: Alignment.center,
                          child: IconButtonWidget(
                            icon: AppAssets.icLikeFill,
                            callback: onToggleLike,
                            iconSize: 32,
                            iconColor: isLike.value ? AppColor.red : AppColor.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Obx(
                    () => AnimatedFlipCounter(
                      duration: Duration(milliseconds: 500),
                      value: likeCount.value,
                      textStyle: AppFontStyle.styleW700(AppColor.white, 14),
                    ),
                  ),
                  12.height,
                  IconButtonWidget(
                    icon: AppAssets.icCommentFill,
                    callback: onClickComment,
                    iconSize: 30,
                    iconColor: AppColor.white,
                  ),
                  Obx(
                    () => AnimatedFlipCounter(
                      duration: Duration(milliseconds: 500),
                      value: commentCount.value,
                      textStyle: AppFontStyle.styleW700(AppColor.white, 14),
                    ),
                  ),
                  12.height,
                  IconButtonWidget(
                    icon: AppAssets.icShareArrow,
                    callback: onClickShare,
                    iconSize: 30,
                    iconColor: AppColor.white,
                  ),
                  Obx(
                    () => AnimatedFlipCounter(
                      duration: Duration(milliseconds: 500),
                      value: shareCount.value,
                      textStyle: AppFontStyle.styleW700(AppColor.white, 14),
                    ),
                  ),
                  12.height,
                  IconButtonWidget(
                    icon: AppAssets.icCircleVert,
                    callback: onClickMore,
                    iconSize: 30,
                    iconColor: AppColor.white,
                  ),
                  20.height,
                  GestureDetector(
                    onTap: onClickMusic,
                    child: Container(
                        color: AppColor.transparent,
                        height: 50,
                        width: 50,
                        child: animation != null
                            ? Stack(
                                alignment: Alignment.center,
                                clipBehavior: Clip.none,
                                children: [
                                  RotationTransition(turns: animation!, child: Image.asset(AppAssets.icMusicDish)),
                                  RotationTransition(
                                    turns: animation!,
                                    child: Container(
                                      width: 30,
                                      clipBehavior: Clip.antiAlias,
                                      decoration: BoxDecoration(shape: BoxShape.circle),
                                      child: PreviewProfileImageWidget(),
                                    ),
                                  ),
                                  Positioned(
                                    right: 4,
                                    bottom: -4,
                                    child: Image.asset(AppAssets.icMusic, width: 20),
                                  ),
                                ],
                              )
                            : Offstage()),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            left: 15,
            bottom: widget.isInsertBottomBarSpace ? 65 : 40,
            child: SizedBox(
              height: 400,
              width: Get.width / 1.5,
              child: Align(
                alignment: Alignment.bottomLeft,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      GestureDetector(
                        onTap: () {
                          OtherUserProfileBottomSheet.show(
                            context: context,
                            userId: widget.videoData.userId ?? "",
                          );
                        },
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              height: 48,
                              width: 48,
                              decoration: BoxDecoration(shape: BoxShape.circle, border: Border.all(color: AppColor.white)),
                              child: Container(
                                height: 48,
                                width: 48,
                                clipBehavior: Clip.antiAlias,
                                decoration: const BoxDecoration(shape: BoxShape.circle),
                                child: PreviewProfileImageWidget(
                                  image: widget.videoData.userImage,
                                  isBanned: widget.videoData.isProfilePicBanned,
                                ),
                              ),
                            ),
                            10.width,
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  width: Get.width / 2,
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: [
                                            Flexible(
                                              fit: FlexFit.loose,
                                              child: Text(
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                widget.videoData.name?.trim() ?? "",
                                                style: AppFontStyle.styleW700(AppColor.white, 14),
                                              ),
                                            ),
                                            Visibility(
                                              visible: widget.videoData.isVerified ?? false,
                                              child: Padding(
                                                padding: const EdgeInsets.only(left: 3),
                                                child: Image.asset(AppAssets.icAuthoriseIcon, width: 15),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      10.width,
                                      Visibility(
                                        visible: Database.loginUserId != widget.videoData.userId,
                                        child: Obx(
                                          () => GestureDetector(
                                            onTap: onToggleFollow,
                                            child: SizedBox(
                                              width: 100,
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.start,
                                                children: [
                                                  Container(
                                                    height: 28,
                                                    padding: EdgeInsets.symmetric(horizontal: 10),
                                                    decoration: BoxDecoration(
                                                      color: isFollow.value ? AppColor.transparent : AppColor.primary,
                                                      border: isFollow.value ? Border.all(color: AppColor.white) : null,
                                                      borderRadius: BorderRadius.circular(100),
                                                    ),
                                                    child: Row(
                                                      children: [
                                                        Image.asset(isFollow.value ? AppAssets.icFollowing : AppAssets.icFollow, width: 18, color: AppColor.white),
                                                        3.width,
                                                        Text(
                                                          isFollow.value ? EnumLocal.txtFollowing.name.tr : EnumLocal.txtFollow.name.tr,
                                                          style: AppFontStyle.styleW600(AppColor.white, 11.5),
                                                        ),
                                                      ],
                                                    ),
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
                                SizedBox(
                                  width: Get.width / 2,
                                  child: Text(
                                    widget.videoData.userName?.trim() ?? "",
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: AppFontStyle.styleW500(AppColor.white, 11),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      10.height,
                      Visibility(
                        visible: widget.videoData.caption?.trim().isNotEmpty ?? false,
                        child: ReadMoreText(
                          widget.videoData.caption?.trim() ?? "",
                          trimMode: TrimMode.Line,
                          trimLines: 2,
                          style: AppFontStyle.styleW500(AppColor.white, 12),
                          colorClickableText: AppColor.primary,
                          trimCollapsedText: ' Show more',
                          trimExpandedText: ' Show less',
                          moreStyle: AppFontStyle.styleW500(AppColor.white, 12.5),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).viewPadding.top + 10,
            left: 0,
            child: Visibility(
              visible: !widget.isInsertBottomBarSpace,
              child: SizedBox(
                width: Get.width,
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () => Get.back(),
                      child: Container(
                        height: 50,
                        width: 50,
                        decoration: const BoxDecoration(
                          color: AppColor.transparent,
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: Image.asset(AppAssets.icArrowLeft, color: AppColor.white, width: 10),
                        ),
                      ),
                    ),
                    Spacer(),
                    GestureDetector(
                      onTap: () {
                        Utils.isCurrentlyVideoPage.value = false;
                        onClickVideoUpload();
                      },
                      child: Container(
                        height: 50,
                        width: 50,
                        margin: EdgeInsets.only(right: 15),
                        decoration: const BoxDecoration(
                          color: AppColor.transparent,
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: Image.asset(AppAssets.icBoxPlus, color: AppColor.white, width: 26),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
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
    required this.callback,
    required this.iconSize,
    required this.iconColor,
  });

  final String icon;
  final double iconSize;
  final Color iconColor;
  final Callback callback;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: callback,
      child: Container(
        height: 40,
        width: 40,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: AppColor.transparent,
        ),
        child: Center(
          child: Image.asset(icon, height: iconSize, width: iconSize, color: iconColor),
        ),
      ),
    );
  }
}
