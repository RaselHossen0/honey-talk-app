import 'package:blurrycontainer/blurrycontainer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tingle/page/fake_audio_room_page/controller/fake_audio_room_controller.dart';
import 'package:tingle/utils/color.dart';
import 'package:tingle/utils/constant.dart';
import 'package:tingle/utils/font_style.dart';
import 'package:tingle/utils/utils.dart';

class FakeCommentTabBar extends StatelessWidget {
  const FakeCommentTabBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 45,
      width: Get.width / 1.7,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: AppColor.black.withValues(alpha: 0.3),
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(100),
          bottomRight: Radius.circular(100),
        ),
      ),
      child: Row(
        children: [
          10.width,
          CommentTabItemWidget(index: 0, name: "All"),
          CommentTabItemWidget(index: 1, name: "Room"),
          CommentTabItemWidget(index: 2, name: "Chat"),
          5.width,
        ],
      ),
    );
  }
}

class CommentTabItemWidget extends StatelessWidget {
  const CommentTabItemWidget({super.key, required this.index, required this.name});

  final int index;
  final String name;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<FakeAudioRoomController>(
      id: AppConstant.onChangeCommentTab,
      builder: (controller) => Expanded(
        child: GestureDetector(
          onTap: () => controller.onChangeCommentTab(index),
          child: Container(
            height: 45,
            alignment: Alignment.center,
            margin: EdgeInsets.symmetric(horizontal: 0, vertical: 5),
            decoration: BoxDecoration(
              color: controller.selectedTabIndex == index ? AppColor.white : AppColor.transparent,
              borderRadius: BorderRadius.circular(100),
            ),
            child: Text(
              name,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: AppFontStyle.styleW600(controller.selectedTabIndex == index ? AppColor.primary : AppColor.white, 14),
            ),
          ),
        ),
      ),
    );
  }
}

class TabWiseCommentWidget extends StatelessWidget {
  const TabWiseCommentWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: ListView.builder(
        itemCount: 5,
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        scrollDirection: Axis.vertical,
        itemBuilder: (context, index) => index == 3
            ? Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.only(left: 10, bottom: 10),
                  child: BlurryContainer(
                    blur: 10,
                    color: AppColor.purple,
                    borderRadius: BorderRadius.circular(100),
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    child: Text(
                      "John Daveldeo : Sent Friend Request",
                      style: AppFontStyle.styleW500(AppColor.white, 11),
                    ),
                  ),
                ),
              )
            : index == 1
                ? Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: EdgeInsets.only(left: 10, bottom: 10),
                      child: BlurryContainer(
                        blur: 10,
                        color: AppColor.black.withValues(alpha: 0.2),
                        borderRadius: BorderRadius.circular(100),
                        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        child: Text(
                          "Announcement : Welcome to room",
                          style: AppFontStyle.styleW500(AppColor.lightYellowGreen, 11),
                        ),
                      ),
                    ),
                  )
                : Padding(
                    padding: EdgeInsets.only(left: 10, bottom: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "John Daveldeo",
                          style: AppFontStyle.styleW500(AppColor.lightBlue, 11),
                        ),
                        3.height,
                        BlurryContainer(
                          blur: 10,
                          color: AppColor.black.withValues(alpha: 0.2),
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(10),
                            bottomRight: Radius.circular(10),
                            bottomLeft: Radius.circular(10),
                          ),
                          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                          child: Text(
                            "Very Nice Cloths",
                            style: AppFontStyle.styleW500(AppColor.white, 11),
                          ),
                        ),
                      ],
                    ),
                  ),
      ),
    );
  }
}
