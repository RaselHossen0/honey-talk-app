import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:tingle/common/model/fatch_other_user_profile_model.dart';
import 'package:tingle/common/shimmer/other_user_profile_shimmer_widget.dart';

import 'package:tingle/database/fake_data/user_fake_data.dart';
import 'package:tingle/page/fake_other_user_profile_bottom_sheet/widget/fake_other_user_profile_data_tab_widget.dart';
import 'package:tingle/page/fake_other_user_profile_bottom_sheet/widget/fake_other_user_profile_details_widget.dart';
import 'package:tingle/page/fake_other_user_profile_bottom_sheet/widget/fake_other_user_profile_won_mom_tab_widget.dart';
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
    bool isFake = true,
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
      int selectedTabIndex = 0;
      bool isLoading = true;
      OtherUserProfileModel? otherUserProfileModel;
      bool isLoadingPost = false;
      bool isInitialized = false;
      List<VideoData> userVideos = [];

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

      final scrollController = ScrollController();
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
                      Center(
                        child: Container(
                          margin: const EdgeInsets.only(top: 12, bottom: 4),
                          height: 4,
                          width: 35,
                          decoration: BoxDecoration(
                            color: AppColor.grayText.withValues(alpha: 0.5),
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
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
                                                    onClose: () => Navigator.of(context).pop(),
                                                  ),
                                                  8.height,
                                                  _TabBar(
                                                    selectedIndex: selectedTabIndex,
                                                    videoCount: userVideos.length,
                                                    onTab: (i) => setState(() => selectedTabIndex = i),
                                                  ),
                                                  8.height,
                                                  selectedTabIndex == 0
                                                      ? FakeOtherUserProfileDataTabWidget(
                                                          userID: userId,
                                                          giftCount: otherUserProfileModel?.user?.receivedGifts ?? 0,
                                                          isFake: true,
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
                                                  selectedTabIndex == 0 ? 0.height : 80.height,
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
                      _BottomActionBar(
                        otherUserProfileModel: otherUserProfileModel,
                        isFake: isFake,
                      ),
                    ],
                  ));
            },
          );
        },
      ).whenComplete(() {
        scrollController.dispose();
      });
    } finally {
      _isDialogOpen = false;
    }
  }
}

class _TabBar extends StatelessWidget {
  const _TabBar({
    required this.selectedIndex,
    required this.videoCount,
    required this.onTab,
  });

  final int selectedIndex;
  final int videoCount;
  final ValueChanged<int> onTab;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 44,
      width: Get.width,
      color: AppColor.white,
      child: Row(
        children: [
          GestureDetector(
            onTap: () => onTab(0),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: selectedIndex == 0 ? AppColor.pink : AppColor.transparent,
                    width: 3,
                  ),
                ),
              ),
              child: Text(
                EnumLocal.txtInformation.name.tr,
                style: selectedIndex == 0
                    ? AppFontStyle.styleW600(AppColor.pink, 14)
                    : AppFontStyle.styleW500(AppColor.grayText, 14),
              ),
            ),
          ),
          GestureDetector(
            onTap: () => onTab(1),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: selectedIndex == 1 ? AppColor.pink : AppColor.transparent,
                    width: 3,
                  ),
                ),
              ),
              child: Text(
                "${EnumLocal.txtVideo.name.tr}($videoCount)",
                style: selectedIndex == 1
                    ? AppFontStyle.styleW600(AppColor.pink, 14)
                    : AppFontStyle.styleW500(AppColor.grayText, 14),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _BottomActionBar extends StatelessWidget {
  const _BottomActionBar({
    required this.otherUserProfileModel,
    required this.isFake,
  });

  final OtherUserProfileModel? otherUserProfileModel;
  final bool isFake;

  static const _callPricePerMin = 3500;

  @override
  Widget build(BuildContext context) {
    final user = otherUserProfileModel?.user;
    return Container(
      padding: EdgeInsets.only(
        left: 15,
        right: 15,
        top: 12,
        bottom: 12 + MediaQuery.of(context).padding.bottom,
      ),
      decoration: BoxDecoration(
        color: AppColor.white,
        boxShadow: [
          BoxShadow(
            color: AppColor.black.withValues(alpha: 0.08),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        children: [
          GestureDetector(
            onTap: () {
              Get.back();
              if (isFake) {
                Get.toNamed(
                  AppRoutes.fakeChatPage,
                  arguments: {
                    ApiParams.roomId: "",
                    ApiParams.receiverUserId: user?.id ?? "",
                    ApiParams.name: user?.name ?? "",
                    ApiParams.image: user?.image ?? "",
                    ApiParams.isBanned: user?.isProfilePicBanned ?? false,
                    ApiParams.isVerify: user?.isVerified ?? false,
                  },
                );
              } else {
                Get.toNamed(
                  AppRoutes.chatPage,
                  arguments: {
                    ApiParams.roomId: "",
                    ApiParams.receiverUserId: user?.id ?? "",
                    ApiParams.name: user?.name ?? "",
                    ApiParams.image: user?.image ?? "",
                    ApiParams.isBanned: user?.isProfilePicBanned ?? false,
                    ApiParams.isVerify: user?.isVerified ?? false,
                  },
                );
              }
            },
            child: Container(
              height: 50,
              width: 50,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColor.pink.withValues(alpha: 0.2),
                border: Border.all(color: AppColor.pink.withValues(alpha: 0.5)),
              ),
              child: Center(
                child: Image.asset(
                  AppAssets.icMessageBorder,
                  width: 24,
                  color: AppColor.pink,
                ),
              ),
            ),
          ),
          12.width,
          Expanded(
            child: GestureDetector(
              onTap: () {},
              child: Container(
                height: 50,
                decoration: BoxDecoration(
                  gradient: AppColor.coinPinkGradient,
                  borderRadius: BorderRadius.circular(25),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      AppAssets.icCallReceive,
                      width: 22,
                      color: AppColor.white,
                    ),
                    10.width,
                    Text(
                      "$_callPricePerMin Token${EnumLocal.txtPerMinute.name.tr}",
                      style: AppFontStyle.styleW600(AppColor.white, 15),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
