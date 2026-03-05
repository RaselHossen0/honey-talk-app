import 'dart:math';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tingle/common/widget/preview_network_image_widget.dart';
import 'package:tingle/database/fake_data/user_fake_data.dart';
import 'package:tingle/page/fake_live_page/model/fake_live_model.dart';
import 'package:tingle/page/live_end_page/controller/live_end_controller.dart';
import 'package:tingle/page/message_page/model/fetch_live_female_model.dart';
import 'package:tingle/routes/app_routes.dart';
import 'package:tingle/utils/color.dart';
import 'package:tingle/utils/enums.dart';
import 'package:tingle/utils/font_style.dart';
import 'package:tingle/utils/utils.dart';

class LiveEndView extends GetView<LiveEndController> {
  const LiveEndView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: Get.width,
        height: Get.height,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF5C4033),
              Color(0xFF3D2E28),
              Color(0xFF2A2220),
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              _buildAppBar(),
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: [
                      30.height,
                      _buildMainCard(),
                      30.height,
                      _buildSuggestedContent(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAppBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      child: Row(
        children: [
          GestureDetector(
            onTap: controller.onBack,
            child: Icon(Icons.arrow_back_ios, color: AppColor.white, size: 22),
          ),
        ],
      ),
    );
  }

  Widget _buildMainCard() {
    final args = controller.args;
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 28, horizontal: 20),
      decoration: BoxDecoration(
        color: AppColor.black.withValues(alpha: 0.4),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: AppColor.white.withValues(alpha: 0.1)),
      ),
      child: Column(
        children: [
          _buildProfileAvatar(args?.hostImage ?? ''),
          12.height,
          Text(
            '• ${args?.hostName ?? 'Host'} •',
            style: AppFontStyle.styleW600(AppColor.white, 16),
          ),
          8.height,
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildBadge(args?.countryFlag ?? '🇮🇳', '${args?.age ?? 18}'),
              12.width,
              _buildBadge('❤️', '${args?.likesCount ?? 0}'),
            ],
          ),
          20.height,
          Text(
            EnumLocal.txtLiveOver.name.tr,
            style: AppFontStyle.styleW700(AppColor.white, 18),
          ),
          20.height,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildStatRow(Icons.schedule, controller.durationFormatted),
              _buildStatRow(Icons.person_outline, '${args?.audienceCount ?? 0}'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildProfileAvatar(String imageUrl) {
    return Container(
      height: 90,
      width: 90,
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: LinearGradient(
          colors: [Color(0xFFFF6B9D), Color(0xFFC44CF2)],
        ),
      ),
      child: Container(
        decoration: BoxDecoration(shape: BoxShape.circle, color: AppColor.black),
        padding: const EdgeInsets.all(2),
        child: ClipOval(
          child: PreviewProfileImageWidget(
            image: imageUrl,
            isBanned: false,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

  Widget _buildBadge(String icon, String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: AppColor.white.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(icon, style: TextStyle(fontSize: 14)),
          4.width,
          Text(text, style: AppFontStyle.styleW500(AppColor.white, 12)),
        ],
      ),
    );
  }

  Widget _buildStatRow(IconData icon, String value) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: AppColor.white.withValues(alpha: 0.8), size: 18),
        6.width,
        Text(value, style: AppFontStyle.styleW600(AppColor.white, 14)),
      ],
    );
  }

  Widget _buildSuggestedContent() {
    return GetBuilder<LiveEndController>(
      builder: (ctrl) {
        if (ctrl.suggestedLives.isEmpty) return const SizedBox.shrink();
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Suggested for you',
              style: AppFontStyle.styleW600(AppColor.white.withValues(alpha: 0.9), 14),
            ),
            16.height,
            SizedBox(
              height: 120,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: ctrl.suggestedLives.length,
                separatorBuilder: (_, __) => 12.width,
                itemBuilder: (context, index) {
                  final item = ctrl.suggestedLives[index];
                  return _SuggestedAvatarItem(item: item);
                },
              ),
            ),
          ],
        );
      },
    );
  }
}

class _SuggestedAvatarItem extends StatelessWidget {
  const _SuggestedAvatarItem({required this.item});

  final LiveFemaleData item;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _onTap(),
      child: Column(
        children: [
          Stack(
            children: [
              Container(
                height: 90,
                width: 90,
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: AppColor.black.withValues(alpha: 0.3),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: PreviewProfileImageWidget(
                  image: item.image ?? '',
                  isBanned: item.isProfilePicBanned ?? false,
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  height: 32,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [Colors.transparent, AppColor.orange.withValues(alpha: 0.9)],
                    ),
                  ),
                  child: Center(
                    child: Icon(Icons.call, color: AppColor.white, size: 18),
                  ),
                ),
              ),
            ],
          ),
          6.height,
          SizedBox(
            width: 90,
            child: Text(
              item.name ?? '',
              style: AppFontStyle.styleW500(AppColor.white.withValues(alpha: 0.9), 12),
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }

  void _onTap() {
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
        host1Coin: 0,
        host2Uid: host2Uid,
        host2Channel: 'channel_2',
        host2Token: 'token_2',
        host2LiveHistoryId: 'history_2',
        host2UserId: 'host2',
        host2Name: 'Host2',
        host2UserName: 'host2',
        host2UniqueId: 'unique_2',
        host2WealthLevelImage: '',
        host2Image: '',
        host2ProfilePicIsBanned: false,
        host2Coin: 0,
      ),
    );
  }
}
