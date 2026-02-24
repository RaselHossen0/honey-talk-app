import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';
import 'package:tingle/page/audio_room_page/model/audio_room_model.dart';
import 'package:tingle/page/audio_room_page/widget/private_audio_room_bottom_sheet_widget.dart';
import 'package:tingle/page/fake_live_page/model/fake_live_model.dart';
import 'package:tingle/page/live_page/model/live_model.dart';
import 'package:tingle/page/stream_page/controller/stream_controller.dart';
import 'package:tingle/page/stream_page/model/fetch_live_user_model.dart';
import 'package:tingle/page/stream_page/widget/stream_gridview_item_widget.dart';
import 'package:tingle/page/stream_page/widget/stream_pk_item_widget.dart';
import 'package:tingle/routes/app_routes.dart';
import 'package:tingle/utils/database.dart';
import 'package:tingle/utils/utils.dart';

class StreamTabItemWidget extends GetView<StreamController> {
  const StreamTabItemWidget({super.key, required this.indexData});

  final LiveUserList indexData;

  @override
  Widget build(BuildContext context) {
    return controller.selectedTabIndex == 2
        ? StreamPkItemWidget(
            indexData: indexData,
            callback: () => onClickLiveUser(indexData),
          )
        : StreamGridviewItemWidget(
            name: indexData.name ?? "",
            userName: indexData.userName ?? "",
            isBanned: false,
            image: indexData.liveType == 3 ? (indexData.pkThumbnails?[0] ?? "") : indexData.image ?? "",
            isVerify: indexData.isVerified ?? false,
            countryFlag: indexData.countryFlagImage ?? "",
            viewCount: indexData.view ?? 0,
            liveType: indexData.liveType ?? 0,
            callback: () => onClickLiveUser(indexData),
          );
  }
}

void onClickLiveUser(LiveUserList indexData) {
  final controller = Get.find<StreamController>();
  (indexData.isFake ?? true)
      ? indexData.liveType == 2
          ? onClickFakeAudioRoom(
              indexData: indexData,
              callback: () => controller.onRefresh(),
            )
          : onClickFakeLive(
              indexData: indexData,
              callback: () => controller.onRefresh(),
            )
      : indexData.liveType == 2
          ? onClickAudioRoom(
              indexData: indexData,
              callback: () => controller.onRefresh(),
            )
          : onClickLive(
              indexData: indexData,
              callback: () => controller.onRefresh(),
            );
}

void onClickFakeLive({required LiveUserList indexData, required Callback callback}) {
  Get.toNamed(
    AppRoutes.fakeLivePage,
    arguments: FakeLiveModel(
      isHost: false,

      isFollow: indexData.isFollow ?? false,
      liveType: indexData.liveType ?? 0,
      isChannelMediaRelay:
          // (indexData.host2LiveId != null && (indexData.host2LiveId?.trim().isNotEmpty ?? false)) ||
          indexData.liveType == 3,

      // >>>>>>>>>> NEW VARIABLE <<<<<<<<<<
      country: indexData.country ?? "",
      host2IsProfilePicBanned: indexData.host2IsProfilePicBanned ?? false,
      isProfilePicBanned: indexData.isProfilePicBanned ?? false,
      pkStreamSources: indexData.pkStreamSources ?? [],
      pkThumbnails: indexData.pkThumbnails ?? [],
      streamSource: indexData.streamSource ?? "",
      view: indexData.view ?? 0,

      // >>>>>>>>>> HOST_1_AGORA_INFO <<<<<<<<<<
      host1Token: indexData.token ?? "",
      host1Channel: indexData.channel ?? "",
      host1Uid: indexData.agoraUid ?? 0,
      host1LiveHistoryId: indexData.liveHistoryId ?? "",

      // >>>>>>>>>> HOST_1_USER_INFO <<<<<<<<<<

      host1UserId: indexData.userId ?? "",
      host1Name: indexData.name ?? "",
      host1UserName: indexData.userName ?? "",
      host1Image: indexData.image ?? "",
      host1UniqueId: "",
      host1ProfilePicIsBanned: false,
      host1WealthLevelImage: indexData.wealthLevelImage ?? "",
      host1Coin: indexData.coin ?? 0,

      // >>>>>>>>>> HOST_2_USER_INFO <<<<<<<<<<

      host2UserId: indexData.host2Id ?? "",
      host2Name: indexData.host2Name ?? "",
      host2UserName: indexData.host2userName ?? "",
      host2UniqueId: indexData.host2UniqueId ?? "",
      host2Image: indexData.host2Image ?? "",
      host2ProfilePicIsBanned: false,
      host2WealthLevelImage: indexData.host2wealthLevelImage ?? "",
      host2Coin: indexData.host2Coin ?? 0,

      // >>>>>>>>>> HOST_2_AGORA_INFO <<<<<<<<<<

      host2Uid: (100000 + Random().nextInt(900000)),
      host2LiveHistoryId: indexData.host2LiveId ?? "",
      host2Token: indexData.host2Token ?? "",
      host2Channel: indexData.host2Channel ?? "",
    ),
  )?.then((value) => callback.call());
}

void onClickLive({required LiveUserList indexData, required Callback callback}) {
  Get.toNamed(
    AppRoutes.livePage,
    arguments: LiveModel(
      isHost: false,
      isFollow: indexData.isFollow ?? false,
      liveType: indexData.liveType ?? 0,
      isChannelMediaRelay: (indexData.host2LiveId != null && (indexData.host2LiveId?.trim().isNotEmpty ?? false)),

      // >>>>>>>>>> HOST_1_AGORA_INFO <<<<<<<<<<
      host1Token: indexData.token ?? "",
      host1Channel: indexData.channel ?? "",
      host1Uid: indexData.agoraUid ?? 0,
      host1LiveHistoryId: indexData.liveHistoryId ?? "",

      // >>>>>>>>>> HOST_1_USER_INFO <<<<<<<<<<

      host1UserId: indexData.userId ?? "",
      host1Name: indexData.name ?? "",
      host1UserName: indexData.userName ?? "",
      host1Image: indexData.image ?? "",
      host1UniqueId: indexData.uniqueId ?? "",
      host1ProfilePicIsBanned: false,
      host1WealthLevelImage: indexData.wealthLevelImage ?? "",
      host1Coin: indexData.coin ?? 0,

      // >>>>>>>>>> HOST_2_USER_INFO <<<<<<<<<<

      host2UserId: indexData.host2Id ?? "",
      host2Name: indexData.host2Name ?? "",
      host2UserName: indexData.host2userName ?? "",
      host2UniqueId: indexData.host2UniqueId ?? "",
      host2Image: indexData.host2Image ?? "",
      host2ProfilePicIsBanned: false,
      host2WealthLevelImage: indexData.host2wealthLevelImage ?? "",
      host2Coin: indexData.host2Coin ?? 0,

      // >>>>>>>>>> HOST_2_AGORA_INFO <<<<<<<<<<

      host2Uid: (100000 + Random().nextInt(900000)),
      host2LiveHistoryId: indexData.host2LiveId ?? "",
      host2Token: indexData.host2Token ?? "",
      host2Channel: indexData.host2Channel ?? "",
    ),
  )?.then((value) => callback.call());
}

void onClickAudioRoom({required LiveUserList indexData, required Callback callback}) async {
  if (indexData.liveType == 2) {
    if (indexData.audioLiveType == 1) {
      // Private Room

      PrivateAudioRoomBottomSheetWidget.show(
        password: indexData.privateCode ?? 0,
        callBack: () {
          onJoinAudioRoom(indexData: indexData, callback: callback);
        },
      );
    } else if (indexData.audioLiveType == 2) {
      // Public Room
      onJoinAudioRoom(indexData: indexData, callback: callback);
    }
  }
}

void onClickFakeAudioRoom({required LiveUserList indexData, required Callback callback}) async {
  if (indexData.liveType == 2) {
    if (indexData.audioLiveType == 1) {
      // Private Room

      PrivateAudioRoomBottomSheetWidget.show(
        password: indexData.privateCode ?? 0,
        callBack: () {
          onFakeJoinAudioRoom(indexData: indexData, callback: callback);
        },
      );
    } else if (indexData.audioLiveType == 0) {
      // Public Room
      Utils.showLog("Fake Audio Room");
      onFakeJoinAudioRoom(indexData: indexData, callback: callback);
    }
  }
}

void onJoinAudioRoom({required LiveUserList indexData, required Callback callback}) {
  if (indexData.blockedUsers?.contains(Database.loginUserId) == false) {
    Utils.showLog("Join Audio Room ${indexData.toJson()}");
    Get.toNamed(
      AppRoutes.audioRoomPage,
      arguments: AudioRoomModel(
        streamSource: indexData.streamSource ?? "",
        isHost: false,
        hostUserId: indexData.userId ?? "",
        hostUid: indexData.agoraUid ?? 0,
        hostIsMuted: false,
        mute: 0,
        liveHistoryId: indexData.liveHistoryId ?? "",
        liveUserObjId: indexData.id ?? "",
        roomName: indexData.roomName ?? "",
        roomImage: indexData.roomImage ?? "",
        roomWelcome: indexData.roomWelcome ?? "",
        token: indexData.token ?? "",
        channel: indexData.channel ?? "",
        userUid: (100000 + Random().nextInt(900000)),
        audioLiveType: indexData.audioLiveType ?? 0,
        audioRoomPrivateCode: indexData.privateCode ?? 0,
        audioRoomSeats: indexData.seat ?? [],
        isFollow: indexData.isFollow ?? false,
        bgTheme: indexData.bgTheme ?? "",
        hostUniqueId: indexData.uniqueId ?? "",
      ),
    )?.then((value) => callback.call());
  } else {
    Utils.showToast(text: "You are blocked by admin");
  }
}

void onFakeJoinAudioRoom({required LiveUserList indexData, required Callback callback}) {
  if (indexData.blockedUsers?.contains(Database.loginUserId) == false) {
    Utils.showLog("Join Audio Room ${indexData.toJson()}");
    Get.toNamed(
      AppRoutes.fakeAudioRoomPage,
      arguments: AudioRoomModel(
        streamSource: indexData.streamSource ?? "",
        isHost: false,
        hostUserId: indexData.userId ?? "",
        hostUid: indexData.agoraUid ?? 0,
        hostIsMuted: false,
        mute: 0,
        liveHistoryId: indexData.liveHistoryId ?? "",
        liveUserObjId: indexData.id ?? "",
        roomName: indexData.roomName ?? "",
        roomImage: indexData.roomImage ?? "",
        roomWelcome: indexData.roomWelcome ?? "",
        token: indexData.token ?? "",
        channel: indexData.channel ?? "",
        userUid: (100000 + Random().nextInt(900000)),
        audioLiveType: indexData.audioLiveType ?? 0,
        audioRoomPrivateCode: indexData.privateCode ?? 0,
        audioRoomSeats: indexData.seat ?? [],
        isFollow: indexData.isFollow ?? false,
        bgTheme: indexData.bgTheme ?? "",
        viewCount: indexData.view ?? 0,
        hostUniqueId: "",
      ),
    )?.then((value) => callback.call());
  } else {
    Utils.showToast(text: "You are blocked by admin");
  }
}
