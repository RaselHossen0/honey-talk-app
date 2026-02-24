import 'dart:async';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:tingle/routes/app_routes.dart';
import 'package:tingle/utils/assets.dart';
import 'package:tingle/utils/socket_params.dart';
import 'package:tingle/utils/utils.dart';
import 'package:vibration/vibration.dart';

class IncomingVideoCallController extends GetxController with WidgetsBindingObserver {
// GET ARGUMENT FROM SOCKET LISTEN...
  String callId = "";
  String callerId = "";
  String callerName = "";
  String callerImage = "";
  String receiverId = "";
  String receiverName = "";
  String receiverImage = "";
  String token = "";
  String channel = "";

  bool isCallResponse = false;
  AudioPlayer audioPlayer = AudioPlayer();
  Timer? vibrationTimer;
  Timer? ringingTimer;

  @override
  void onInit() {
    final argument = Get.arguments;
    Utils.showLog("Video Call Ringing Argument => $argument");

    if (argument != null) {
      callId = argument[SocketParams.callId];
      callerId = argument[SocketParams.callerId];
      callerName = argument[SocketParams.callerName];
      callerImage = argument[SocketParams.callerImage];
      receiverId = argument[SocketParams.receiverId];
      receiverName = argument[SocketParams.receiverName];
      receiverImage = argument[SocketParams.receiverImage];
      token = argument[SocketParams.token];
      channel = argument[SocketParams.channel];
    }

    onStartVibration();
    onPlayAudio();
    onStartRingingTimer();
    WidgetsBinding.instance.addObserver(this);
    super.onInit();
  }

  @override
  void onClose() {
    vibrationTimer?.cancel();
    ringingTimer?.cancel();
    onPauseAudio();
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
    }
  }

  void onStartVibration() {
    vibrationTimer = Timer.periodic(Duration(milliseconds: 500), (timer) => Vibration.vibrate(duration: 150, amplitude: 150));
  }

  void onPlayAudio() async {
    try {
      await audioPlayer.play(AssetSource(AppAssets.musicRing_1));
    } catch (e) {
      Utils.showLog("Audio Play Failed !! => $e");
    }
  }

  void onPauseAudio() {
    try {
      audioPlayer.pause();
    } catch (e) {
      Utils.showLog("Audio Pause Error => $e");
    }
  }

  void onStartRingingTimer() async {
    ringingTimer = Timer(
      Duration(seconds: 30),
      () {
        if (Get.currentRoute == AppRoutes.incomingVideoCallPage) {
          Utils.showLog("Call Auto Decline Success");
          onCallDecline();
          Get.back();
        }
        Utils.showLog("Start Ringing Timer => Back To Incoming Call");
      },
    );
  }

  Future<void> onCallAnswer() async {
    try {
      PermissionStatus cameraStatus = await Permission.camera.request();

      if (cameraStatus == PermissionStatus.granted) {
        PermissionStatus microphoneStatus = await Permission.microphone.request();
        if (microphoneStatus == PermissionStatus.granted) {
          Vibration.vibrate(duration: 50, amplitude: 128);
          await 400.milliseconds.delay();
          if (isCallResponse == false) {
            isCallResponse = true;
            onCallResponseToSocket(isAccept: true);
          }
        } else {
          Utils.showToast(text: "Please Allow Microphone Permission");
        }
      } else {
        Utils.showToast(text: "Please Allow Audio Camera Permission");
      }
    } catch (e) {
      Utils.showLog("Video Call Failed => $e");
    }
  }

  Future<void> onCallDecline() async {
    Vibration.vibrate(duration: 50, amplitude: 128);
    await 50.milliseconds.delay();
    if (isCallResponse == false) {
      isCallResponse = true;
      onCallResponseToSocket(isAccept: false);
      Get.back();
    }
  }

  //************************************************************************************************************************************************

  Future<void> onCallResponseToSocket({required bool isAccept}) async {}
}
