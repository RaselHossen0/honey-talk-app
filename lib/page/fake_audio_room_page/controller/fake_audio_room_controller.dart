import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tingle/common/widget/fake_audio_room_gift_bottom_sheet_widget.dart';
import 'package:tingle/database/fake_data/user_fake_data.dart';
import 'package:tingle/page/audio_room_page/model/audio_room_model.dart';
import 'package:tingle/page/audio_room_page/model/audio_room_seat_users_model.dart';
import 'package:tingle/page/audio_room_page/model/fetch_audio_room_bloc_user_model.dart';
import 'package:tingle/page/audio_room_page/model/live_viewer_user_model.dart';
import 'package:tingle/page/audio_room_page/model/reaction_model.dart';
import 'package:tingle/page/audio_room_page/widget/audio_room_seat_request_dialog_widget.dart';
import 'package:tingle/page/fake_live_page/widget/fake_comment_widget.dart';
import 'package:tingle/page/fake_other_user_profile_bottom_sheet/view/fake_other_user_profile_bottom_sheet.dart';
import 'package:tingle/page/live_page/model/live_comment_model.dart';
import 'package:tingle/page/stream_page/model/fetch_live_user_model.dart';
import 'package:tingle/utils/constant.dart';
import 'package:tingle/utils/database.dart';
import 'package:tingle/utils/socket_params.dart';
import 'package:tingle/utils/utils.dart';

class FakeAudioRoomController extends GetxController {
  int selectedTabIndex = 0;
  bool isShowTextField = true;

  AudioRoomModel? fakeAudioRoomModel;

  @override
  void onInit() {
    if (Get.arguments != null) {
      fakeAudioRoomModel = Get.arguments;
    }
    init();
    super.onInit();
  }

  @override
  void onClose() {
    time!.cancel();
    super.onClose();
  }

  void init() {
    onSeatAdd();
    onGetComment();
    addFakeComment();
    onStartVoiceAnimation();
    onInitReaction();
    addUserToSelected();
  }

  void addUserToSelected() {
    FakeAudioRoomGiftBottomSheetWidget.selectedUserId.value = fakeAudioRoomModel?.audioRoomSeats.map((user) => user.userId ?? "").where((id) => id.isNotEmpty).toList() ?? [];
    update([AppConstant.onSeatUpdate]);
  }

  void onSeatAdd() {
    fakeAudioRoomModel?.audioRoomSeats = List.generate(12, (index) {
      Random random = Random();
      return Seat(
        id: "seat_${index + 1}",
        position: index + 1,
        mute: random.nextBool() ? 1 : 0,
        lock: random.nextBool(),
        reserved: random.nextBool(),
        speaking: random.nextBool(),
        invite: random.nextBool(),
        userId: random.nextBool() ? FakeProfilesSet().generateUserProfiles(100)[index].user!.id : null,
        name: FakeProfilesSet().generateUserProfiles(100)[index].user!.name,
        image: FakeProfilesSet().generateUserProfiles(100)[index].user!.image,
        agoraUid: 10000 + index,
        coin: random.nextInt(1000), // coin between 0 to 999
      );
    });
    FakeProfilesSet().generateRandomSeats(count: 12);
    update();
  }

  Seat? selectedSeat;

  void onInitReaction() {
    fakeAudioRoomModel?.reactions = [];

    final seatLength = fakeAudioRoomModel?.audioRoomSeats.length ?? 0;

    for (int i = 0; i < seatLength; i++) {
      fakeAudioRoomModel?.reactions.add(null);
    }

    Utils.showLog("Reaction Init Length => ${fakeAudioRoomModel?.reactions.length}");
  }

  void onClickFollow() async {
    fakeAudioRoomModel?.isFollow = !(fakeAudioRoomModel?.isFollow ?? false);
    update([AppConstant.onClickFollow]);
  }

  void onToggleComment({bool? isShow}) {
    fakeAudioRoomModel?.isShowComments = isShow ?? !(fakeAudioRoomModel?.isShowComments ?? false);

    update([AppConstant.onToggleComment]);
    FocusManager.instance.primaryFocus?.unfocus();
    onScrollAnimation();
  }

  void onStartVoiceAnimation() async {
    fakeAudioRoomModel?.timer = Timer.periodic(
      Duration(seconds: 1),
      (timer) {
        for (int i = 0; i < (fakeAudioRoomModel?.reactions.length ?? 0); i++) {
          final index = fakeAudioRoomModel?.reactions[i];

          if (index != null && index.time < DateTime.now().second) {
            fakeAudioRoomModel?.reactions[i] = null;
            update([AppConstant.onSeatUpdate]);
            Utils.showLog("Reaction Removed Position=> $i");
          }
        }
      },
    );
  }

  Future<void> onDispose() async {}

  Future<void> onScrollAnimation() async {
    try {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (fakeAudioRoomModel!.scrollController.hasClients) {
          fakeAudioRoomModel?.scrollController.animateTo(
            fakeAudioRoomModel!.scrollController.position.maxScrollExtent,
            duration: Duration(milliseconds: 300),
            curve: Curves.easeOut,
          );
        }
      });
    } catch (e) {
      Utils.showLog("Scroll Down Failed => $e");
    }
  }

  void onChangeCommentTab(int index) {
    selectedTabIndex = index;
    update([AppConstant.onChangeCommentTab]);
  }

  void onChangeTextField(bool value) {
    isShowTextField = value;
    update([AppConstant.onChangeTextField]);
  }

  Seat? seat;
  int? indexStore;
  void onClickSeat({required int position, required BuildContext context, userId}) async {
    Seat currentSeat = fakeAudioRoomModel?.audioRoomSeats[position] ?? Seat();
    if (currentSeat.lock == true || (currentSeat.userId != null && currentSeat.userId!.isNotEmpty == true && currentSeat.userId != Database.loginUserId)) {
      FakeOtherUserProfileBottomSheet.show(
        context: context,
        userId: userId,
      );

      return;
    }
    if (seat == null) {
      indexStore = position;
      seat = Seat(
          userId: Database.loginUserId,
          position: position,
          mute: 0,
          lock: false,
          name: Database.fetchLoginUserProfile()?.user?.name ?? "",
          image: (Database.fetchLoginUserProfile()?.user?.image ?? ""),
          id: "seat_${position + 1}",
          reserved: false,
          agoraUid: 10000 + position,
          coin: 0,
          invite: false,
          speaking: false);
      fakeAudioRoomModel?.audioRoomSeats[position] = seat!;
      update([AppConstant.onSeatUpdate]);
    } else {
      if (position == indexStore) {
        fakeAudioRoomModel?.audioRoomSeats[indexStore!] = Seat();

        seat = null;

        update([AppConstant.onSeatUpdate]);

        return;
      }
      fakeAudioRoomModel?.audioRoomSeats[indexStore!] = Seat();
      seat = Seat(
          userId: Database.loginUserId,
          position: position,
          mute: 0,
          lock: false,
          name: Database.fetchLoginUserProfile()?.user?.name ?? "",
          image: (Database.fetchLoginUserProfile()?.user?.image ?? ""),
          id: "seat_${position + 1}",
          reserved: false,
          agoraUid: 10000 + position,
          coin: 0,
          invite: false,
          speaking: false);

      fakeAudioRoomModel?.audioRoomSeats[position] = seat!;
      indexStore = position;
      update([AppConstant.onSeatUpdate]);
    }
  }

  void onToggleLockSeat(int position) async {
    fakeAudioRoomModel?.loadingSeatIndex = position;
    update([AppConstant.onUpdateParticularSeat]);
    Get.back();
    if (fakeAudioRoomModel?.audioRoomSeats[position].lock == true) {
      onSeatLockedSocket(position: position, isLock: false);
    } else {
      onSeatLockedSocket(position: position, isLock: true);
    }
  }

  void onUnBlocUser(int index) async {
    onRemoveFromBlockedListSocket(userId: fakeAudioRoomModel?.blockUsers[index].blockedUserId?.id ?? "");
    fakeAudioRoomModel?.blockUsers.removeAt(index);
    update([AppConstant.onChangeUserBlockList]);
  }

  Future<void> onChangePosition({required int position}) async {
    fakeAudioRoomModel?.loadingSeatIndex = position;
    update([AppConstant.onUpdateParticularSeat]);

    int lastPosition = fakeAudioRoomModel?.selectedSeat ?? 0;
    fakeAudioRoomModel?.selectedSeat = fakeAudioRoomModel?.selectedSeat == position ? null : position;

    Utils.showLog("On Change Seat Position => Last => $lastPosition Current => ${fakeAudioRoomModel?.selectedSeat}");

    if (fakeAudioRoomModel?.selectedSeat != null) {
      if (fakeAudioRoomModel?.mute != 3) {
        fakeAudioRoomModel?.mute = 0;
      }
      onParticipantAddedSocket(fakeAudioRoomModel?.selectedSeat ?? 0);
      // await fakeAudioRoomModel?.engine?.setClientRole(role: ClientRoleType.clientRoleBroadcaster);
      // await fakeAudioRoomModel?.engine?.muteLocalAudioStream(true);
    } else {
      onParticipantRemoveSocket(position: lastPosition, userId: fakeAudioRoomModel?.audioRoomSeats[lastPosition].userId ?? "");
      // await fakeAudioRoomModel?.engine?.setClientRole(role: ClientRoleType.clientRoleAudience);
      // await fakeAudioRoomModel?.engine?.muteLocalAudioStream(true);
    }
    update([AppConstant.onSeatUpdate]);
  }

  void onUpdateMic() async {
    bool available = fakeAudioRoomModel?.audioRoomSeats.any((element) => element.userId == Database.loginUserId) ?? false;

    // MUTE => 0.NONE 1.MUTE 2.UN_MUTE 3.MUTE_BY_HOST_TO_USER

    if (fakeAudioRoomModel?.selectedSeat != null && available) {
      // Current My Mic Not Muted By Admin && Future Admin Mute My Mic
      if (fakeAudioRoomModel?.mute != 3 && fakeAudioRoomModel?.audioRoomSeats[fakeAudioRoomModel?.selectedSeat ?? 0].mute == 3) {
        fakeAudioRoomModel?.mute = 3; // Mute By Admin

        update([AppConstant.onSwitchMic]);

        // await fakeAudioRoomModel?.engine?.muteLocalAudioStream(true);

        // Current My Mic Muted By Admin && Future Admin UnMute My Mic
      } else if (fakeAudioRoomModel?.mute == 3 && fakeAudioRoomModel?.audioRoomSeats[fakeAudioRoomModel?.selectedSeat ?? 0].mute != 3) {
        fakeAudioRoomModel?.mute = 1; // Simple Mute Mic (But Not Mute By Admin)

        update([AppConstant.onSwitchMic]);

        // await fakeAudioRoomModel?.engine?.muteLocalAudioStream(true);
      }
    }

    Utils.showLog("IsAvailable $available => ${fakeAudioRoomModel?.mute}");

    if (available == false) {
      fakeAudioRoomModel?.selectedSeat = null;
      // await fakeAudioRoomModel?.engine?.muteLocalAudioStream(true);
      // await fakeAudioRoomModel?.engine?.setClientRole(role: ClientRoleType.clientRoleAudience);
      Utils.showLog("Admin Kick Out Me => ${fakeAudioRoomModel?.mute}");
    }
  }

  // >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> SOCKET LISTEN <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<

  void onSeatUserUpdateSocket(List<AudioRoomSeatUsersModel> value) async {
    fakeAudioRoomModel?.seatUsers = value;

    update([AppConstant.onSeatUserUpdate]);

    Utils.showLog("Current Total Seat User => ${fakeAudioRoomModel?.seatUsers.length}");
  }

  void onLiveViewerUserUpdateSocket(List<LiveViewerUserModel> value) async {
    fakeAudioRoomModel?.liveViewers = value;
    update([AppConstant.onChangeViewCount]);
    Utils.showLog("Current Total Viewer => ${fakeAudioRoomModel?.liveViewers.length}");
  }

  void onSeatUpdateSocket(List<Seat> value) async {
    fakeAudioRoomModel?.audioRoomSeats = value;
    fakeAudioRoomModel?.loadingSeatIndex = null;
    onUpdateMic(); // This Method Working Only If Admin Change My Mic...
    update([AppConstant.onSeatUpdate, AppConstant.onUpdateParticularSeat, AppConstant.onSwitchMic]);
  }

  void onGetInviteRequestSocket({required String name, required String image, required bool isMediaBanned, required int position}) {
    AudioRoomSeatRequestDialogWidget.onShow(
      name: name,
      image: image,
      isMediaBanned: isMediaBanned,
      position: position,
      onAccept: () async {
        Get.back();
        fakeAudioRoomModel?.mute = 0;
        onParticipantAddedSocket(position);
        fakeAudioRoomModel?.selectedSeat = position;
        // await fakeAudioRoomModel?.engine?.muteLocalAudioStream(true);
        // await fakeAudioRoomModel?.engine?.setClientRole(role: ClientRoleType.clientRoleBroadcaster);
      },
      onDecline: () {
        Get.back();
        onAudioRoomInviteRevokedSocket(position);
      },
    );
  }

  void onChangeViewCountSocket(int value) {
    fakeAudioRoomModel?.viewCount = value;
    update([AppConstant.onChangeViewCount]);
  }

  void onChangeUserBlockList(List<BlockedUsers> value) async {
    fakeAudioRoomModel?.blockUsers = value;
    update([AppConstant.onChangeUserBlockList]);
  }

  void onBlockedByAdmin() async {
    Utils.showToast(text: "You are blocked by admin");
    fakeAudioRoomModel?.selectedSeat = null;

    fakeAudioRoomModel?.mute = 0;
    update([AppConstant.onSwitchMic]);
    // await fakeAudioRoomModel?.engine?.muteLocalAudioStream(true);
    Get.back();
  }

  void onGetComment() {
    fakeHostCommentList.shuffle();

    fakeCommentList.addAll(fakeHostCommentList.take(10));
    onScrollAnimation();
    update([AppConstant.onChangeComment]);
  }

  Timer? time;
  addFakeComment() {
    time = Timer.periodic(const Duration(seconds: 7), (Timer timer) {
      addItems();
    });
  }

  List<HostComment> fakeCommentList = [];
  void addItems() {
    fakeHostCommentList.shuffle();

    fakeCommentList.add(fakeHostCommentList.first);
    onScrollAnimation();

    update([AppConstant.onChangeComment]);
  }

  Future<void> onListenEmojiSocket(dynamic data) async {
    if (data[SocketParams.position] != null) {
      fakeAudioRoomModel?.reactions[data[SocketParams.position]] = ReactionModel(
        position: data[SocketParams.position],
        image: data[SocketParams.image],
        senderName: data[SocketParams.senderName],
        senderImage: data[SocketParams.senderImage],
        senderProfilePicBanned: data[SocketParams.senderProfilePicBanned],
        time: data[SocketParams.time],
      );

      update([AppConstant.onSeatUpdate]);
    } else {
      fakeAudioRoomModel?.liveComments.add(
        LiveCommentModel(
          type: 4,
          name: data[SocketParams.senderName],
          image: "",
          commentText: "",
          isBanned: false,
          emoji: data[SocketParams.image],
        ),
      );
      onScrollAnimation();
      update([AppConstant.onChangeComment]);
    }
  }

  // >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> SOCKET EMIT <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<

  Future<void> onSendEmojiSocket({int? position, required String image}) async {
    fakeCommentList.add(HostComment(message: "", user: Database.fetchLoginUserProfile()?.user?.name ?? "", image: (Database.fetchLoginUserProfile()?.user?.image ?? ""), emoji: image, type: 2));

    onScrollAnimation();
    update([AppConstant.onChangeComment]);
  }

  Future<void> onSendComment() async {
    if (fakeAudioRoomModel?.commentController.text.trim().isNotEmpty ?? false) {
      fakeCommentList.add(
        HostComment(message: fakeAudioRoomModel!.commentController.text.trim(), user: Database.fetchLoginUserProfile()?.user?.name ?? "", image: (Database.fetchLoginUserProfile()?.user?.image ?? "")),
      );
      onScrollAnimation();
      fakeAudioRoomModel?.commentController.clear();
      update([AppConstant.onChangeComment]);
    }
  }

  void onEndAudioRoomSocket() async {
    if (fakeAudioRoomModel?.isHost == true) {
    } else {
      if (fakeAudioRoomModel?.selectedSeat != null) {
        onParticipantRemoveSocket(position: fakeAudioRoomModel?.selectedSeat ?? 0, userId: Database.loginUserId);
      }
    }
  }

  void onParticipantAddedSocket(int position) {}

  void onParticipantRemoveSocket({
    required int position,
    required String userId,
  }) {}

  void onAudioRoomInviteRevokedSocket(int position) {}

  void onRequestToJoinAudioRoomSocket({
    required int position,
    required String userId,
  }) {}

  void onSeatLockedSocket({required int position, required bool isLock}) {}

  void onSeatMutedSocket({required int position, required int mute, required String userId}) {}

  void onSeatCountModifiedSocket({required int seatCount}) {}

  void onAddToBlockedListSocket({required String userId}) {}

  void onRemoveFromBlockedListSocket({required String userId}) {}

  Future<void> onJoinChannel() async {
    try {
      // await fakeAudioRoomModel?.engine?.joinChannel(
      //   uid: fakeAudioRoomModel?.isHost == true ? (fakeAudioRoomModel?.hostUid ?? 0) : (fakeAudioRoomModel?.userUid ?? 0),
      //   token: fakeAudioRoomModel?.token ?? "",
      //   channelId: fakeAudioRoomModel?.channel ?? "",
      //   options: ChannelMediaOptions(),
      // );

      // await fakeAudioRoomModel?.engine?.enableAudio();
      // await fakeAudioRoomModel?.engine?.setClientRole(role: ClientRoleType.clientRoleAudience);
    } catch (e) {
      Utils.showLog("Event Handler => Join Channel Failed => $e");
    }
  }

  Future<void> onSwitchMic() async {
    try {
      if ((fakeAudioRoomModel?.audioRoomSeats.any((element) => element.userId == Database.loginUserId) ?? false)) {
        if (fakeAudioRoomModel?.mute != 3) {
          if (fakeAudioRoomModel?.mute == 1 || fakeAudioRoomModel?.mute == 0) {
            fakeAudioRoomModel?.mute = 2;
            update([AppConstant.onSwitchMic]);
          } else {
            fakeAudioRoomModel?.mute = 1;
            update([AppConstant.onSwitchMic]);
          }
        } else {
          Utils.showToast(text: "You are mute by admin");
        }
      } else {
        Utils.showToast(text: "You are not on seat");
      }
    } catch (e) {
      Utils.showLog("Event Handler => Switch Mic Failed => $e");
    }
  }

// >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> FETCH BLOCKED USER LIST <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
}
