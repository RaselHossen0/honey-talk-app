import 'package:flutter/material.dart';
import 'package:tingle/page/fake_other_user_profile_bottom_sheet/widget/fake_other_user_profile_gift_gallery_widget.dart';
import 'package:tingle/page/fake_other_user_profile_bottom_sheet/widget/fake_other_user_profile_wealth_level_widget.dart';
import 'package:tingle/utils/utils.dart';

class FakeOtherUserProfileDataTabWidget extends StatelessWidget {
  const FakeOtherUserProfileDataTabWidget({super.key, required this.userID, required this.giftCount, required this.isFake});

  final String userID;
  final int giftCount;
  final bool isFake;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        FakeOtherUserProfileWealthLevelWidget(),
        15.height,
        FakeOtherUserProfileGiftGalleryWidget(
          userID: userID,
          giftCount: giftCount,
          isFake: isFake,
        ),
        15.height,
        // FakeOtherUserProfileFansClubWidget(),
        // 15.height,
        // FakeOtherUserProfileFansRankingWidget(),
        5.height,
        // FakeOtherUserProfilePersonalInfoWidget(),
      ],
    );
  }
}
