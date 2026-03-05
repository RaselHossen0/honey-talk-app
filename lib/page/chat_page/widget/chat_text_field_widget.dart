import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tingle/page/chat_page/controller/chat_controller.dart';
import 'package:tingle/utils/assets.dart';
import 'package:tingle/utils/constant.dart';
import 'package:tingle/utils/color.dart';
import 'package:tingle/utils/enums.dart';
import 'package:tingle/utils/font_style.dart';
import 'package:tingle/utils/utils.dart';

class ChatTextFieldWidget extends GetView<ChatController> {
  const ChatTextFieldWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColor.white,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          GetBuilder<ChatController>(
            id: AppConstant.onFetchUserChat,
            builder: (c) {
              if (c.replyToMessage == null) return const SizedBox.shrink();
              return Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                margin: const EdgeInsets.only(top: 8),
                decoration: BoxDecoration(
                  color: AppColor.secondary.withValues(alpha: 0.08),
                  border: Border(left: BorderSide(color: AppColor.primary, width: 3)),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text("Replying to", style: AppFontStyle.styleW600(AppColor.secondary, 11)),
                          const SizedBox(height: 2),
                          Text(
                            c.replyToMessage?.message ?? "",
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: AppFontStyle.styleW400(AppColor.black, 13),
                          ),
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: () => c.clearReplyToMessage(),
                      child: Padding(
                        padding: const EdgeInsets.all(4),
                        child: Icon(Icons.close, size: 20, color: AppColor.secondary),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Container(
                    height: 50,
                    padding: const EdgeInsets.only(left: 20),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: AppColor.secondary.withValues(alpha: 0.12),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: GetBuilder<ChatController>(
                            builder: (controller) => TextFormField(
                              controller: controller.messageController,
                              cursorColor: AppColor.secondary,
                              onChanged: (_) => controller.onTypingDebounce(),
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                contentPadding: const EdgeInsets.only(bottom: 2),
                                hintText: EnumLocal.txtSaySomething.name.tr,
                                hintStyle: AppFontStyle.styleW500(AppColor.secondary, 15),
                              ),
                            ),
                          ),
                        ),
                    GestureDetector(
                      onTap: () => controller.onClickImage(context),
                      child: Container(
                        height: 45,
                        width: 45,
                        alignment: Alignment.center,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColor.transparent,
                        ),
                        child: Image.asset(
                          height: 23,
                          width: 23,
                          AppAssets.icGallery,
                          color: AppColor.secondary,
                        ),
                      ),
                    ),
                        10.width,
                      ],
                    ),
                  ),
                ),
                15.width,
                GestureDetector(
                  onTap: controller.onClickSend,
                  child: Container(
                    height: 50,
                    width: 50,
                    padding: const EdgeInsets.only(bottom: 3),
                    decoration: const BoxDecoration(
                      gradient: AppColor.primaryGradient,
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Image.asset(
                        height: 28,
                        width: 28,
                        AppAssets.icSend,
                        color: AppColor.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
