import 'dart:async';
import 'dart:developer';
import 'dart:math' show Random;
import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tingle/common/api/fetch_agora_token_api.dart';
import 'package:tingle/common/function/convert_second_to_time.dart';
import 'package:tingle/common/widget/loading_widget.dart';
import 'package:tingle/routes/app_routes.dart';
import 'package:tingle/utils/constant.dart';
import 'package:tingle/utils/database.dart';
import 'package:tingle/utils/socket_params.dart';
import 'package:tingle/utils/utils.dart';
import 'package:vibration/vibration.dart';

class VideoCallController extends GetxController with WidgetsBindingObserver {
  Timer? timer;
  Timer? coinCutTimer;
  int countTime = 0;

  RtcEngine? engine;
  bool isLoading = true;

  int hostUid = 0; // Do NOT CHANGE FOR VIDEO CALL...
  int? remoteUid;

  bool isVideoOn = true;
  bool isMicMute = true;

  bool isMuteRemoteVideo = false;
  bool isMuteRemoteAudio = false;

  // GET ARGUMENT FROM SOCKET LISTEN...
  String callId = "";
  String callerId = "";
  String callerName = "";
  String callerImage = "";
  String receiverId = "";
  String receiverName = "";
  String receiverImage = "";
  String token = "";
  String channelId = "";

  @override
  void onInit() {
    final argument = Get.arguments;

    if (argument != null) {
      callId = argument[SocketParams.callId];

      callerId = argument[SocketParams.callerId];
      callerName = argument[SocketParams.callerName];
      callerImage = argument[SocketParams.callerImage];

      receiverId = argument[SocketParams.receiverId];
      receiverName = argument[SocketParams.receiverName];
      receiverImage = argument[SocketParams.receiverImage];

      token = argument[SocketParams.token];
      channelId = argument[SocketParams.channel];
    }

    onChangeTime();
    onStartCoinCutTimer();
    onCreateEngine();

    Utils.showLog("Video Call Controller Initialized...");
    WidgetsBinding.instance.addObserver(this);
    super.onInit();
  }

  @override
  void onClose() {
    timer?.cancel();
    coinCutTimer?.cancel();
    onDisposeAgora();
    Utils.showLog("Video Call Page Controller Dispose Success");
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
      onClickCallCut();
    }
  }

  void onChangeTime() {
    timer = Timer.periodic(
      const Duration(seconds: 1),
      (timer) {
        if (Get.currentRoute == AppRoutes.videoCallPage) {
          countTime++;
          Utils.showLog("Video Call Running Time => ${ConvertSecondToTime.onConvert(countTime)}");
          update([AppConstant.onChangeTime]);
        } else {
          timer.cancel();
          countTime = 0;
          update([AppConstant.onChangeTime]);
        }
      },
    );
  }

  void onStartCoinCutTimer() {
    if (callerId == Database.loginUserId) {
      coinCutTimer = Timer.periodic(
        const Duration(minutes: 1),
        (timer) {
          if (Get.currentRoute == AppRoutes.videoCallPage) {
            Utils.showLog("Coin Cut Success");
          } else {
            timer.cancel();
          }
        },
      );
    }
  }

  // ****************************************************************************************************************************************

  Future<void> onCreateEngine() async {
    try {
      if (Utils.agoraAppId.isEmpty) {
        log("Agora App ID not set");
        onJoinChannel();
        return;
      }
      engine = createAgoraRtcEngine();
      await engine!.initialize(
        RtcEngineContext(
          appId: Utils.agoraAppId,
          channelProfile: ChannelProfileType.channelProfileCommunication,
        ),
      );
      log("Create Engine Success");
      onEventHandler();
    } catch (e) {
      log("Create Engine Failed => $e");
    }
  }

  Future<void> onEventHandler() async {
    try {
      engine?.registerEventHandler(
        RtcEngineEventHandler(
          onJoinChannelSuccess: (RtcConnection connection, int elapsed) {
            log("Event Handler => Host Join Channel Success : ${connection.channelId} ");
            isLoading = false;
            update([AppConstant.onEventHandler]);
          },
          onUserJoined: (RtcConnection connection, int remoteId, int elapsed) {
            log("Event Handler => User Join Channel Success $remoteId");
            remoteUid = remoteId;
            update([AppConstant.onEventHandler]);
          },
          onUserOffline: (RtcConnection connection, int remoteId, UserOfflineReasonType reason) {
            log("Event Handler => User Offline $remoteId");
          },
          onLeaveChannel: (RtcConnection connection, RtcStats stats) {
            log("Event Handler => Host Leave Channel Success");
          },
          onUserMuteVideo: (RtcConnection connection, int remoteUid, bool muted) {
            onChangeRemoteVideoState(muted);
          },
          onUserMuteAudio: (RtcConnection connection, int remoteUid, bool muted) {
            onChangeRemoteAudioState(muted);
          },
          onError: (ErrorCodeType e, String message) => log("Event Handler Error => $e"),
        ),
      );
      await onJoinChannel();

      await engine?.enableVideo();
      await engine?.enableAudio();
      await engine?.setClientRole(role: ClientRoleType.clientRoleBroadcaster);
    } catch (e) {
      log("Event Handler Failed => $e");
    }
  }

  Future<void> onJoinChannel() async {
    try {
      String useToken = token;
      String useChannel = channelId;
      int useUid = hostUid;
      if (useToken.isEmpty || useToken.startsWith('dummy') || useChannel.isEmpty) {
        useChannel = callId.isNotEmpty ? callId : 'call_${DateTime.now().millisecondsSinceEpoch}';
        useUid = 300000 + Random().nextInt(700000);
        final payload = await FetchAgoraTokenApi.callApi(channelName: useChannel, uid: useUid, role: 'publisher');
        if (payload != null) {
          useToken = payload.token;
          useUid = payload.uid;
        }
      }
      await engine?.joinChannel(
        token: useToken,
        channelId: useChannel,
        uid: useUid,
        options: const ChannelMediaOptions(),
      );
    } catch (e) {
      log("Join Channel Failed => $e");
    }
  }

  Future<void> onClickMic() async {
    if (isMicMute) {
      isMicMute = false;
      await engine?.muteLocalAudioStream(true);
    } else {
      isMicMute = true;
      await engine?.muteLocalAudioStream(false);
    }
    update([AppConstant.onClickMic]);
  }

  Future<void> onClickCamera() async {
    Vibration.vibrate(duration: 50, amplitude: 128);
    Get.dialog(const LoadingWidget(), barrierDismissible: false);
    await engine?.switchCamera();
    Get.back();
  }

  Future<void> onClickVideo() async {
    isVideoOn = !isVideoOn;
    await engine?.enableLocalVideo(isVideoOn);
    update([AppConstant.onClickVideo]);
  }

  Future<void> onClickCallCut() async {
    Vibration.vibrate(duration: 50, amplitude: 128);
    onCallCutToSocket();
    Get.back();
  }

  void onDisposeAgora() {
    try {
      engine?.release();
      engine = null;
    } catch (e) {
      Utils.showLog("Agora Dispose Failed => $e");
    }
  }

  Future<void> onChangeRemoteVideoState(bool value) async {
    isMuteRemoteVideo = value;
    update([AppConstant.onEventHandler]);
  }

  Future<void> onChangeRemoteAudioState(bool value) async {
    isMuteRemoteAudio = value;
    update([AppConstant.onEventHandler]);
  }

  //************************************************************************************************************

  void onCallCutToSocket() {}
}
