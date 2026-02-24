import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tingle/common/function/format_message_time.dart';
import 'package:tingle/utils/assets.dart';
import 'package:tingle/utils/color.dart';
import 'package:tingle/utils/font_style.dart';
import 'package:tingle/utils/utils.dart';

class ReceiverVideoCallWidget extends StatelessWidget {
  const ReceiverVideoCallWidget({super.key, required this.type, required this.callDuration, required this.time});

  final int type;
  final String callDuration;
  final String time;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 70,
          width: Get.width / 2,
          margin: EdgeInsets.only(bottom: 15),
          decoration: BoxDecoration(
            color: AppColor.white,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Stack(
            alignment: Alignment.center,
            children: [
              Container(
                height: 70,
                width: Get.width / 2,
                padding: EdgeInsets.symmetric(horizontal: 10),
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                  color: AppColor.secondary.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Row(
                  children: [
                    3.width,
                    Container(
                      height: 45,
                      width: 45,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColor.white,
                      ),
                      child: Image.asset(
                        AppAssets.icVideoOn,
                        width: 24,
                        color: AppColor.pink,
                      ),
                    ),
                    10.width,
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Video Call",
                          style: AppFontStyle.styleW700(AppColor.black, 16),
                        ),
                        Text(
                          type == 1
                              ? callDuration
                              : type == 2
                                  ? "Not Answered"
                                  : type == 3
                                      ? "Miscalled"
                                      : "",
                          style: AppFontStyle.styleW600(AppColor.grayText, 13),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Positioned(
                bottom: 5,
                right: 12,
                child: Text(
                  FormatMessageTime.onConvert(time),
                  style: AppFontStyle.styleW500(AppColor.secondary, 10),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
