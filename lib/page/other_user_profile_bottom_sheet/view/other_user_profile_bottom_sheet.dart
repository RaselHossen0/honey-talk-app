import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tingle/common/api/fetch_other_user_profile_api.dart';
import 'package:tingle/common/api/fetch_user_wise_post_api.dart';
import 'package:tingle/common/api/fetch_user_wise_video_api.dart';
import 'package:tingle/common/model/fatch_other_user_profile_model.dart';
import 'package:tingle/common/shimmer/other_user_profile_shimmer_widget.dart';
import 'package:tingle/firebase/authentication/firebase_access_token.dart';
import 'package:tingle/firebase/authentication/firebase_uid.dart';
import 'package:tingle/page/feed_page/model/fetch_post_model.dart';
import 'package:tingle/page/feed_video_page/model/fetch_video_model.dart';
import 'package:tingle/page/other_user_profile_bottom_sheet/widget/other_user_follow_chat_widget.dart';
import 'package:tingle/page/other_user_profile_bottom_sheet/widget/other_user_tab_bar_widget.dart';
import 'package:tingle/page/profile_page/api/fetch_other_user_profile_api.dart';
import 'package:tingle/page/profile_page/model/fetch_user_profile_model.dart';

import 'package:tingle/utils/database.dart';
import 'package:tingle/utils/utils.dart';

class OtherUserProfileBottomSheet {
  static OtherUserProfileModel? otherUserProfileModel;
  static FetchUserProfileModel? fetchUserProfileModel;
  static final scrollController = ScrollController();
  static RxInt selectedTabIndex = 0.obs;
  static RxBool isLoading = true.obs;
  static bool isFollowed = false;
  static List<Post> userPosts = [];
  static bool isLoadingPost = false;
  static bool isLoadingVideo = false;
  static bool isInitialized = false;
  static FetchVideoModel? fetchVideoModel;
  static List<VideoData> userVideos = [];
  static final uid = FirebaseUid.onGet() ?? "";

  static RxString userid = "".obs;

  static void onChangeBottomBar(int index) {
    if (index != selectedTabIndex.value) {
      selectedTabIndex.value = index;
    }
  }

  static Future<void> fetchProfile() async {
    isLoading.value = true;
    final token = await FirebaseAccessToken.onGet() ?? "";

    otherUserProfileModel = await FetchOtherUserProfileInfoApi.callApi(uid: uid, token: token, toUserId: userid.value);

    fetchUserProfileModel = await FetchOtherUserProfileApi.callApi(token: token, uid: uid, toUserId: userid.value);

    isFollowed = otherUserProfileModel?.user?.isFollowed ?? false;
    isLoading.value = false;
  }

  static Future<void> onClickFollow() async {
    if (otherUserProfileModel?.user?.id != Database.loginUserId) {
      isFollowed = !isFollowed;
    }
  }

  // Fetch posts
  static Future<void> fetchPosts() async {
    isLoadingPost = true;
    final token = await FirebaseAccessToken.onGet() ?? "";
    final postModel = await FetchUserWisePostApi.callApi(uid: uid, token: token, toUserId: userid.value);
    userPosts = postModel?.post ?? [];

    isLoadingPost = false;
  }

  static Future<void> fetchVideo() async {
    isLoadingVideo = true;
    final token = await FirebaseAccessToken.onGet() ?? "";
    fetchVideoModel = await FetchUserWiseVideoApi.callApi(uid: uid, token: token, toUserId: userid.value);
    userVideos.addAll(fetchVideoModel?.data ?? []);

    isLoadingVideo = false;
  }

  static Future<void> onTabBar(int index) async {
    selectedTabIndex.value = index;
  }

  static Future<void> loadInitialData() async {
    try {
      isLoading.value = true;

      await Future.wait([
        fetchProfile(),
        fetchPosts(),
        fetchVideo(),
      ]);
    } catch (e) {
      // Handle any errors that occurred during the API calls
      Utils.showLog("Error loading initial data: $e");
    } finally {
      // This will run whether successful or not
      isLoading.value = false;
    }
  }

  static void show({
    required BuildContext context,
    required String userId,
  }) async {
    userid.value = userId;

    loadInitialData();

    await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Container(
            height: Get.height * 0.9,
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
            ),
            child: Obx(() {
              return (isLoading.value)
                  ? const OtherUserProfileShimmerWidget()
                  : Stack(
                      children: [
                        Column(
                          children: [
                            Expanded(
                              child: Stack(
                                children: [
                                  SingleChildScrollView(controller: scrollController, child: OtherUserProfileTabBarWidget()),
                                ],
                              ),
                            ),
                          ],
                        ),
                        userId == Database.loginUserId ? 0.height : OtherUserFollowChatWidget()
                      ],
                    );
            }));
      },
    );
  }
}
//new
