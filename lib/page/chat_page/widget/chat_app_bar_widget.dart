import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tingle/common/widget/preview_network_image_widget.dart';
import 'package:tingle/page/chat_page/controller/chat_controller.dart';
import 'package:tingle/page/other_user_profile_bottom_sheet/view/other_user_profile_bottom_sheet.dart';
import 'package:tingle/utils/assets.dart';
import 'package:tingle/utils/color.dart';
import 'package:tingle/utils/font_style.dart';
import 'package:tingle/utils/utils.dart';

class ChatAppBarWidget {
  static final controller = Get.find<ChatController>();
  static PreferredSize appBar({
    required BuildContext context,
    required String name,
    required String image,
    required bool isVerify,
    required bool isBanned,
  }) {
    return PreferredSize(
      preferredSize: const Size.fromHeight(90),
      child: Container(
        height: 90,
        padding: EdgeInsets.only(top: MediaQuery.of(context).viewPadding.top, right: 12),
        alignment: Alignment.center,
        width: Get.width,
        decoration: BoxDecoration(color: AppColor.white, boxShadow: [
          BoxShadow(
            color: AppColor.secondary.withValues(alpha: 0.1),
            blurRadius: 2,
            spreadRadius: 2,
          )
        ]),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: Get.back,
              child: Container(
                height: 45,
                width: 45,
                alignment: Alignment.center,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColor.transparent,
                ),
                child: Image.asset(AppAssets.icArrowLeft, width: 10),
              ),
            ),
            Expanded(
              child: GestureDetector(
                onTap: () => OtherUserProfileBottomSheet.show(context: context, userId: controller.receiverUserId),
                child: Container(
                  color: AppColor.transparent,
                  child: Row(
                    children: [
                      Container(
                        height: 47,
                        width: 47,
                        padding: const EdgeInsets.all(2),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: AppColor.secondary),
                        ),
                        child: Container(
                          clipBehavior: Clip.antiAlias,
                          decoration: const BoxDecoration(shape: BoxShape.circle),
                          child: PreviewProfileImageWidget(image: image, isBanned: isBanned),
                        ),
                      ),
                      12.width,
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Flexible(
                              fit: FlexFit.loose,
                              child: Text(
                                name,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: AppFontStyle.styleW700(AppColor.black, 16),
                              ),
                            ),
                            3.height,

                            // Row(
                            //   children: [
                            //     Container(
                            //       padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                            //       decoration: BoxDecoration(
                            //         color: AppColor.green.withValues(alpha: 0.1),
                            //         borderRadius: BorderRadius.circular(100),
                            //       ),
                            //       child: Row(
                            //         children: [
                            //           const Icon(Icons.circle, size: 10, color: AppColor.green),
                            //           3.width,
                            //           Text(
                            //             "Online",
                            //             style: AppFontStyle.styleW600(AppColor.green, 10),
                            //           ),
                            //         ],
                            //       ),
                            //     ),
                            //   ],
                            // ),
                          ],
                        ),
                      ),
                      GetBuilder<ChatController>(
                        builder: (controller) => GestureDetector(
                          onTap: controller.onClickVideoCall,
                          child: Container(
                            height: 40,
                            width: 40,
                            alignment: Alignment.center,
                            decoration: const BoxDecoration(shape: BoxShape.circle),
                            child: Image.asset(AppAssets.icVideoCallBorder, color: AppColor.black, width: 25),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
