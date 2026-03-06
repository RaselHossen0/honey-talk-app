import 'dart:async';

import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:flutter/cupertino.dart';
import 'package:tingle/page/audio_room_page/model/live_top_gift_user_model.dart';
import 'package:tingle/page/audio_room_page/model/live_viewer_user_model.dart';
import 'package:tingle/page/live_page/model/live_comment_model.dart';
import 'package:tingle/page/live_page/model/pk_gift_top_user_model.dart';

class LiveModel {
  int liveType;
  bool isHost;
  bool? isFollow;
  bool isChannelMediaRelay = false;

  // >>>>>>>>>> HOST_1_AGORA_INFO <<<<<<<<<<
  String host1LiveHistoryId;
  String host1Token;
  String host1Channel;
  int host1Uid;

  // >>>>>>>>>> HOST_1_USER_INFO <<<<<<<<<<
  String host1UserId;
  String host1Name;
  String host1UserName;
  String host1UniqueId;
  String host1WealthLevelImage;
  String host1Image;
  bool host1ProfilePicIsBanned;
  int host1Coin;

  // >>>>>>>>>> HOST_2_AGORA_INFO <<<<<<<<<<
  int host2Uid;
  String host2Channel;
  String host2Token;
  String host2LiveHistoryId;

  // >>>>>>>>>> HOST_2_USER_INFO <<<<<<<<<<
  String host2UserId;
  String host2Name;
  String host2UserName;
  String host2UniqueId;
  String host2WealthLevelImage;
  String host2Image;
  bool host2ProfilePicIsBanned;
  int host2Coin;

  // >>>>>>>>>> GIFT SHOW PARAMETER <<<<<<<<<<
  int? liveGiftType;
  String? liveGiftUrl;

  // >>>>>>>>>> NOT PASS PARAMETER <<<<<<<<<<

  RtcEngine? engine;
  Timer? liveTimer;
  Timer? pkTimer;
  int liveCountTime = 0;
  int pkCountTime = 0;
  bool isLoading = true;
  bool isMute = false;
  int host1ViewCount = 0;
  int host1Rank = 0;
  int host2Rank = 0;
  int liveEarnedCoin = 0;
  List<LiveTopGiftUserModel> liveTopGiftUsers = [];
  List<LiveCommentModel> liveComments = [];
  List<LiveViewerUserModel> liveViewers = [];
  List<PkGiftTopUserModel> host1TopGiftUsers = [];
  List<PkGiftTopUserModel> host2TopGiftUsers = [];
  ScrollController scrollController = ScrollController();
  TextEditingController commentController = TextEditingController();

  LiveModel({
    required this.liveType,
    required this.isHost,
    this.isFollow,
    required this.isChannelMediaRelay,

    // >>>>>>>>>> HOST_1_AGORA_INFO <<<<<<<<<<

    required this.host1Uid,
    required this.host1Token,
    required this.host1Channel,
    required this.host1LiveHistoryId,

    // >>>>>>>>>> HOST_1_USER_INFO <<<<<<<<<<

    required this.host1UserId,
    required this.host1Name,
    required this.host1UserName,
    required this.host1UniqueId,
    required this.host1WealthLevelImage,
    required this.host1Image,
    required this.host1ProfilePicIsBanned,
    required this.host1Coin,

    // >>>>>>>>>> GIFT SHOW PARAMETER <<<<<<<<<<

    this.liveGiftType,
    this.liveGiftUrl,

    // >>>>>>>>>> HOST_2_AGORA_INFO <<<<<<<<<<

    required this.host2Channel,
    required this.host2Token,
    required this.host2LiveHistoryId,
    required this.host2Uid,

    // >>>>>>>>>> HOST_2_USER_INFO <<<<<<<<<<

    required this.host2UserId,
    required this.host2Name,
    required this.host2UserName,
    required this.host2UniqueId,
    required this.host2WealthLevelImage,
    required this.host2Image,
    required this.host2ProfilePicIsBanned,
    required this.host2Coin,
  });
}
