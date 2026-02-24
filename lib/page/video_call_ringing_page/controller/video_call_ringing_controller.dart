import 'dart:async';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tingle/routes/app_routes.dart';
import 'package:tingle/utils/constant.dart';
import 'package:tingle/utils/socket_params.dart';
import 'package:tingle/utils/utils.dart';

class VideoCallRingingController extends GetxController with WidgetsBindingObserver {
  Timer? timer;

  CameraController? cameraController;
  CameraLensDirection cameraLensDirection = CameraLensDirection.front;

  bool isLoading = true;

  // GET ARGUMENT FROM SOCKET LISTEN...
  String callId = "";
  String callerId = "";
  String receiverId = "";
  String receiverName = "";

  @override
  void onInit() {
    final argument = Get.arguments;

    if (argument != null) {
      callId = argument[SocketParams.callId];
      callerId = argument[SocketParams.callerId];
      receiverId = argument[SocketParams.receiverId];
      receiverName = argument[SocketParams.receiverName];
    }
    Utils.showLog("Video Call Ringing Argument => $argument");
    onInitializeCamera();
    onStartTime();
    WidgetsBinding.instance.addObserver(this);
    super.onInit();
  }

  @override
  void onClose() {
    onDisposeCamera();
    WidgetsBinding.instance.removeObserver(this);
    super.onClose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      Utils.showLog("User Back To App...");
    }
    if (state == AppLifecycleState.inactive) {
      Utils.showLog("User Try To Exit...");
      onCancelVideoCall();
    }
  }

  Future<void> onInitializeCamera() async {
    try {
      isLoading = true;
      update([AppConstant.onInitializeCamera]);

      cameraController = CameraController(
        const CameraDescription(
          name: "0",
          sensorOrientation: 90,
          lensDirection: CameraLensDirection.front,
        ),
        ResolutionPreset.medium,
      );

      await cameraController?.initialize();

      if (cameraController != null && cameraController?.value.isInitialized == true) {
        isLoading = false;
        update([AppConstant.onInitializeCamera]);
      }
    } catch (e) {
      Utils.showLog("Camera Initialize Failed !! => $e");
    }
  }

  Future<void> onDisposeCamera() async {
    try {
      cameraController?.dispose();
    } catch (e) {
      Utils.showLog("Camera Dispose Failed !! => $e");
    }
  }

  Future<void> onStartTime() async {
    timer = Timer(
      Duration(seconds: 30),
      () {
        if (Get.currentRoute == AppRoutes.videoCallRingingPage) {
          Utils.showLog("Auto Call Cut Success");
          onCancelVideoCall();
        }
      },
    );
  }

  Future<void> onCancelVideoCall() async {
    onCancelCallToSocket();
    Get.back();
  }

  // ******************************************************************************************************************************

  Future<void> onCancelCallToSocket() async {}
}
