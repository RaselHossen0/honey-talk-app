import 'dart:async';
import 'dart:convert';
import 'dart:developer';
// import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tingle/page/live_page/widget/live_gift_bottom_sheet_widget.dart';
import 'package:tingle/common/widget/loading_widget.dart';
import 'package:tingle/page/audio_room_page/model/live_top_gift_user_model.dart';
import 'package:tingle/page/audio_room_page/model/live_viewer_user_model.dart';
import 'package:tingle/page/live_page/model/live_comment_model.dart';
import 'package:tingle/page/live_page/model/live_model.dart';
import 'package:tingle/page/live_page/model/pk_gift_top_user_model.dart';
import 'package:tingle/page/live_page/pk_battle_widget/invitation_for_pk_bottom_sheet.dart';
import 'package:tingle/page/live_page/pk_battle_widget/invite_user_for_pk_battle_bottom_sheet.dart';
import 'package:tingle/page/live_page/pk_battle_widget/sending_pk_request_bottom_sheet.dart';
import 'package:tingle/page/live_page/pk_battle_widget/tie_pk_bottom_sheet.dart';
import 'package:tingle/page/live_page/pk_battle_widget/you_lost_pk_bottom_sheet.dart';
import 'package:tingle/page/live_page/pk_battle_widget/you_win_pk_bottom_sheet.dart';
import 'package:tingle/utils/constant.dart';
import 'package:tingle/utils/socket_params.dart';
import 'package:tingle/utils/utils.dart';

class LiveController extends GetxController {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  // >>>>> >>>>>> >>>> >>>>> >>>>> AGORA <<<<< <<<<< <<<<< <<<<< <<<<<

  LiveModel? liveModel;

  RxBool isShowPkAnimation = false.obs;

  @override
  void onInit() {
    if (Get.arguments != null) {
      liveModel = Get.arguments;
      Utils.showLog("Live Argument Is Host => ${liveModel?.isHost}");
    }
    init();
    super.onInit();
  }

  @override
  void onClose() {
    onDispose();
    super.onClose();
  }

  Future<void> init() async {
    initAgora();
    onJoinLiveRoom();
    onDefaultComment();
    onChangeLiveTime();
    onAutoExit();
    LiveGiftBottomSheetWidget.init();
    Utils.showLog("Live Controller Init Success => ${liveModel?.liveComments}");
    if (liveModel?.isChannelMediaRelay == true) onShowPkAnimation();
  }

  Future<void> onDispose() async {
    try {
      onDisposeAgora();
      onLeaveLiveRoom();
      liveModel?.liveTimer?.cancel();
      liveModel?.pkTimer?.cancel();
      Utils.showLog("Live Controller Dispose Success");
    } catch (e) {
      Utils.showLog("Dispose Failed => $e");
    }
  }

  // >>>>> >>>>>> >>>> >>>>> >>>>> AGORA METHOD <<<<< <<<<< <<<<< <<<<< <<<<<

  Future<void> initAgora() async {
    try {
      // await liveModel?.engine?.leaveChannel();
      // await liveModel?.engine?.release();
      // liveModel?.engine = null;
      onCreateEngine();
    } catch (e) {
      Utils.showLog("Dispose Failed => $e");
    }
  }

  Future<void> onDisposeAgora() async {
    try {
      // await liveModel?.engine?.leaveChannel();
      // await liveModel?.engine?.release();
    } catch (e) {
      Utils.showLog("Dispose Failed => $e");
    }
  }

  Future<void> onCreateEngine() async {
    try {
      // liveModel?.engine = createAgoraRtcEngine();
      // await liveModel?.engine?.initialize(
      //   RtcEngineContext(
      //     appId: Utils.agoraAppId,
      //     channelProfile: ChannelProfileType.channelProfileLiveBroadcasting,
      //   ),
      // );
      await onJoinChannel();
    } catch (e) {
      Utils.showLog("Event Handler => Create Engine Failed => $e");
    }
  }

  Future<void> onJoinChannel() async {
    try {
      await onEventHandler();
      //
      // await liveModel?.engine?.joinChannel(
      //   uid: (liveModel?.isHost == true) ? (liveModel?.host1Uid ?? 0) : (liveModel?.host2Uid ?? 0),
      //   token: liveModel?.host1Token ?? "",
      //   channelId: liveModel?.host1Channel ?? "",
      //   options: ChannelMediaOptions(),
      // );
      //
      // await liveModel?.engine?.enableVideo();
      //
      // await liveModel?.engine?.setClientRole(role: (liveModel?.isHost == true) ? ClientRoleType.clientRoleBroadcaster : ClientRoleType.clientRoleAudience);
      //
      // if (liveModel?.isHost == true) {
      //   await liveModel?.engine?.startPreview();
      // }
    } catch (e) {
      Utils.showLog("Event Handler => Join Channel Failed => $e");
    }
  }

  Future<void> onEventHandler() async {
    // liveModel?.engine?.registerEventHandler(
    //   RtcEngineEventHandler(
    //     onJoinChannelSuccess: (RtcConnection connection, int elapsed) {
    //       Utils.showLog("Event Handler => Host Join Success => ChannelId => ${connection.channelId} LocalUid => ${connection.localUid}");
    //       if (liveModel?.engine != null && liveModel?.isHost == true) {
    //         liveModel?.isLoading = false;
    //         update([AppConstant.onEventHandler]);
    //       }
    //     },
    //     onUserJoined: (RtcConnection connection, int remoteUid, int elapsed) {
    //       Utils.showLog("Event Handler => User Join Success => ChannelId => ${connection.channelId} LocalUid => ${connection.localUid} RemoteUid => $remoteUid");
    //       liveModel?.isLoading = false;
    //       update([AppConstant.onEventHandler]);
    //     },
    //     onUserOffline: (RtcConnection connection, int remoteUid, UserOfflineReasonType reason) {
    //       Utils.showLog("Event Handler => User Leave Channel Success");
    //     },
    //     onError: (e, message) {
    //       Utils.showLog("Event Handler => Join Channel Failed => $e");
    //     },
    //     onChannelMediaRelayStateChanged: (ChannelMediaRelayState state, ChannelMediaRelayError code) {
    //       Utils.showLog("Event Handler => Channel Media Relay State Changed : $state");
    //       switch (state) {
    //         case ChannelMediaRelayState.relayStateIdle:
    //           Utils.showLog("Event Handler => Channel Media Relay State Changed : ");
    //           break;
    //         case ChannelMediaRelayState.relayStateRunning:
    //           Utils.showLog("Event Handler => Channel Media Relay State Changed : ");
    //           break;
    //         case ChannelMediaRelayState.relayStateFailure:
    //           Utils.showLog("Event Handler => Channel Media Relay State Changed : ");
    //           break;
    //         default:
    //           Utils.showLog("Event Handler => Channel Media Relay State Changed : ");
    //           break;
    //       }
    //     },
    //   ),
    // );
  }

  Future<void> onSwitchCamera() async {
    try {
      Get.dialog(const LoadingWidget(), barrierDismissible: false); // Start Loading...
      // await liveModel?.engine?.switchCamera();
      Get.back(); // Stop Loading...
    } catch (e) {
      Utils.showLog("Event Handler => Switch Camera Failed => $e");
    }
  }

  Future<void> onSwitchMic() async {
    log("**************");
    try {
      if (liveModel?.isMute == true) {
        liveModel?.isMute = false;
        update([AppConstant.onSwitchMic]);
        // await liveModel?.engine?.muteLocalAudioStream(false);
      } else {
        liveModel?.isMute = true;
        update([AppConstant.onSwitchMic]);
        // await liveModel?.engine?.muteLocalAudioStream(true);
      }
    } catch (e) {
      Utils.showLog("Event Handler => Switch Mic Failed => $e");
    }
  }

  Future<void> onStartChannelMediaRelay() async {
    try {
      // await liveModel?.engine?.startOrUpdateChannelMediaRelay(
      //   ChannelMediaRelayConfiguration(
      //     srcInfo: ChannelMediaInfo(
      //       channelName: liveModel?.host1Channel ?? "",
      //       token: liveModel?.host1Token ?? "",
      //       uid: 0,
      //     ),
      //     destInfos: [
      //       ChannelMediaInfo(
      //         channelName: liveModel?.host2Channel ?? "",
      //         token: liveModel?.host2Token ?? "",
      //         uid: 1,
      //       ),
      //     ],
      //     destCount: 1,
      //   ),
      // );

      Utils.showLog("On Start Relay Method Call Success");
    } catch (e) {
      Utils.showLog("Stop Channel Media Relay Failed => $e");
    }
  }

  Future<void> onStopChannelMediaRelay() async {
    try {
      // await liveModel?.engine?.stopChannelMediaRelay();
    } catch (e) {
      Utils.showLog("Stop Channel Media Relay Failed => $e");
    }
  }

  Future<void> onChangeChannelMediaRelay(bool value) async {
    liveModel?.isChannelMediaRelay = value;
    update([AppConstant.onEventHandler]);
  }

  void onUpdateTopGiftUser({required List<PkGiftTopUserModel> users, required String liveHistoryId}) async {
    if (liveModel?.host1LiveHistoryId == liveHistoryId) {
      liveModel?.host1TopGiftUsers = users;
    } else {
      liveModel?.host2TopGiftUsers = users;
    }

    update([AppConstant.onSeatUserUpdate]);
  }

  void onChangeTopGiftUser({
    required List<PkGiftTopUserModel> host1,
    required List<PkGiftTopUserModel> host2,
  }) async {
    liveModel?.host1TopGiftUsers = host1;
    liveModel?.host2TopGiftUsers = host2;

    update([AppConstant.onSeatUserUpdate]);
  }

// >>>>> >>>>>> >>>> >>>>> >>>>> SOCKET EMIT METHOD <<<<< <<<<< <<<<< <<<<< <<<<<

  void onJoinLiveRoom() async {
    if (liveModel?.isHost == true) {
    } else {}
  }

  void onLeaveLiveRoom() async {}

  Future<void> onSendComment() async {
    if (liveModel?.commentController.text.trim().isNotEmpty ?? false) {
      liveModel?.commentController.clear();
      update([AppConstant.onChangeComment]);
    }
  }

  Future<void> onSendPkRequest({required String host2UserId}) async {}

  Future<void> onCancelPkRequest({required String host2UserId}) async {}

  Future<void> onPkAnswer({required bool isAccept}) async {}

  Future<void> onPkEnd({required bool isManualMode}) async {}

  // >>>>> >>>>>> >>>> >>>>> >>>>> SOCKET LISTEN METHOD <<<<< <<<<< <<<<< <<<<< <<<<<

  void onUpdateCoin({required int coin}) async {
    liveModel?.liveEarnedCoin = coin;
    update([AppConstant.onUpdateCoin]);
  }

  void onChangeTopLiveGiftUser({required List<LiveTopGiftUserModel> value}) async {
    liveModel?.liveTopGiftUsers = value;
    update([AppConstant.onUpdateTopGiftUser]);
    Utils.showLog("Top Live User List Length => ${liveModel?.liveTopGiftUsers.length}");
  }

  void onListenPkEnd(dynamic data) {
    liveModel?.host1Rank = 0;
    liveModel?.host2Rank = 0;

    if (liveModel?.isHost == true) onStopChannelMediaRelay();
    onChangeChannelMediaRelay(false);

    if (data[SocketParams.isManualMode] == false || data[SocketParams.pkEndUserId] != liveModel?.host1UserId) {
      if (data[SocketParams.data][SocketParams.pkConfig][SocketParams.isWinner] == 1) {
        YouLostPkBottomSheet.onShow(
          h1Name: liveModel?.host1Name ?? "",
          h1Image: liveModel?.host1Image ?? "",
          h1IsBanned: liveModel?.host1ProfilePicIsBanned ?? false,
          h2Name: liveModel?.host2Name ?? "",
          h2Image: liveModel?.host2Image ?? "",
          h2IsBanned: liveModel?.host2ProfilePicIsBanned ?? false,
          h1Rank: data[SocketParams.data][SocketParams.pkConfig][SocketParams.localRank],
          h2Rank: data[SocketParams.data][SocketParams.pkConfig][SocketParams.remoteRank],
          isHost: liveModel?.isHost == true,
          battleAgainCallback: () {
            Get.back();
            InviteUserForPkBattleBottomSheet.onShow();
          },
        );
      } else if (data[SocketParams.data][SocketParams.pkConfig][SocketParams.isWinner] == 2) {
        YouWinPkBottomSheet.onShow(
          h1Name: liveModel?.host1Name ?? "",
          h1Image: liveModel?.host1Image ?? "",
          h1IsBanned: liveModel?.host1ProfilePicIsBanned ?? false,
          h2Name: liveModel?.host2Name ?? "",
          h2Image: liveModel?.host2Image ?? "",
          h2IsBanned: liveModel?.host2ProfilePicIsBanned ?? false,
          h1Rank: data[SocketParams.data][SocketParams.pkConfig][SocketParams.localRank],
          h2Rank: data[SocketParams.data][SocketParams.pkConfig][SocketParams.remoteRank],
          isHost: liveModel?.isHost == true,
          battleAgainCallback: () {
            Get.back();
            InviteUserForPkBattleBottomSheet.onShow();
          },
        );
      } else {
        TiePkBottomSheet.onShow(
          h1Name: liveModel?.host1Name ?? "",
          h1Image: liveModel?.host1Image ?? "",
          h1IsBanned: liveModel?.host1ProfilePicIsBanned ?? false,
          h2Name: liveModel?.host2Name ?? "",
          h2Image: liveModel?.host2Image ?? "",
          h2IsBanned: liveModel?.host2ProfilePicIsBanned ?? false,
          h1Rank: data[SocketParams.data][SocketParams.pkConfig][SocketParams.localRank],
          h2Rank: data[SocketParams.data][SocketParams.pkConfig][SocketParams.remoteRank],
          isHost: liveModel?.isHost == true,
          battleAgainCallback: () {
            Get.back();
            InviteUserForPkBattleBottomSheet.onShow();
          },
        );
      }
    }

    if (data[SocketParams.isManualMode] == true && data[SocketParams.pkEndUserId] == liveModel?.host1UserId) {
      Get.back(); // Stop Live Steaming
    }
  }

  void onChangeViewCount(int value) {
    liveModel?.host1ViewCount = value;
    update([AppConstant.onChangeViewCount]);
  }

  void onGetComment({required LiveCommentModel comment}) {
    liveModel?.liveComments.add(comment);
    onScrollAnimation();
    update([AppConstant.onChangeComment]);
  }

  void onPkRequestReceived(dynamic data) async {
    final jsonResponse = jsonDecode(data);

    if (jsonResponse[SocketParams.instantCutRequestByHost] == false) {
      // >>>>>>>>>> HOST_2_AGORA_INFO <<<<<<<<<<
      liveModel?.host2Uid = jsonResponse[SocketParams.host1Uid];
      liveModel?.host2Token = jsonResponse[SocketParams.host1Token];
      liveModel?.host2Channel = jsonResponse[SocketParams.host1Channel];
      liveModel?.host2LiveHistoryId = jsonResponse[SocketParams.host1LiveHistoryId];

      // >>>>>>>>>> HOST_2_USER_INFO <<<<<<<<<<
      liveModel?.host2UserId = jsonResponse[SocketParams.host1Id];
      liveModel?.host2Name = jsonResponse[SocketParams.host1Name];
      liveModel?.host2Image = jsonResponse[SocketParams.host1Image];
      liveModel?.host2UserName = jsonResponse[SocketParams.host1UserName];
      liveModel?.host2UniqueId = jsonResponse[SocketParams.host1UniqueId];
      liveModel?.host2ProfilePicIsBanned = jsonResponse[SocketParams.host1ProfilePicIsBanned];

      if (InviteUserForPkBattleBottomSheet.isOpenBottomSheet) Get.back();
      if (TiePkBottomSheet.isOpenBottomSheet) Get.back();
      if (YouWinPkBottomSheet.isOpenBottomSheet) Get.back();
      if (YouLostPkBottomSheet.isOpenBottomSheet) Get.back();

      InvitationForPkBottomSheet.onShow(
        name: jsonResponse[SocketParams.host1Name],
        image: jsonResponse[SocketParams.host1Image],
        uniqueId: jsonResponse[SocketParams.host1UniqueId],
        isBanned: jsonResponse[SocketParams.host1ProfilePicIsBanned],
        accept: () {
          Get.back();
          onPkAnswer(isAccept: true);
        },
        reject: () {
          Get.back();
          onPkAnswer(isAccept: false);
        },
      );
    } else {
      // CALL WHEN IF HOST_1 CANCEL PK REQUEST
      if (InvitationForPkBottomSheet.isOpenBottomSheet) Get.back(); // IF OPENED INVITE BOTTOM SHEET THEN CLOSE
    }
  }

  Future<void> onListenPkAnswer(dynamic value) async {
    if (SendingPkRequestBottomSheet.isOpenBottomSheet) Get.back();
    if (TiePkBottomSheet.isOpenBottomSheet) Get.back();
    if (YouWinPkBottomSheet.isOpenBottomSheet) Get.back();
    if (YouLostPkBottomSheet.isOpenBottomSheet) Get.back();
  }

  void onLiveViewerUserUpdateSocket(List<LiveViewerUserModel> value) async {
    liveModel?.liveViewers = value;
    update([AppConstant.onChangeViewCount]);
    Utils.showLog("Current Total Viewer => ${liveModel?.liveViewers.length}");
  }

  void onChangeRank({required int host1Rank, required int host2Rank, int? time}) async {
    liveModel?.host1Rank = host1Rank;
    liveModel?.host2Rank = host2Rank;
    update([AppConstant.onChangeRank]);

    Utils.showLog("Left Time => $time");

    if (time != null && liveModel?.isHost == false) {
      onChangePkTime(isPkRequestUser: false, time: time);
    }

    Utils.showLog("Updated Rank => H1=> ${liveModel?.host1Rank} => H2 => ${liveModel?.host2Rank}");
  }

  // >>>>> >>>>>> >>>> >>>>> >>>>> DEFAULT METHOD <<<<< <<<<< <<<<< <<<<< <<<<<

  void onChangeLiveTime() {
    liveModel?.liveTimer = Timer.periodic(
      const Duration(seconds: 1),
      (timer) {
        liveModel?.liveCountTime++;
        update([AppConstant.onChangeLiveTime]);
      },
    );
  }

  void onChangePkTime({required bool isPkRequestUser, required int time}) {
    liveModel?.pkTimer?.cancel();

    liveModel?.pkCountTime = time;
    liveModel?.pkTimer = Timer.periodic(
      const Duration(seconds: 1),
      (timer) {
        if (liveModel?.pkCountTime != 0) {
          liveModel?.pkCountTime--;
          update([AppConstant.onChangePkTime]);
          // Utils.showLog("Pk Battle Time => ${ConvertSecondToTime.onConvert(liveModel?.pkCountTime ?? 0)}");
        } else {
          liveModel?.pkCountTime = 0;
          liveModel?.pkTimer?.cancel();
          if (liveModel?.isHost == true && isPkRequestUser) onPkEnd(isManualMode: false);
        }
      },
    );
  }

  void onDefaultComment() {
    liveModel?.liveComments.addAll(
      [
        LiveCommentModel(
          type: 2,
          name: "",
          image: "",
          commentText: "",
          isBanned: false,
        ),
        LiveCommentModel(
          type: 3,
          name: "",
          image: "",
          commentText: "",
          isBanned: false,
        ),
      ],
    );
    onScrollAnimation();
    update([AppConstant.onChangeComment]);
  }

  Future<void> onScrollAnimation() async {
    try {
      await 10.milliseconds.delay();
      liveModel?.scrollController.animateTo(
        liveModel?.scrollController.position.maxScrollExtent ?? 0,
        duration: Duration(seconds: 1),
        curve: Curves.fastOutSlowIn,
      );
    } catch (e) {
      Utils.showLog("Scroll Down Failed => $e");
    }
  }

  void onClickGift(BuildContext context) {
    FocusManager.instance.primaryFocus?.unfocus();
    LiveGiftBottomSheetWidget.show(
      context: context,
      liveHistoryId: liveModel?.host1LiveHistoryId ?? "",
      receiverUserId: liveModel?.host1UserId ?? "",
    );
  }

  void onShowPkAnimation() async {
    await 1000.milliseconds.delay();
    isShowPkAnimation.value = true;
    await 1500.milliseconds.delay();
    isShowPkAnimation.value = false;
  }

  void onClickFollow() async {
    liveModel?.isFollow = !(liveModel?.isFollow ?? false);
    update([AppConstant.onClickFollow]);
  }

  void onAutoExit() {
    // Future.delayed(
    //   Duration(seconds: 10),
    //   () {
    //     if (liveModel?.engine == null || liveModel?.isLoading == true) {
    //       Get.back();
    //     }
    //   },
    // );
  }
}
