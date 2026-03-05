import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tingle/common/function/format_message_time.dart';
import 'package:tingle/common/widget/preview_network_image_widget.dart';
import 'package:tingle/utils/color.dart';
import 'package:tingle/utils/font_style.dart';

class ReceiverMessageWidget extends StatelessWidget {
  const ReceiverMessageWidget({
    super.key,
    required this.message,
    required this.time,
    required this.profileImage,
    required this.profileImageIsBanned,
    this.replyToMessage,
    this.reactions = const [],
  });

  final String message;
  final String time;
  final String profileImage;
  final bool profileImageIsBanned;
  final String? replyToMessage;
  final List<String> reactions;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Container(
          height: 30,
          width: 30,
          padding: const EdgeInsets.all(2),
          margin: EdgeInsets.only(right: 5, bottom: 15),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: AppColor.secondary),
          ),
          child: Container(
            clipBehavior: Clip.antiAlias,
            decoration: const BoxDecoration(shape: BoxShape.circle),
            child: PreviewProfileImageWidget(
              image: profileImage,
              isBanned: profileImageIsBanned,
            ),
          ),
        ),
        SizedBox(
          width: Get.width / 1.6,
          child: Align(
            alignment: Alignment.centerLeft,
            child: Stack(
              children: [
                Container(
                  padding: const EdgeInsets.only(left: 12, right: 38, top: 6, bottom: 15),
                  decoration: const BoxDecoration(
                    color: AppColor.pink,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10),
                      bottomRight: Radius.circular(10),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (replyToMessage != null && replyToMessage!.isNotEmpty) ...[
                        Container(
                          margin: const EdgeInsets.only(bottom: 4),
                          padding: const EdgeInsets.only(left: 6, bottom: 6),
                          decoration: BoxDecoration(
                            border: Border(left: BorderSide(color: AppColor.white.withValues(alpha: 0.7), width: 2)),
                          ),
                          child: Text(
                            replyToMessage!,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: AppFontStyle.styleW400(AppColor.white.withOpacity(0.7), 13),
                          ),
                        ),
                      ],
                      Text(
                        message,
                        style: AppFontStyle.styleW400(AppColor.white, 16),
                      ),
                      if (reactions.isNotEmpty) ...[
                        const SizedBox(height: 4),
                        Wrap(
                          spacing: 4,
                          runSpacing: 2,
                          children: reactions.map((e) => Text(e, style: const TextStyle(fontSize: 14))).toList(),
                        ),
                      ],
                    ],
                  ),
                ),
                Positioned(
                  bottom: 3,
                  right: 10,
                  child: Text(
                    FormatMessageTime.onConvert(time),
                    style: AppFontStyle.styleW500(AppColor.white, 10),
                  ),
                ),
              ],
            ),
          ),
        ).paddingOnly(bottom: 15),
      ],
    );
  }
}
