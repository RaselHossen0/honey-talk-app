import 'dart:math';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:tingle/common/widget/preview_network_image_widget.dart';
import 'package:tingle/database/fake_data/user_fake_data.dart';
import 'package:tingle/page/message_page/controller/message_controller.dart';
import 'package:tingle/page/message_page/model/fetch_live_female_model.dart';
import 'package:tingle/page/fake_live_page/model/fake_live_model.dart';
import 'package:tingle/routes/app_routes.dart';
import 'package:tingle/utils/assets.dart';
import 'package:tingle/utils/color.dart';
import 'package:tingle/utils/constant.dart';
import 'package:tingle/utils/enums.dart';
import 'package:tingle/utils/font_style.dart';
import 'package:tingle/utils/utils.dart';

class MessageLiveFemalesWidget extends StatelessWidget {
  const MessageLiveFemalesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MessageController>(
      id: AppConstant.onFetchLiveFemales,
      builder: (controller) {
        if (controller.liveFemales.isEmpty) return const SizedBox.shrink();

        return Container(
          margin: const EdgeInsets.only(top: 4, bottom: 0),
          height: 88,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 12),
            itemCount: controller.liveFemales.length,
            separatorBuilder: (_, __) => 12.width,
            itemBuilder: (context, index) {
              final item = controller.liveFemales[index];
              return _LiveFemaleAvatarItem(
                item: item,
                onTap: () => _onTapLiveFemale(item),
              );
            },
          ),
        );
      },
    );
  }

  void _onTapLiveFemale(LiveFemaleData item) {
    final random = Random();
    final host1Uid = 5000 + random.nextInt(100);
    final host2Uid = 100000 + random.nextInt(900000);
    final channel = 'msg_live_${item.userId ?? "1"}';
    final videoUrl = FakeProfilesSet.videoUrlSec;

    Get.toNamed(
      AppRoutes.fakeLivePage,
      arguments: FakeLiveModel(
        isHost: false,
        isFollow: false,
        liveType: 1,
        isChannelMediaRelay: false,
        country: 'USA',
        host2IsProfilePicBanned: false,
        isProfilePicBanned: item.isProfilePicBanned ?? false,
        pkStreamSources: [videoUrl, videoUrl],
        pkThumbnails: [item.image ?? '', item.image ?? ''],
        streamSource: videoUrl,
        view: 100 + random.nextInt(200),
        host1Token: 'token_$channel',
        host1Channel: channel,
        host1Uid: host1Uid,
        host1LiveHistoryId: 'history_${item.id ?? "1"}',
        host1UserId: item.userId ?? '',
        host1Name: item.name ?? '',
        host1UserName: (item.name ?? '').toLowerCase().replaceAll(' ', '_'),
        host1UniqueId: 'unique_${item.userId ?? "1"}',
        host1Image: item.image ?? '',
        host1ProfilePicIsBanned: item.isProfilePicBanned ?? false,
        host1WealthLevelImage: '',
        host1Coin: 500 + random.nextInt(500),
        host2UserId: '',
        host2Name: '',
        host2UserName: '',
        host2UniqueId: '',
        host2Image: '',
        host2ProfilePicIsBanned: false,
        host2WealthLevelImage: '',
        host2Coin: 0,
        host2Token: '',
        host2LiveHistoryId: '',
        host2Channel: '',
        host2Uid: host2Uid,
      ),
    )?.then((_) => Get.find<MessageController>().onRefresh(millisecondsDelay: 500));
  }
}

class _LiveFemaleAvatarItem extends StatelessWidget {
  const _LiveFemaleAvatarItem({
    required this.item,
    required this.onTap,
  });

  final LiveFemaleData item;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        width: 72,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Stack(
              clipBehavior: Clip.none,
              alignment: Alignment.center,
              children: [
                Container(
                  width: 68,
                  height: 68,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColor.transparent,
                    boxShadow: [
                      BoxShadow(
                        color: AppColor.pink.withValues(alpha: 0.35),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Stack(
                    alignment: Alignment.center,
                    clipBehavior: Clip.none,
                    children: [
                      ClipOval(
                        child: SizedBox(
                          width: 68,
                          height: 68,
                          child: Lottie.asset(
                            AppAssets.lottieMessageAvatarBorder,
                            fit: BoxFit.cover,
                            repeat: true,
                          ),
                        ),
                      ),
                      Container(
                        width: 62,
                        height: 62,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColor.white,
                        ),
                        clipBehavior: Clip.antiAlias,
                        child: Padding(
                          padding: const EdgeInsets.all(2),
                          child: PreviewProfileImageWidget(
                            image: item.image ?? '',
                            fit: BoxFit.cover,
                            isBanned: item.isProfilePicBanned ?? false,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  left: 0,
                  right: 0,
                  bottom: -4,
                  child: Container(
                    height: 22,
                    alignment: Alignment.center,
                    child: Stack(
                      alignment: Alignment.center,
                      clipBehavior: Clip.none,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [AppColor.pink, AppColor.purple],
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                            ),
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                color: AppColor.pink.withValues(alpha: 0.4),
                                blurRadius: 4,
                              ),
                            ],
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              SizedBox(
                                width: 12,
                                height: 12,
                                child: Lottie.asset(
                                  AppAssets.lottieWaveAnimation,
                                  fit: BoxFit.contain,
                                  repeat: true,
                                ),
                              ),
                              4.width,
                              Text(
                                EnumLocal.txtLive.name.tr,
                                style: AppFontStyle.styleW600(AppColor.white, 10),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
