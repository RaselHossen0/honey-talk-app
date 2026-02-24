import 'dart:math';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tingle/common/widget/loading_widget.dart';
import 'package:tingle/page/live_page/model/live_model.dart';
import 'package:tingle/routes/app_routes.dart';
import 'package:tingle/utils/constant.dart';
import 'package:tingle/utils/permission.dart';
import 'package:tingle/utils/utils.dart';

class GoLiveController extends GetxController {
  CameraController? cameraController;
  CameraLensDirection cameraLensDirection = CameraLensDirection.front;

  bool isFlashOn = false;
  String channelId = "";
  int agoraId = 0;

  String? pickImage;

  TextEditingController nameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  bool isPrivate = false;
  int privateCode = 0;

  @override
  void onInit() {
    onRequestPermissions();

    channelId = onGenerateRandomNumber();
    agoraId = 100000 + Random().nextInt(900000);

    privateCode = 1000 + Random().nextInt(9000);

    Utils.showLog("Generate AgoraUid => $agoraId **** ChannelId => $channelId");

    super.onInit();
  }

  @override
  void onClose() {
    onDisposeCamera();
    super.onClose();
  }

  Future<void> onClickGoLive() async {
    onVideoLive();
  }

  Future<void> onVideoLive() async {
    Get.dialog(barrierDismissible: false, PopScope(canPop: false, child: const LoadingWidget())); // Start Loading...

    // createLiveUserModel = await StartLiveSteamingApi.callApi(
    //   token: token,
    //   uid: uid,
    //   userId: Database.loginUserId,
    //   liveType: 1,
    //   channel: channelId,
    //   agoraUID: agoraId.toString(),
    // );

    Get.back(); // Stop Loading...

    Get.offAndToNamed(AppRoutes.livePage,
        arguments: LiveModel(
          isHost: true,
          isFollow: false,
          liveType: 1, // 1 = public live (example)
          isChannelMediaRelay: false,

          // >>>>>>>>>> HOST_1_AGORA_INFO <<<<<<<<<<
          host1Token: "dummy_agora_token_123456",
          host1Channel: "dummy_channel_abc",
          host1Uid: 123456,
          host1LiveHistoryId: "live_history_7890",

          // >>>>>>>>>> HOST_1_USER_INFO <<<<<<<<<<
          host1UserId: "user_101",
          host1Name: "HostUserOne",
          host1UserName: "host_user1",
          host1UniqueId: "unique_id_101",
          host1Image: "https://randomuser.me/api/portraits/men/10.jpg",
          host1ProfilePicIsBanned: false,
          host1WealthLevelImage: "wealth_level_2.png",
          host1Coin: 5000,

          // >>>>>>>>>> HOST_2_USER_INFO <<<<<<<<<<
          host2UserId: "",
          host2Name: "",
          host2UserName: "",
          host2UniqueId: "",
          host2Image: "",
          host2ProfilePicIsBanned: false,
          host2WealthLevelImage: "",
          host2Coin: 0,

          // >>>>>>>>>> HOST_2_AGORA_INFO <<<<<<<<<<
          host2Uid: 0,
          host2Token: "",
          host2Channel: "",
          host2LiveHistoryId: "",
        ));
  }

  //************************************************************************************************************************
  Future<void> onRequestPermissions() async {
    AppPermission.onGetCameraPermission(
      onGranted: () {
        AppPermission.onGetMicrophonePermission(
          onGranted: () {
            onInitializeCamera();
          },
        );
      },
    );
  }

  Future<void> onInitializeCamera() async {
    try {
      final cameras = await availableCameras();
      final camera = cameras.last;
      cameraController = CameraController(camera, ResolutionPreset.medium);
      await cameraController?.initialize();
      update([AppConstant.onInitializeCamera]);
    } catch (e) {
      Utils.showLog("Error initializing camera: $e");
    }
  }

  Future<void> onDisposeCamera() async {
    cameraController?.dispose();
    cameraController = null;
    Utils.showLog("Camera Controller Dispose Success");
  }

  Future<void> onSwitchFlash() async {
    if (cameraLensDirection == CameraLensDirection.back) {
      if (isFlashOn) {
        isFlashOn = false;
        await cameraController?.setFlashMode(FlashMode.off);
      } else {
        isFlashOn = true;
        await cameraController?.setFlashMode(FlashMode.torch);
      }
      update([AppConstant.onSwitchFlash]);
    }
  }

  Future<void> onSwitchCamera() async {
    Utils.showLog("Switch Normal Camera Method Calling....");

    Get.dialog(barrierDismissible: false, PopScope(canPop: false, child: const LoadingWidget())); // Start Loading...
    if (isFlashOn) {
      onSwitchFlash();
    }

    cameraLensDirection = cameraLensDirection == CameraLensDirection.back ? CameraLensDirection.front : CameraLensDirection.back;
    final cameras = await availableCameras();
    final camera = cameras.firstWhere((camera) => camera.lensDirection == cameraLensDirection);
    cameraController = CameraController(camera, ResolutionPreset.high);
    await cameraController?.initialize();
    Get.back(); // Stop Loading...
    update([AppConstant.onInitializeCamera]);
  }

  String onGenerateRandomNumber() {
    const String chars = 'abcdefghijklmnopqrstuvwxyz';
    Random random = Random();
    return List.generate(
      25,
      (index) => chars[random.nextInt(chars.length)],
    ).join();
  }
}
