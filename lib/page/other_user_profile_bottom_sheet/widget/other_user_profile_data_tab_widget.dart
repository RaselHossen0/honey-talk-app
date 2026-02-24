import 'package:flutter/material.dart';
import 'package:tingle/page/other_user_profile_bottom_sheet/widget/other_user_profile_gift_gallery_widget.dart';
import 'package:tingle/page/other_user_profile_bottom_sheet/widget/other_user_profile_wealth_level_widget.dart';

import 'package:tingle/utils/utils.dart';

class OtherUserProfileDataTabWidget extends StatelessWidget {
  const OtherUserProfileDataTabWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        OtherUserProfileWealthLevelWidget(),
        15.height,
        OtherUserProfileGiftGalleryWidget(),
        15.height,
        5.height,
      ],
    );
  }
}
