import 'package:flutter/material.dart';
import 'package:tingle/page/preview_user_profile_page/widget/preview_profile_gift_gallery_widget.dart';
import 'package:tingle/page/preview_user_profile_page/widget/preview_profile_personal_info_widget.dart';
import 'package:tingle/page/preview_user_profile_page/widget/preview_profile_wealth_level_widget.dart';
import 'package:tingle/utils/utils.dart';

class PreviewProfileDataTabWidget extends StatelessWidget {
  const PreviewProfileDataTabWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        PreviewProfileWealthLevelWidget(),
        15.height,
        PreviewProfileGiftGalleryWidget(),
        5.height,
        PreviewProfilePersonalInfoWidget(),
      ],
    );
  }
}
