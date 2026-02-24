import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tingle/common/api/fetch_friends_api.dart';
import 'package:tingle/common/model/fetch_friends_model.dart';
import 'package:tingle/custom/function/custom_image_picker.dart';
import 'package:tingle/custom/widget/custom_image_picker_bottom_sheet_widget.dart';
import 'package:tingle/firebase/authentication/firebase_access_token.dart';
import 'package:tingle/firebase/authentication/firebase_uid.dart';
import 'package:tingle/page/upload_feed_page/api/fetch_all_hashtag_api.dart';
import 'package:tingle/page/upload_feed_page/model/fetch_all_hashtag_model.dart';
import 'package:tingle/utils/api_params.dart';
import 'package:tingle/utils/constant.dart';
import 'package:tingle/utils/enums.dart';

import 'package:tingle/utils/utils.dart';

class UploadVideoController extends GetxController {
  TextEditingController captionController = TextEditingController();

  String token = "";
  String uid = "";

  // GET ARGUMENT FROM PREVIEW VIDEO PAGE
  int videoTime = 0;
  String videoUrl = "";
  String videoThumbnail = "";
  String songId = "";

  // FETCH ALL HASHTAG
  bool isLoadingHashtag = false;
  FetchAllHashtagModel? fetchAllHashtagModel;
  List<Data> hashtags = [];

  // SELECTED HASHTAG AND MENTION USER
  List<String> mentionedUserIds = [];
  List<String> selectedHashtagIds = [];

  // Fetch Friend Object
  bool isLoadingFriend = false;
  bool isPaginationFriend = false;
  List<Friends> friends = [];
  FetchFriendsModel? fetchFriendsModel;
  ScrollController friendScrollController = ScrollController();

  @override
  void onInit() {
    init();
    super.onInit();
  }

  void init() async {
    isLoadingHashtag = true;
    captionController.clear();
    selectedHashtagIds.clear();

    final arguments = Get.arguments;
    Utils.showLog("Video Argument => $arguments");

    videoUrl = arguments[ApiParams.video] ?? "";
    videoThumbnail = arguments[ApiParams.image] ?? "";
    videoTime = arguments[ApiParams.time] ?? "";
    songId = arguments[ApiParams.songId] ?? "";

    onGetHashtag();
    onRefreshFriend();
  }

  Future<void> onGetToken() async {
    uid = FirebaseUid.onGet() ?? "";
    token = await FirebaseAccessToken.onGet() ?? "";
  }

  Future<void> onGetHashtag() async {
    await onGetToken();
    fetchAllHashtagModel = await FetchAllHashtagApi.callApi(token: token, uid: uid);
    hashtags = fetchAllHashtagModel?.data ?? [];
    isLoadingHashtag = false;
    update([AppConstant.onToggleHashtag]);
  }

  Future<void> onRefreshFriend() async {
    isLoadingFriend = true;
    friends.clear();
    update([AppConstant.onGetFriend]);
    await onGetToken();
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

  void onChangeMentionUser(String id) {
    if (mentionedUserIds.contains(id)) {
      mentionedUserIds.remove(id);
    } else {
      mentionedUserIds.add(id);
    }
    update([AppConstant.onGetFriend]);
  }

  Future<void> onChangeThumbnail(BuildContext context) async {
    await CustomImagePickerBottomSheetWidget.show(
      context: context,
      onClickCamera: () async {
        final imagePath = await CustomImagePicker.pickImage(ImageSource.camera);

        if (imagePath != null) {
          videoThumbnail = imagePath;
          update([AppConstant.onChangeThumbnail]);
        }
      },
      onClickGallery: () async {
        final imagePath = await CustomImagePicker.pickImage(ImageSource.gallery);

        if (imagePath != null) {
          videoThumbnail = imagePath;
          update([AppConstant.onChangeThumbnail]);
        }
      },
    );
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

  Future<void> onUploadVideo() async {
    Utils.showToast(text: EnumLocal.txtVideoUploading.name.tr);
  }
}
