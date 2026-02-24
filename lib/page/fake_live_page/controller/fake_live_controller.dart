import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:math' as math;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tingle/common/model/fatch_other_user_profile_model.dart';
import 'package:tingle/common/widget/fake_live_gift_bottom_sheet_widget.dart';
import 'package:tingle/common/widget/loading_widget.dart';
import 'package:tingle/database/fake_data/user_fake_data.dart';
import 'package:tingle/page/audio_room_page/model/live_viewer_user_model.dart';
import 'package:tingle/page/fake_live_page/model/fake_live_model.dart';
import 'package:tingle/page/fake_live_page/widget/fake_comment_widget.dart';
import 'package:tingle/page/live_page/model/pk_gift_top_user_model.dart';
import 'package:tingle/page/live_page/pk_battle_widget/invitation_for_pk_bottom_sheet.dart';
import 'package:tingle/page/live_page/pk_battle_widget/invite_user_for_pk_battle_bottom_sheet.dart';
import 'package:tingle/page/live_page/pk_battle_widget/tie_pk_bottom_sheet.dart';
import 'package:tingle/page/live_page/pk_battle_widget/you_lost_pk_bottom_sheet.dart';
import 'package:tingle/page/live_page/pk_battle_widget/you_win_pk_bottom_sheet.dart';
import 'package:tingle/utils/constant.dart';
import 'package:tingle/utils/database.dart';
import 'package:tingle/utils/socket_params.dart';
import 'package:tingle/utils/utils.dart';
import 'package:video_player/video_player.dart';

class FakeLiveController extends GetxController {
  // >>>>> >>>>>> >>>> >>>>> >>>>> AGORA <<<<< <<<<< <<<<< <<<<< <<<<<

  FakeLiveModel? fakeLiveModel;

  RxBool isShowPkAnimation = false.obs;

  @override
  void onInit() {
    if (Get.arguments != null) {
      fakeLiveModel = Get.arguments;
      Utils.showLog("Live Argument Is Host => ${fakeLiveModel?.isHost}");
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
    onGetComment();
    onChangeLiveTime();
    addFakeComment();
    onLiveViewer();
    onChangePkTime();
    startAutoRankChange();
    updateGiftUsers();

    // onAutoExit();
    Utils.showLog("Live Controller Init Success => ${fakeLiveModel?.liveComments}");
    if (fakeLiveModel?.isChannelMediaRelay == true) onShowPkAnimation();
  }

  Timer? time;
  addFakeComment() {
    time = Timer.periodic(const Duration(seconds: 3), (Timer timer) {
      addItems();
    });
  }

  void fakeRanking() {
    math.Random random = math.Random();
    onChangeRank(
      host1Rank: random.nextInt(100),
      host2Rank: random.nextInt(100),
    );
  }

  List<HostComment> fakeCommentList = [];
  void addItems() {
    fakeHostCommentList.shuffle();
    log("object::::  1${fakeHostCommentList.first.message}");

    fakeCommentList.add(fakeHostCommentList.first);
    // onScrollAnimation();
    fakeLiveModel?.scrollController.animateTo(fakeLiveModel!.scrollController.position.maxScrollExtent, duration: const Duration(milliseconds: 50), curve: Curves.easeOut);
    update([AppConstant.onChangeComment]);
  }

  void onGetComment() {
    fakeHostCommentList.shuffle();

    fakeCommentList.addAll(fakeHostCommentList.take(10));
    onScrollAnimation();
    update([AppConstant.onChangeComment]);
  }

  @override
  void dispose() {
    onDispose();
    super.dispose();
  }

  Future<void> onDispose() async {
    try {
      onDisposeAgora();
      time?.cancel();

      videoPlayerController!.dispose();
      pkHost2videoPlayerController!.dispose();
      fakeLiveModel?.liveTimer?.cancel();
      fakeLiveModel?.pkTimer?.cancel();
      rankUpdateTimer?.cancel();

      Utils.showLog("Live Controller Dispose Success");
    } catch (e) {
      Utils.showLog("Dispose Failed => $e");
    }
  }

  // >>>>> >>>>>> >>>> >>>>> >>>>> AGORA METHOD <<<<< <<<<< <<<<< <<<<< <<<<<
  VideoPlayerController? videoPlayerController;
  VideoPlayerController? pkHost2videoPlayerController;
  Future<void> initAgora() async {
    log("object::::initAgora ${fakeLiveModel?.liveType}");
    if (fakeLiveModel?.liveType == 3) {
      onCreateFakePK();
      onCreateFakePKHost2();
    } else {
      // onFakeLive();
      onUltraFakeLive();
    }
  }

  Future<void> onDisposeAgora() async {
    try {
      // await fakeLiveModel?.engine?.leaveChannel();
      // await fakeLiveModel?.engine?.release();
    } catch (e) {
      Utils.showLog("Dispose Failed => $e");
    }
  }

  Future<void> onCreateFakePK() async {
    try {
      Utils.showLog("Agora Init Success");
      if (fakeLiveModel?.pkStreamSources.first.startsWith("https") ?? false) {
        Utils.showLog("Video URL ${fakeLiveModel?.pkStreamSources.first}");
        videoPlayerController = VideoPlayerController.networkUrl(
          Uri.parse(FakeProfilesSet.videoUrlSec),
          videoPlayerOptions: VideoPlayerOptions(mixWithOthers: true),
        );
        videoPlayerController?.initialize().then((_) {
          videoPlayerController?.setLooping(true);
          videoPlayerController?.play();
        });
        Utils.showLog("Video URL Success");
      } else {
        Utils.showLog("Video URL Failed");
        Utils.showLog("Video URL ${fakeLiveModel?.pkStreamSources.first}");
        videoPlayerController = VideoPlayerController.networkUrl(
          Uri.parse(FakeProfilesSet.videoUrlSec),
          videoPlayerOptions: VideoPlayerOptions(mixWithOthers: true),
        );
        videoPlayerController?.initialize().then((_) {
          videoPlayerController?.setLooping(true);
          videoPlayerController?.play();
        });
      }
      // onCreateEngine();
    } catch (e) {
      Utils.showLog("Dispose Failed => $e");
    }
  }

  Future<void> onCreateFakePKHost2() async {
    try {
      Utils.showLog("Agora Init Success Pk 2");
      if (fakeLiveModel?.pkStreamSources.last.startsWith("https") ?? false) {
        Utils.showLog("Video URL ${fakeLiveModel?.pkStreamSources.last}");
        pkHost2videoPlayerController = VideoPlayerController.networkUrl(
          Uri.parse(FakeProfilesSet.videoUrlSec),
          videoPlayerOptions: VideoPlayerOptions(mixWithOthers: true),
        );
        pkHost2videoPlayerController?.initialize().then((_) {
          pkHost2videoPlayerController?.setLooping(true);
          pkHost2videoPlayerController?.play();
        });
        Utils.showLog("Video URL Success");
      } else {
        Utils.showLog("Video URL Failed");
        Utils.showLog("Video URL ${fakeLiveModel?.pkStreamSources.last}");
        pkHost2videoPlayerController = VideoPlayerController.networkUrl(
          Uri.parse(FakeProfilesSet.videoUrlSec),
          videoPlayerOptions: VideoPlayerOptions(mixWithOthers: true),
        );
        pkHost2videoPlayerController?.initialize().then((_) {
          pkHost2videoPlayerController?.setLooping(true);
          pkHost2videoPlayerController?.play();
        });
      }
    } catch (e) {
      Utils.showLog("Dispose Failed => $e");
    }
  }

  Future<void> onUltraFakeLive() async {
    try {
      Utils.showLog("Agora Init Success ${fakeLiveModel?.streamSource}");
      if (fakeLiveModel?.streamSource.startsWith("https") ?? false) {
        Utils.showLog("Video URL ${fakeLiveModel?.streamSource}");
        videoPlayerController = VideoPlayerController.networkUrl(
          Uri.parse(math.Random().nextBool() ? FakeProfilesSet.videoUrl : FakeProfilesSet.videoUrlSec),
          videoPlayerOptions: VideoPlayerOptions(mixWithOthers: true),
        );
        videoPlayerController?.initialize().then((_) {
          videoPlayerController?.setLooping(true);
          videoPlayerController?.play();
          // update([AppConstant.onEventHandler]);
        });
        Utils.showLog("Video URL Success");
      } else {
        Utils.showLog("Video URL Failed");
        Utils.showLog("Video URL ${fakeLiveModel?.streamSource}");
        videoPlayerController = VideoPlayerController.networkUrl(
          Uri.parse(math.Random().nextBool() ? FakeProfilesSet.videoUrl : FakeProfilesSet.videoUrlSec),
          videoPlayerOptions: VideoPlayerOptions(mixWithOthers: true),
        );
        videoPlayerController?.initialize().then((_) {
          videoPlayerController?.setLooping(true);
          videoPlayerController?.play();
        });
      }
    } catch (e) {
      Utils.showLog("Dispose Failed => $e");
    }
  }

  Future<void> onSwitchCamera() async {
    try {
      Get.dialog(const LoadingWidget(), barrierDismissible: false); // Start Loading...
      // await fakeLiveModel?.engine?.switchCamera();
      Get.back(); // Stop Loading...
    } catch (e) {
      Utils.showLog("Event Handler => Switch Camera Failed => $e");
    }
  }

  Future<void> onSwitchMic() async {
    try {
      if (fakeLiveModel?.isMute == true) {
        fakeLiveModel?.isMute = false;
        update([AppConstant.onSwitchMic]);
        // await fakeLiveModel?.engine?.muteLocalAudioStream(false);
      } else {
        fakeLiveModel?.isMute = true;
        update([AppConstant.onSwitchMic]);
        // await fakeLiveModel?.engine?.muteLocalAudioStream(true);
      }
    } catch (e) {
      Utils.showLog("Event Handler => Switch Mic Failed => $e");
    }
  }

  Future<void> onStartChannelMediaRelay() async {
    try {
      // await fakeLiveModel?.engine?.startOrUpdateChannelMediaRelay(
      //   ChannelMediaRelayConfiguration(
      //     srcInfo: ChannelMediaInfo(
      //       channelName: fakeLiveModel?.host1Channel ?? "",
      //       token: fakeLiveModel?.host1Token ?? "",
      //       uid: 0,
      //     ),
      //     destInfos: [
      //       ChannelMediaInfo(
      //         channelName: fakeLiveModel?.host2Channel ?? "",
      //         token: fakeLiveModel?.host2Token ?? "",
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
      // await fakeLiveModel?.engine?.stopChannelMediaRelay();
    } catch (e) {
      Utils.showLog("Stop Channel Media Relay Failed => $e");
    }
  }

  Future<void> onChangeChannelMediaRelay(bool value) async {
    fakeLiveModel?.isChannelMediaRelay = value;
    update([AppConstant.onEventHandler]);
  }

  void onUpdateTopGiftUser({required List<PkGiftTopUserModel> users, required List<PkGiftTopUserModel> user2}) async {
    fakeLiveModel?.host1TopGiftUsers = users;
    fakeLiveModel?.host2TopGiftUsers = user2;

    update([AppConstant.onSeatUserUpdate]);
  }

  void updateGiftUsers() {
    math.Random random = math.Random();

    List<PkGiftTopUserModel> randomUsers = [];
    List<OtherUserProfileModel> fakeuser = FakeProfilesSet().generateUserProfiles(100);
    fakeuser.shuffle();
    fakeuser.asMap().forEach(
      (index, element) {
        randomUsers.add(PkGiftTopUserModel(userId: UserId(isProfilePicBanned: false, name: element.user!.name, image: element.user!.image, id: element.user!.id), id: "live_$index", totalCoins: random.nextInt(100000)));
      },
    );
    List<PkGiftTopUserModel> randomUsers2 = [];
    fakeuser.shuffle();
    fakeuser.asMap().forEach(
      (index, element) {
        randomUsers2.add(PkGiftTopUserModel(userId: UserId(isProfilePicBanned: false, name: element.user!.name, image: element.user!.image, id: element.user!.id), id: "live_$index", totalCoins: random.nextInt(100000)));
      },
    );
    onUpdateTopGiftUser(users: randomUsers, user2: randomUsers2);
  }

  void onChangeTopGiftUser({
    required List<PkGiftTopUserModel> host1,
    required List<PkGiftTopUserModel> host2,
  }) async {
    fakeLiveModel?.host1TopGiftUsers = host1;
    fakeLiveModel?.host2TopGiftUsers = host2;

    update([AppConstant.onSeatUserUpdate]);
  }

// >>>>> >>>>>> >>>> >>>>> >>>>> SOCKET EMIT METHOD <<<<< <<<<< <<<<< <<<<< <<<<<

  Future<void> onSendComment() async {
    if (fakeLiveModel?.commentController.text.trim().isNotEmpty ?? false) {
      fakeCommentList.add(HostComment(
        message: fakeLiveModel?.commentController.text.toString() ?? "",
        // user: , image: image
        user: Database.fetchLoginUserProfile()?.user?.name ?? "",
        image: ((Database.fetchLoginUserProfile()?.user?.image ?? "")),
      ));
      fakeLiveModel?.commentController.clear();
      update([AppConstant.onChangeComment]);
    }
  }

  Future<void> onSendPkRequest({required String host2UserId}) async {}

  Future<void> onCancelPkRequest({required String host2UserId}) async {}

  Future<void> onPkAnswer({required bool isAccept}) async {}

  Future<void> onPkEnd({required bool isManualMode}) async {}

  // >>>>> >>>>>> >>>> >>>>> >>>>> SOCKET LISTEN METHOD <<<<< <<<<< <<<<< <<<<< <<<<<

  void onListenPkEnd(dynamic data) {
    fakeLiveModel?.host1Rank = 0;
    fakeLiveModel?.host2Rank = 0;

    if (fakeLiveModel?.isHost == true) onStopChannelMediaRelay();
    onChangeChannelMediaRelay(false);

    if (data[SocketParams.isManualMode] == false || data[SocketParams.pkEndUserId] != fakeLiveModel?.host1UserId) {
      if (data[SocketParams.data][SocketParams.pkConfig][SocketParams.isWinner] == 1) {
        YouLostPkBottomSheet.onShow(
          h1Name: fakeLiveModel?.host1Name ?? "",
          h1Image: fakeLiveModel?.host1Image ?? "",
          h1IsBanned: fakeLiveModel?.host1ProfilePicIsBanned ?? false,
          h2Name: fakeLiveModel?.host2Name ?? "",
          h2Image: fakeLiveModel?.host2Image ?? "",
          h2IsBanned: fakeLiveModel?.host2ProfilePicIsBanned ?? false,
          h1Rank: data[SocketParams.data][SocketParams.pkConfig][SocketParams.localRank],
          h2Rank: data[SocketParams.data][SocketParams.pkConfig][SocketParams.remoteRank],
          isHost: fakeLiveModel?.isHost == true,
          battleAgainCallback: () {
            Get.back();
            InviteUserForPkBattleBottomSheet.onShow();
          },
        );
      } else if (data[SocketParams.data][SocketParams.pkConfig][SocketParams.isWinner] == 2) {
        YouWinPkBottomSheet.onShow(
          h1Name: fakeLiveModel?.host1Name ?? "",
          h1Image: fakeLiveModel?.host1Image ?? "",
          h1IsBanned: fakeLiveModel?.host1ProfilePicIsBanned ?? false,
          h2Name: fakeLiveModel?.host2Name ?? "",
          h2Image: fakeLiveModel?.host2Image ?? "",
          h2IsBanned: fakeLiveModel?.host2ProfilePicIsBanned ?? false,
          h1Rank: data[SocketParams.data][SocketParams.pkConfig][SocketParams.localRank],
          h2Rank: data[SocketParams.data][SocketParams.pkConfig][SocketParams.remoteRank],
          isHost: fakeLiveModel?.isHost == true,
          battleAgainCallback: () {
            Get.back();
            InviteUserForPkBattleBottomSheet.onShow();
          },
        );
      } else {
        TiePkBottomSheet.onShow(
          h1Name: fakeLiveModel?.host1Name ?? "",
          h1Image: fakeLiveModel?.host1Image ?? "",
          h1IsBanned: fakeLiveModel?.host1ProfilePicIsBanned ?? false,
          h2Name: fakeLiveModel?.host2Name ?? "",
          h2Image: fakeLiveModel?.host2Image ?? "",
          h2IsBanned: fakeLiveModel?.host2ProfilePicIsBanned ?? false,
          h1Rank: data[SocketParams.data][SocketParams.pkConfig][SocketParams.localRank],
          h2Rank: data[SocketParams.data][SocketParams.pkConfig][SocketParams.remoteRank],
          isHost: fakeLiveModel?.isHost == true,
          battleAgainCallback: () {
            Get.back();
            InviteUserForPkBattleBottomSheet.onShow();
          },
        );
      }
    }

    if (data[SocketParams.isManualMode] == true && data[SocketParams.pkEndUserId] == fakeLiveModel?.host1UserId) {
      // Get.back(); // Stop Live Steaming
    }
  }

  void onChangeViewCount(int value) {
    fakeLiveModel?.host1ViewCount = value;
    update([AppConstant.onChangeViewCount]);
  }

  void onPkRequestReceived(dynamic data) async {
    final jsonResponse = jsonDecode(data);

    if (jsonResponse[SocketParams.instantCutRequestByHost] == false) {
      // >>>>>>>>>> HOST_2_AGORA_INFO <<<<<<<<<<
      fakeLiveModel?.host2Uid = jsonResponse[SocketParams.host1Uid];
      fakeLiveModel?.host2Token = jsonResponse[SocketParams.host1Token];
      fakeLiveModel?.host2Channel = jsonResponse[SocketParams.host1Channel];
      fakeLiveModel?.host2LiveHistoryId = jsonResponse[SocketParams.host1LiveHistoryId];

      // >>>>>>>>>> HOST_2_USER_INFO <<<<<<<<<<
      fakeLiveModel?.host2UserId = jsonResponse[SocketParams.host1Id];
      fakeLiveModel?.host2Name = jsonResponse[SocketParams.host1Name];
      fakeLiveModel?.host2Image = jsonResponse[SocketParams.host1Image];
      fakeLiveModel?.host2UserName = jsonResponse[SocketParams.host1UserName];
      fakeLiveModel?.host2UniqueId = jsonResponse[SocketParams.host1UniqueId];
      fakeLiveModel?.host2ProfilePicIsBanned = jsonResponse[SocketParams.host1ProfilePicIsBanned];

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

  void onLiveViewer() async {
    FakeProfilesSet().sampleLiveViewers.shuffle();
    List<LiveViewerUserModel> liveViewers = [];
    log("object:::: )@ ${liveViewers.length}");
    List<OtherUserProfileModel> fakeuser = (FakeProfilesSet().generateUserProfiles(100).take(6).toList());
    fakeuser.shuffle();
    // liveViewers = FakeProfilesSet().generateUserProfiles(6).toList();
    fakeuser.asMap().forEach(
      (index, element) {
        liveViewers.add(LiveViewerUserModel(userId: element.user!.id, id: "live_$index", image: element.user!.image, name: element.user!.name, userName: element.user!.userName, avatarFrame: "", avtarFrameType: 3, isProfilePicBanned: false));
      },
    );
    fakeLiveModel?.liveViewers = liveViewers;

    update([AppConstant.onChangeViewCount]);
    Utils.showLog("Current Total Viewer => ${fakeLiveModel?.liveViewers.length}");
  }

  void onChangeRank({required int host1Rank, required int host2Rank, int? time}) async {
    fakeLiveModel?.host1Rank = host1Rank;
    fakeLiveModel?.host2Rank = host2Rank;
    update([AppConstant.onChangeRank]);

    if (fakeLiveModel?.isHost == false) {
      // onChangePkTime(isPkRequestUser: false, time: time);
    }

    // Utils.showLog("Updated Rank => H1=> ${fakeLiveModel?.host1Rank} => H2 => ${fakeLiveModel?.host2Rank}");
  }

  Timer? rankUpdateTimer;

  void startAutoRankChange() {
    log("Start Auto Rank Change");
    rankUpdateTimer?.cancel(); // cancel if already running

    rankUpdateTimer = Timer.periodic(Duration(seconds: 10), (_) {
      int randomRank1 = math.Random().nextInt(101); // from 0 to 100
      int randomRank2 = math.Random().nextInt(101);

      onChangeRank(host1Rank: randomRank1, host2Rank: randomRank2);

      Utils.showLog("Random Rank Updated: H1: $randomRank1 | H2: $randomRank2");
    });
  }

  // >>>>> >>>>>> >>>> >>>>> >>>>> DEFAULT METHOD <<<<< <<<<< <<<<< <<<<< <<<<<

  void onChangeLiveTime() {
    fakeLiveModel?.liveTimer = Timer.periodic(
      const Duration(seconds: 1),
      (timer) {
        fakeLiveModel?.liveCountTime++;
        update([AppConstant.onChangeLiveTime]);
      },
    );
  }

  void onChangePkTime() {
    fakeLiveModel?.pkTimer?.cancel();

    if (fakeLiveModel?.isChannelMediaRelay == true) {
      fakeLiveModel?.pkCountTime = 1500;
    } else {
      fakeLiveModel?.pkCountTime = 0;
    }

    fakeLiveModel?.pkTimer = Timer.periodic(
      const Duration(seconds: 1),
      (timer) {
        if (fakeLiveModel?.pkCountTime != 0) {
          fakeLiveModel?.pkCountTime--;
          update([AppConstant.onChangePkTime]);
          // Utils.showLog("Pk Battle Time => ${ConvertSecondToTime.onConvert(fakeLiveModel?.pkCountTime ?? 0)}");
        } else {
          fakeLiveModel?.pkCountTime = 1500;

          // if (fakeLiveModel?.isHost == true) onPkEnd(isManualMode: false);
        }
      },
    );
  }

  Future<void> onScrollAnimation() async {
    try {
      await 10.milliseconds.delay();
      fakeLiveModel?.scrollController.animateTo(
        fakeLiveModel?.scrollController.position.maxScrollExtent ?? 0,
        duration: Duration(seconds: 1),
        curve: Curves.fastOutSlowIn,
      );
    } catch (e) {
      Utils.showLog("Scroll Down Failed => $e");
    }
  }

  void onClickGift(BuildContext context) {
    FakeLiveGiftBottomSheetWidget.show(
      context: context,
      liveHistoryId: fakeLiveModel?.host1LiveHistoryId ?? "",
      receiverUserId: fakeLiveModel?.host1UserId ?? "",
    );
  }

  void onShowPkAnimation() async {
    await 1000.milliseconds.delay();
    isShowPkAnimation.value = true;
    await 1500.milliseconds.delay();
    isShowPkAnimation.value = false;
  }

  void onClickFollow() async {
    fakeLiveModel?.isFollow = !(fakeLiveModel?.isFollow ?? false);
    update([AppConstant.onClickFollow]);
  }
}
