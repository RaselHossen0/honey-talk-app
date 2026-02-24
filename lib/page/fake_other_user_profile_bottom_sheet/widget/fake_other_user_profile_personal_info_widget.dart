import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:tingle/utils/color.dart';
import 'package:tingle/utils/font_style.dart';
import 'package:tingle/utils/utils.dart';

class FakeOtherUserProfilePersonalInfoWidget extends StatelessWidget {
  const FakeOtherUserProfilePersonalInfoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      width: Get.width,
      margin: EdgeInsets.symmetric(horizontal: 15),
      padding: EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
        color: AppColor.transparent,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Personal Information",
                style: AppFontStyle.styleW700(AppColor.black, 16),
              ),
              3.height,
              Text(
                "She/He was lazy and left nothing behind.",
                style: AppFontStyle.styleW500(AppColor.grayText, 12),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
