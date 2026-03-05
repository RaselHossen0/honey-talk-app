import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tingle/common/widget/scroll_fade_effect_widget.dart';
import 'package:tingle/page/audio_room_page/widget/audio_room_comment_widget.dart';
import 'package:tingle/page/fake_live_page/controller/fake_live_controller.dart';
import 'package:tingle/utils/color.dart';
import 'package:tingle/utils/constant.dart';

class FakeLiveCommentWidget extends StatelessWidget {
  const FakeLiveCommentWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<FakeLiveController>(
      id: AppConstant.onChangeComment,
      builder: (controller) => Container(
        height: double.infinity,
        width: Get.width / 1.8,
        color: AppColor.transparent,
        child: ScrollFadeEffectWidget(
          axis: Axis.vertical,
          child: ListView.builder(
            controller: controller.fakeLiveModel?.scrollController,
            itemCount: controller.fakeCommentList.length,
            physics: const BouncingScrollPhysics(),
            padding: EdgeInsets.zero,
            reverse: true,
            itemBuilder: (context, index) {
              final idx = controller.fakeCommentList.length - 1 - index;
              final indexData = controller.fakeCommentList[idx];
              return LiveCommentTextWidget(
                name: indexData.user,
                comment: indexData.message,
                image: indexData.image,
                isBanned: false,
              );
            },
          ),
        ),
      ),
    );
  }
}
