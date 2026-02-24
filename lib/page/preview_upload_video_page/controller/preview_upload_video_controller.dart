import 'dart:io';

import 'package:chewie/chewie.dart';
import 'package:get/get.dart';
import 'package:tingle/routes/app_routes.dart';
import 'package:tingle/utils/api_params.dart';
import 'package:tingle/utils/constant.dart';
import 'package:tingle/utils/utils.dart';
import 'package:video_player/video_player.dart';

class PreviewUploadVideoController extends GetxController {
  ChewieController? chewieController;
  VideoPlayerController? videoPlayerController;

  bool isPlaying = true;
  bool isVideoLoading = true;
  bool isShowPlayPauseIcon = false;

  int videoTime = 0;
  String videoUrl = "";
  String videoThumbnail = "";
  String songId = "";

  @override
  void onInit() {
    final arguments = Get.arguments;
    Utils.showLog("Selected Video => $arguments");

    videoUrl = arguments[ApiParams.video];
    videoThumbnail = arguments[ApiParams.image];
    videoTime = arguments[ApiParams.time];
    songId = arguments[ApiParams.songId];

    initializeVideoPlayer(videoUrl);
    super.onInit();
  }

  Future<void> initializeVideoPlayer(String videoPath) async {
    try {
      videoPlayerController = VideoPlayerController.file(File(videoPath));

      await videoPlayerController?.initialize();

      if (videoPlayerController != null && (videoPlayerController?.value.isInitialized ?? false)) {
        chewieController = ChewieController(
          videoPlayerController: videoPlayerController!,
          looping: true,
          allowedScreenSleep: false,
          allowMuting: false,
          showControlsOnInitialize: false,
          showControls: false,
          autoPlay: true,
        );

        if (chewieController != null) {
          onChangeLoading(false);
        } else {
          onChangeLoading(true);
        }
      }
    } catch (e) {
      onDisposeVideoPlayer();
      Utils.showLog("Reels Video Initialization Failed !!! => $e");
    }
  }

  void onStopVideo() {
    onChangePlayPauseIcon(false);
    videoPlayerController?.pause();
  }

  void onPlayVideo() {
    onChangePlayPauseIcon(true);
    videoPlayerController?.play();
  }

  void onClickVideo() async {
    if (isVideoLoading == false) {
      videoPlayerController!.value.isPlaying ? onStopVideo() : onPlayVideo();
      onShowPlayPauseIcon(true);
      await 2.seconds.delay();
      onShowPlayPauseIcon(false);
    }
  }

  void onClickPlayPause() async {
    videoPlayerController!.value.isPlaying ? onStopVideo() : onPlayVideo();
  }

  void onChangeLoading(bool value) {
    isVideoLoading = value;
    update([AppConstant.onChangeLoading]);
  }

  void onChangePlayPauseIcon(bool value) {
    isPlaying = value;
    update([AppConstant.onChangePlayPauseIcon]);
  }

  void onShowPlayPauseIcon(bool value) {
    isShowPlayPauseIcon = value;
    update([AppConstant.onShowPlayPauseIcon]);
  }

  void onDisposeVideoPlayer() {
    try {
      onStopVideo();
      videoPlayerController?.dispose();
      chewieController?.dispose();
      chewieController = null;
      videoPlayerController = null;
      onChangeLoading(true);
      Utils.showLog("Video Dispose Success");
    } catch (e) {
      Utils.showLog(">>>> On Dispose VideoPlayer Error => $e");
    }
  }

  @override
  void onClose() async {
    await 500.milliseconds.delay();
    onDisposeVideoPlayer();
    super.onClose();
  }

  void onClickNext() {
    onStopVideo();

    if (Utils.shortsDuration > videoTime) {
      Get.toNamed(
        AppRoutes.uploadVideoPage,
        arguments: {
          ApiParams.video: videoUrl,
          ApiParams.image: videoThumbnail,
          ApiParams.time: videoTime,
          ApiParams.songId: songId,
        },
      );
    } else {
      Utils.showToast(text: "your duration of Video greater than decided by the admin !!");
    }
  }
}
