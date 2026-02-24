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
        height: 250,
        width: Get.width / 1.8,
        color: AppColor.transparent,
        child: Align(
          alignment: Alignment.bottomCenter,
          child: ScrollFadeEffectWidget(
            axis: Axis.vertical,
            child: SingleChildScrollView(
              controller: controller.fakeLiveModel?.scrollController,
              child: ListView.builder(
                itemCount: controller.fakeCommentList.length,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                padding: EdgeInsets.zero,
                itemBuilder: (context, index) {
                  final indexData = controller.fakeCommentList[index];
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
        ),
      ),
    );
  }
}
