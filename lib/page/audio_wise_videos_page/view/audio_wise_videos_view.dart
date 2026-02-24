import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tingle/common/widget/no_data_found_widget.dart';
import 'package:tingle/common/widget/preview_network_image_widget.dart';
import 'package:tingle/custom/function/custom_format_number.dart';
import 'package:tingle/page/audio_wise_videos_page/controller/audio_wise_videos_controller.dart';
import 'package:tingle/page/audio_wise_videos_page/shimmer/audio_wise_videos_shimmer_ui.dart';
import 'package:tingle/page/audio_wise_videos_page/widget/audio_wise_video_app_bar_widget.dart';
import 'package:tingle/utils/assets.dart';
import 'package:tingle/utils/color.dart';
import 'package:tingle/utils/constant.dart';
import 'package:tingle/utils/enums.dart';
import 'package:tingle/utils/font_style.dart';
import 'package:tingle/utils/utils.dart';

class AudioWiseVideosView extends GetView<AudioWiseVideosController> {
  const AudioWiseVideosView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AudioWiseVideoAppBarWidget.onShow(context),
      body: GetBuilder<AudioWiseVideosController>(
        id: "onGetVideos",
        builder: (controller) => controller.isLoading
            ? AudioWiseVideosShimmerUi()
            : Padding(
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: SingleChildScrollView(
                  controller: controller.scrollController,
                  child: Column(
                    children: [
                      15.height,
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: 90,
                            width: 90,
                            decoration: BoxDecoration(
                              color: AppColor.transparent,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                Image.asset(AppAssets.icImagePlaceHolder, width: 60),
                                Container(
                                    height: 90,
                                    width: 90,
                                    clipBehavior: Clip.antiAlias,
                                    decoration: BoxDecoration(
                                      color: AppColor.transparent,
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: PreviewPostImageWidget(image: controller.songImage)),
                              ],
                            ),
                          ),
                          15.width,
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  controller.songTitle,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: AppFontStyle.styleW700(AppColor.black, 17),
                                ),
                                2.height,
                                Text(
                                  controller.singerName,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: AppFontStyle.styleW600(AppColor.black, 16),
                                ),
                                4.height,
                                Text(
                                  "${controller.totalVideo} ${EnumLocal.txtVideos.name.tr}",
                                  style: AppFontStyle.styleW600(AppColor.grayText, 15),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      15.height,
                      GestureDetector(
                        onTap: controller.onUseAudio,
                        child: Container(
                          height: 45,
                          width: Get.width,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            gradient: AppColor.primaryGradient,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(
                            EnumLocal.txtUseAudio.name.tr,
                            style: AppFontStyle.styleW700(AppColor.white, 16),
                          ),
                        ),
                      ),
                      5.height,
                      GetBuilder<AudioWiseVideosController>(
                        id: "onChangeAudioEvent",
                        builder: (controller) => Row(
                          children: [
                            GestureDetector(
                              onTap: () {
                                if (controller.isPlaying) {
                                  controller.onPauseAudio();
                                } else {
                                  controller.onResumeAudio();
                                }
                              },
                              child: SizedBox(
                                width: 30,
                                child: Center(
                                  child: Image.asset(
                                    controller.isPlaying ? AppAssets.icPause : AppAssets.icPlay,
                                    width: controller.isPlaying ? 30 : 25,
                                    color: AppColor.grayText,
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: SliderTheme(
                                data: SliderTheme.of(context).copyWith(
                                  trackHeight: 6,
                                  trackShape: const RoundedRectSliderTrackShape(),
                                  thumbColor: AppColor.grayText,
                                  thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 9.0),
                                  overlayShape: const RoundSliderOverlayShape(overlayRadius: 24.0),
                                ),
                                child: Slider(
                                  min: 0,
                                  max: controller.songDuration,
                                  value: controller.songCurrentPosition,
                                  activeColor: AppColor.grayText,
                                  onChanged: controller.onSkipAudio,
                                ),
                              ),
                            ),
                            Text(
                              controller.onConvertTime(controller.songCurrentPosition),
                              style: AppFontStyle.styleW500(AppColor.grayText, 12),
                            ),
                          ],
                        ),
                      ),
                      8.height,
                      controller.videos.isEmpty
                          ? Padding(
                              padding: const EdgeInsets.symmetric(vertical: 50),
                              child: NoDataFoundWidget(),
                            )
                          : GridView.builder(
                              shrinkWrap: true,
                              itemCount: controller.videos.length,
                              padding: EdgeInsets.zero,
                              physics: const NeverScrollableScrollPhysics(),
                              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 3,
                                crossAxisSpacing: 10,
                                mainAxisSpacing: 10,
                                childAspectRatio: 0.75,
                              ),
                              itemBuilder: (context, index) {
                                final indexData = controller.videos[index];
                                return Stack(
                                  alignment: Alignment.bottomRight,
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        if (controller.videos[index].isBanned == false) {
                                          controller.onClickReels(index);
                                        }
                                      },
                                      child: Container(
                                        clipBehavior: Clip.antiAlias,
                                        decoration: BoxDecoration(color: AppColor.grayText.withAlpha(25), borderRadius: BorderRadius.circular(14)),
                                        child: AspectRatio(aspectRatio: 0.75, child: PreviewPostImageWidget(image: indexData.videoImage)),
                                      ),
                                    ),
                                    Visibility(
                                      visible: (indexData.isBanned ?? false),
                                      child: Container(
                                        height: Get.height,
                                        alignment: Alignment.topRight,
                                        decoration: BoxDecoration(
                                          color: AppColor.black.withAlpha(166),
                                          borderRadius: BorderRadius.circular(14),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Image.asset(AppAssets.icNone, color: AppColor.red, width: 20),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      height: 35,
                                      decoration: BoxDecoration(
                                        borderRadius: const BorderRadius.only(
                                          bottomLeft: Radius.circular(14),
                                          bottomRight: Radius.circular(14),
                                        ),
                                        gradient: LinearGradient(
                                          colors: [AppColor.transparent, AppColor.black.withAlpha(153)],
                                          begin: Alignment.topCenter,
                                          end: Alignment.bottomCenter,
                                        ),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 10),
                                        child: Row(
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: [
                                            Image.asset(
                                              AppAssets.icLikeFill,
                                              width: 18,
                                              color: (indexData.isLike ?? false) ? AppColor.red : AppColor.white,
                                            ),
                                            Text(
                                              " ${CustomFormatNumber.onConvert(indexData.totalLikes ?? 0)}",
                                              style: AppFontStyle.styleW600(AppColor.white, 11),
                                            ),
                                            8.width,
                                            Image.asset(AppAssets.icCommentFill, width: 18),
                                            Text(
                                              " ${CustomFormatNumber.onConvert(indexData.totalComments ?? 0)}",
                                              style: AppFontStyle.styleW600(AppColor.white, 11),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                );
                              },
                            ),
                      15.height,
                    ],
                  ),
                ),
              ),
      ),
      bottomNavigationBar: GetBuilder<AudioWiseVideosController>(
        id: AppConstant.onPagination,
        builder: (controller) => Visibility(
          visible: controller.isPaginationLoading,
          child: LinearProgressIndicator(color: AppColor.primary),
        ),
      ),
    );
  }
}
