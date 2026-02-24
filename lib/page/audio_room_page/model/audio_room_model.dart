import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:tingle/page/audio_room_page/model/audio_room_seat_users_model.dart';
import 'package:tingle/page/audio_room_page/model/fetch_audio_room_bloc_user_model.dart';
import 'package:tingle/page/audio_room_page/model/live_top_gift_user_model.dart';
import 'package:tingle/page/audio_room_page/model/live_viewer_user_model.dart';
import 'package:tingle/page/audio_room_page/model/reaction_model.dart';
import 'package:tingle/page/live_page/model/live_comment_model.dart';
import 'package:tingle/page/stream_page/model/fetch_live_user_model.dart';

class AudioRoomModel {
  // RtcEngine? engine;
  String token;
  String channel;
  String? streamSource;
  String liveHistoryId;
  String liveUserObjId;

  String roomName;
  String roomImage;
  String roomWelcome;

  bool isHost;
  String hostUserId;
  String hostUniqueId;
  int hostUid;
  int userUid;
  int audioLiveType;
  int audioRoomPrivateCode;

  int viewCount = 0;
  bool isAbleForSeatChange = true;
  bool isShowComments = false;
  List<LiveViewerUserModel> liveViewers = [];
  List<LiveCommentModel> liveComments = [];
  List<ReactionModel?> reactions = [];
  List<AudioRoomSeatUsersModel> seatUsers = [];
  ScrollController scrollController = ScrollController();
  TextEditingController commentController = TextEditingController();
  int mute = 0; // 0 None, 1 Mute, 2 UnMute, 3 Mute By Admin
  List<BlockedUsers> blockUsers = []; // BLOC USER LIST

  List<LiveTopGiftUserModel> liveTopGiftUsers = [];

  int audioRoomEarnedCoin = 0;

  List<Seat> audioRoomSeats; // SEAT LIST

  int? selectedSeat; // MY SEAT POSITION
  int? loadingSeatIndex; // SELECT SEAT TIME SHOW LOADING

  Timer? timer;
  bool? isFollow;
  bool hostIsMuted;

  String bgTheme;
  int? seatLength = 0;

  AudioRoomModel({
    // this.engine,
    required this.isHost,
    required this.hostUserId,
    required this.hostUniqueId,
    required this.hostUid,
    required this.hostIsMuted,
    required this.liveHistoryId,
    required this.liveUserObjId,
    required this.roomName,
    required this.roomImage,
    required this.roomWelcome,
    required this.token,
    required this.channel,
    required this.userUid,
    required this.audioLiveType,
    required this.audioRoomPrivateCode,
    required this.audioRoomSeats,
    required this.mute,
    this.streamSource,
    this.selectedSeat,
    this.loadingSeatIndex,
    this.timer,
    this.isFollow,
    this.viewCount = 0,
    required this.bgTheme,
    this.seatLength,
  });
}
