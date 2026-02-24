import 'dart:isolate';

import 'package:tingle/common/api/fetch_friends_api.dart';
import 'package:tingle/common/model/fetch_friends_model.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tingle/custom/function/custom_image_picker.dart';
import 'package:tingle/custom/function/custom_multi_image_picker.dart';
import 'package:tingle/custom/widget/custom_image_picker_bottom_sheet_widget.dart';
import 'package:tingle/firebase/authentication/firebase_access_token.dart';
import 'package:tingle/firebase/authentication/firebase_uid.dart';
import 'package:tingle/page/upload_feed_page/api/fetch_all_hashtag_api.dart';
import 'package:tingle/page/upload_feed_page/model/fetch_all_hashtag_model.dart';
import 'package:tingle/page/upload_feed_page/model/upload_feed_model.dart';

import 'package:tingle/utils/constant.dart';
import 'package:tingle/utils/enums.dart';
import 'package:tingle/utils/internet_connection.dart';
import 'package:tingle/utils/utils.dart';

class UploadFeedController extends GetxController {
  ScrollController friendScrollController = ScrollController();

  String token = "";
  String uid = "";

  List<String> selectedImages = [];
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

  UploadFeedModel? uploadFeedModel;

  @override
  void onInit() {
    init();
    super.onInit();
  }

  void init() async {
    isLoadingHashtag = true;
    selectedImages.clear();
    captionController.clear();
    selectedHashtagIds.clear();

    uid = FirebaseUid.onGet() ?? "";
    token = await FirebaseAccessToken.onGet() ?? "";

    await onGetHashtag();
    onRefreshFriend();
  }

  void onSelectNewImage(BuildContext context) async {
    await CustomImagePickerBottomSheetWidget.show(
      context: context,
      onClickGallery: () async {
        final List<String> images = await CustomMultiImagePicker.pickImage();

        if (images.isNotEmpty) {
          for (int i = 0; i < images.length; i++) {
            if (selectedImages.length < 5) {
              selectedImages.add(images[i]);
            } else {
              break;
            }
          }
          update([AppConstant.onChangeImages]);
        }
      },
      onClickCamera: () async {
        final String? imagePath = await CustomImagePicker.pickImage(ImageSource.camera);
        if (imagePath != null) {
          selectedImages.add(imagePath);
          update([AppConstant.onChangeImages]);
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

  void onCancelImage(int index) {
    selectedImages.removeAt(index);
    update([AppConstant.onChangeImages]);
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
    if (selectedImages.isEmpty) {
      Utils.showToast(text: EnumLocal.txtPleaseSelectPost.name.tr);
    } else {
      Utils.showToast(text: EnumLocal.txtPostUploading.name.tr);

      if (InternetConnection.isConnect.value) {
        // Get.dialog(PopScope(canPop: false, child: const CustomLoadingWidget()), barrierDismissible: false); // Start Loading...
        Get.back();
        try {
          var receivePort = ReceivePort();

          receivePort.listen(
            (message) {
              Utils.showLog("Received message from isolate $message");
            },
          );
        } catch (e) {
          Utils.showLog("isolate failed => $e");
        }
      } else {
        Utils.showToast(text: EnumLocal.txtNoInternetConnection.name.tr);
      }
    }
  }
}
