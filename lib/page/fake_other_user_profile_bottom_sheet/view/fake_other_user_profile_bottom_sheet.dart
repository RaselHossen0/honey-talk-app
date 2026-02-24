import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:tingle/common/model/fatch_other_user_profile_model.dart';
import 'package:tingle/common/shimmer/other_user_profile_shimmer_widget.dart';

import 'package:tingle/database/fake_data/user_fake_data.dart';
import 'package:tingle/page/fake_other_user_profile_bottom_sheet/widget/fake_other_user_profile_data_tab_widget.dart';
import 'package:tingle/page/fake_other_user_profile_bottom_sheet/widget/fake_other_user_profile_details_widget.dart';
import 'package:tingle/page/fake_other_user_profile_bottom_sheet/widget/fake_other_user_profile_moments_tab_widget.dart';
import 'package:tingle/page/fake_other_user_profile_bottom_sheet/widget/fake_other_user_profile_tab_bar_widget.dart';
import 'package:tingle/page/fake_other_user_profile_bottom_sheet/widget/fake_other_user_profile_won_mom_tab_widget.dart';
import 'package:tingle/page/feed_page/model/fetch_post_model.dart';
import 'package:tingle/page/feed_video_page/model/fetch_video_model.dart';
import 'package:tingle/routes/app_routes.dart';
import 'package:tingle/utils/api_params.dart';
import 'package:tingle/utils/assets.dart';
import 'package:tingle/utils/color.dart';
import 'package:tingle/utils/database.dart';
import 'package:tingle/utils/enums.dart';
import 'package:tingle/utils/font_style.dart';
import 'package:tingle/utils/utils.dart';

class FakeOtherUserProfileBottomSheet {
  static bool _isDialogOpen = false;
  static void show({
    required BuildContext context,
    required String userId,
    bool? isFake,
  }) async {
    if (_isDialogOpen) return;
    _isDialogOpen = true;

    if (userId == Database.loginUserId || userId.isEmpty) {
      if (userId == Database.loginUserId) {
        Get.toNamed(
          AppRoutes.previewUserProfilePage,
          arguments: userId,
        );
      }
      _isDialogOpen = false;
      return;
    }

    try {
      // Local state variables
      final scrollController = ScrollController();
      int selectedTabIndex = 0;
      bool isLoading = true;
      bool isFollowed = false;
      OtherUserProfileModel? otherUserProfileModel;
      List<Post> userPosts = [];
      bool isLoadingPost = false;
      bool isInitialized = false;
      List<VideoData> userVideos = [];

      // Fetch profile data

      // Follow/unfollow function
      onClickFollow() async {
        if (otherUserProfileModel?.user?.id != Database.loginUserId) {
          isFollowed = !isFollowed;
        }
      }

      // Fetch posts
      onFakeDataFiler() async {
        if (userId.isNotEmpty) {
          FakeProfilesSet().generateUserProfiles(100).forEach(
            (element) {
              if (userId == element.user!.id) {
                otherUserProfileModel = element;
              }
            },
          );
        }
      }

      Future<void> loadInitialData() async {
        try {
          isLoading = true;

          // Execute all API calls concurrently
          await Future.wait([onFakeDataFiler()]);
        } catch (e) {
          // Handle any errors that occurred during the API calls
          Utils.showLog("Error loading initial data: $e");
        } finally {
          // This will run whether successful or not
          isLoading = false;
        }
      }

      await showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        builder: (context) {
          return StatefulBuilder(
            builder: (context, setState) {
              Future<void> initializeData() async {
                if (isLoading) {
                  await loadInitialData();
                  setState(() {}); // Force UI update after initial load
                }
              }

              // Call initialize when dialog first builds
              WidgetsBinding.instance.addPostFrameCallback((_) {
                if (!isInitialized) {
                  isInitialized = true;
                  initializeData();
                }
              });

              return Container(
                  height: MediaQuery.of(context).size.height * 0.9,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                  ),
                  child: Column(
                    children: [
                      Expanded(
                        child: isLoading
                            ? const OtherUserProfileShimmerWidget()
                            : Stack(
                                children: [
                                  Column(
                                    children: [
                                      Expanded(
                                        child: Stack(
                                          children: [
                                            SingleChildScrollView(
                                              controller: scrollController,
                                              child: Column(
                                                children: [
                                                  FakeOtherUserProfileDetailsWidget(
                                                    otherUserProfileModel: otherUserProfileModel,
                                                  ),
                                                  15.height,
                                                  Container(
                                                    height: 50,
                                                    width: Get.width,
                                                    padding: const EdgeInsets.symmetric(horizontal: 15),
                                                    color: AppColor.colorBorder.withValues(alpha: 0.5),
                                                    child: Row(
                                                      children: [
                                                        TabItemWidget(
                                                          title: EnumLocal.txtData.name.tr,
                                                          isSelected: selectedTabIndex == 0,
                                                          onTap: () {
                                                            setState(() {
                                                              selectedTabIndex = 0;
                                                            });
                                                          },
                                                        ),
                                                        TabItemWidget(
                                                          title: EnumLocal.txtMoments.name.tr,
                                                          isSelected: selectedTabIndex == 1,
                                                          onTap: () {
                                                            setState(() {
                                                              selectedTabIndex = 1;
                                                            });
                                                          },
                                                        ),
                                                        TabItemWidget(
                                                          title: EnumLocal.txtWonderfulMoments.name.tr,
                                                          isSelected: selectedTabIndex == 2,
                                                          onTap: () {
                                                            setState(() {
                                                              selectedTabIndex = 2;
                                                            });
                                                          },
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  15.height,
                                                  selectedTabIndex == 0
                                                      ? FakeOtherUserProfileDataTabWidget(
                                                          userID: userId,
                                                          giftCount: otherUserProfileModel?.user?.receivedGifts ?? 0,
                                                          isFake: true,
                                                        )
                                                      // OtherUserProfileDataTabWidget(posts: userPosts)

                                                      : selectedTabIndex == 1
                                                          ? FakeOtherUserProfileMomentsTabWidget(
                                                              isLoadingPost: isLoadingPost,
                                                              userPosts: userPosts,
                                                            )
                                                          : FakeOtherUserProfileWonMomTabWidget(
                                                              isLoadingVideo: isLoadingPost,
                                                              onClickVideo: (int index) {
                                                                Get.toNamed(
                                                                  AppRoutes.previewShortsVideoPage,
                                                                  arguments: {"index": index, "videos": userVideos},
                                                                );
                                                              },
                                                              userVideos: userVideos,
                                                            ),
                                                  selectedTabIndex == 0 ? 0.height : 60.height,
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      // 60.height
                                    ],
                                  ),
                                ],
                              ),
                      ),
                      Container(
                        height: 60,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          color: AppColor.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withAlpha(26),
                              blurRadius: 10,
                              offset: Offset.zero,
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            5.height,
                            Row(
                              children: [
                                20.width,
                                Expanded(
                                  child: !isFollowed
                                      ? GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              onClickFollow();
                                            });
                                          },
                                          child: Container(
                                            height: 50,
                                            decoration: BoxDecoration(
                                              color: AppColor.primary,
                                              borderRadius: BorderRadius.circular(25),
                                            ),
                                            child: Center(
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: [
                                                  Image.asset(
                                                    AppAssets.icFollow,
                                                    height: 20,
                                                    width: 20,
                                                    color: AppColor.white,
                                                  ),
                                                  10.width,
                                                  Text(
                                                    EnumLocal.txtFollowMe.name.tr,
                                                    style: AppFontStyle.styleW600(AppColor.white, 16),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        )
                                      : GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              onClickFollow();
                                            });
                                          },
                                          child: Container(
                                            height: 50,
                                            decoration: BoxDecoration(
                                              color: AppColor.white,
                                              borderRadius: BorderRadius.circular(25),
                                              border: Border.all(color: AppColor.primary, width: 2),
                                            ),
                                            child: Center(
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: [
                                                  Image.asset(
                                                    AppAssets.icFollowing,
                                                    height: 20,
                                                    width: 20,
                                                    color: AppColor.primary,
                                                  ),
                                                  10.width,
                                                  Text(
                                                    EnumLocal.txtFollowing.name.tr,
                                                    style: AppFontStyle.styleW600(AppColor.primary, 16),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                ),
                                const SizedBox(width: 20),
                                Expanded(
                                  child: GestureDetector(
                                    onTap: () {
                                      Get.back();
                                      if (otherUserProfileModel?.user?.id!.contains("user") == true) {
                                        Get.toNamed(
                                          AppRoutes.fakeChatPage,
                                          arguments: {
                                            ApiParams.roomId: "",
                                            ApiParams.receiverUserId: otherUserProfileModel?.user?.id ?? "",
                                            ApiParams.name: otherUserProfileModel?.user?.name ?? "",
                                            ApiParams.image: otherUserProfileModel?.user?.image ?? "",
                                            ApiParams.isBanned: otherUserProfileModel?.user?.isProfilePicBanned ?? false,
                                            ApiParams.isVerify: otherUserProfileModel?.user?.isVerified ?? false,
                                          },
                                        );
                                      } else {
                                        Get.toNamed(
                                          AppRoutes.chatPage,
                                          arguments: {
                                            ApiParams.roomId: "",
                                            ApiParams.receiverUserId: otherUserProfileModel?.user?.id ?? "",
                                            ApiParams.name: otherUserProfileModel?.user?.name ?? "",
                                            ApiParams.image: otherUserProfileModel?.user?.image ?? "",
                                            ApiParams.isBanned: otherUserProfileModel?.user?.isProfilePicBanned ?? false,
                                            ApiParams.isVerify: otherUserProfileModel?.user?.isVerified ?? false,
                                          },
                                        );
                                      }
                                    },
                                    child: Container(
                                      height: 50,
                                      decoration: BoxDecoration(
                                        gradient: AppColor.coinPinkGradient,
                                        borderRadius: BorderRadius.circular(25),
                                      ),
                                      child: Center(
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Image.asset(
                                              AppAssets.icHello,
                                              height: 20,
                                              width: 20,
                                              color: AppColor.white,
                                            ),
                                            10.width,
                                            Text(
                                              EnumLocal.txtSayHello.name.tr,
                                              style: AppFontStyle.styleW600(AppColor.white, 16),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                20.width,
                              ],
                            ),
                            5.height,
                          ],
                        ),
                      ),
                    ],
                  ));
            },
          );
        },
      );
    } finally {
      _isDialogOpen = false;
    }
  }
}
