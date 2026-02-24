import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tingle/common/api/fetch_friends_api.dart';
import 'package:tingle/common/model/fetch_friends_model.dart';
import 'package:tingle/firebase/authentication/firebase_access_token.dart';
import 'package:tingle/firebase/authentication/firebase_uid.dart';
import 'package:tingle/page/feed_page/model/fetch_post_model.dart';
import 'package:tingle/page/upload_feed_page/api/fetch_all_hashtag_api.dart';
import 'package:tingle/page/upload_feed_page/model/fetch_all_hashtag_model.dart';
import 'package:tingle/utils/api_params.dart';
import 'package:tingle/utils/constant.dart';
import 'package:tingle/utils/enums.dart';
import 'package:tingle/utils/internet_connection.dart';
import 'package:tingle/utils/utils.dart';

class EditFeedController extends GetxController {
  ScrollController friendScrollController = ScrollController();

  String token = "";
  String uid = "";

  // GET ARGUMENT FROM POST
  String postId = "";
  List<PostImage> postImages = [];
  List<String> selectedHashtagIds = [];
  List<String> mentionedUserIds = [];
  TextEditingController captionController = TextEditingController();

  // Fetch Hashtag Object
  bool isLoadingHashtag = false;
  FetchAllHashtagModel? fetchAllHashtagModel;
  List<Data> hashtags = [];

  // Fetch Friend Object
  bool isLoadingFriend = false;
  bool isPaginationFriend = false;
  List<Friends> friends = [];
  FetchFriendsModel? fetchFriendsModel;

  @override
  void onInit() {
    init();
    super.onInit();
  }

  void init() async {
    isLoadingHashtag = true;
    postImages.clear();
    captionController.clear();
    selectedHashtagIds.clear();

    final arguments = Get.arguments;
    Utils.showLog("Post Argument => $arguments");

    postId = arguments[ApiParams.postId] ?? "";
    postImages = arguments[ApiParams.postImage] ?? [];
    captionController.text = arguments[ApiParams.caption] ?? "";
    selectedHashtagIds = arguments[ApiParams.hashTagId] ?? [];

    uid = FirebaseUid.onGet() ?? "";
    token = await FirebaseAccessToken.onGet() ?? "";

    await onGetHashtag();
    onRefreshFriend();
  }

  void onToggleHashtag(int index) {
    try {
      if (selectedHashtagIds.contains(hashtags[index].sId)) {
        selectedHashtagIds.remove(hashtags[index].sId ?? "");
      } else {
        selectedHashtagIds.add(hashtags[index].sId ?? "");
      }
      update([AppConstant.onToggleHashtag]);
    } catch (e) {
      Utils.showLog("Toggle Hashtag Failed => $e");
    }
  }

  Future<void> onGetHashtag() async {
    fetchAllHashtagModel = await FetchAllHashtagApi.callApi(token: token, uid: uid);
    hashtags = fetchAllHashtagModel?.data ?? [];
    isLoadingHashtag = false;
    update([AppConstant.onToggleHashtag]);
  }

  Future<void> onRefreshFriend() async {
    isLoadingFriend = true;

    friends.clear();
    update([AppConstant.onGetFriend]);
    await onGetFriend();
  }

  Future<void> onGetFriend() async {
    fetchFriendsModel = await FetchFriendsApi.callApi(uid: uid, token: token);
    friends.addAll(fetchFriendsModel?.friends ?? []);

    isLoadingFriend = false;
    update([AppConstant.onGetFriend]);
  }

  void onFriendPagination() async {
    if (friendScrollController.position.pixels == friendScrollController.position.maxScrollExtent && isPaginationFriend == false) {
      isPaginationFriend = true;
      update([AppConstant.onFriendPagination]);
      await onGetFriend();
      isPaginationFriend = false;
      update([AppConstant.onFriendPagination]);
    }
  }

  void onChangeMentionUser(String id) async {
    if (mentionedUserIds.contains(id)) {
      mentionedUserIds.remove(id);
    } else {
      mentionedUserIds.add(id);
    }
    update([AppConstant.onGetFriend]);
  }

  Future<void> onUploadPost() async {
    if (InternetConnection.isConnect.value) {
    } else {
      Utils.showToast(text: EnumLocal.txtNoInternetConnection.name.tr);
    }
  }
}
