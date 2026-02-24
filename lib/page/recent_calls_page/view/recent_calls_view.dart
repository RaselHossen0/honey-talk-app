import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tingle/common/widget/preview_network_image_widget.dart' show PreviewProfileImageWidget;
import 'package:tingle/page/recent_calls_page/controller/recent_calls_controller.dart';
import 'package:tingle/utils/assets.dart';
import 'package:tingle/utils/color.dart';
import 'package:tingle/utils/enums.dart';
import 'package:tingle/utils/font_style.dart';
import 'package:tingle/utils/utils.dart';

class RecentCallsView extends GetView<RecentCallsController> {
  const RecentCallsView({super.key});

  @override
  Widget build(BuildContext context) {
    Utils.onChangeStatusBar(brightness: Brightness.light);
    return Scaffold(
      backgroundColor: AppColor.colorScaffold,
      appBar: AppBar(
        backgroundColor: AppColor.transparent,
        elevation: 0,
        leading: GestureDetector(
          onTap: Get.back,
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Image.asset(AppAssets.icArrowLeft, width: 10, color: AppColor.black),
          ),
        ),
        centerTitle: true,
        title: Text(
          EnumLocal.txtRecentCalls.name.tr,
          style: AppFontStyle.styleW700(AppColor.black, 18),
        ),
        actions: [
          GestureDetector(
            onTap: controller.onCallIconTap,
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Image.asset(AppAssets.icVideoCallBorder, width: 24, color: AppColor.black),
            ),
          ),
        ],
      ),
      body: GetBuilder<RecentCallsController>(
        builder: (ctrl) => ListView.separated(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
          itemCount: ctrl.calls.length,
          separatorBuilder: (_, __) => 12.height,
          itemBuilder: (context, index) => _buildCallRow(ctrl.calls[index], ctrl),
        ),
      ),
    );
  }

  Widget _buildCallRow(RecentCallModel call, RecentCallsController ctrl) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColor.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: AppColor.secondary.withValues(alpha: 0.06),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: SizedBox(
                  width: 56,
                  height: 56,
                  child: PreviewProfileImageWidget(image: call.avatarUrl, fit: BoxFit.cover),
                ),
              ),
              if (call.isRich1 || call.isRich2)
                Positioned(
                  bottom: -2,
                  left: 0,
                  right: 0,
                  child: Image.asset(
                    call.isRich1 ? AppAssets.rankLevel_1 : AppAssets.rankLevel_2,
                    width: 20,
                    height: 20,
                    fit: BoxFit.contain,
                  ),
                ),
            ],
          ),
          12.width,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  call.name,
                  style: AppFontStyle.styleW600(AppColor.darkGrey, 14),
                ),
                2.height,
                Row(
                  children: [
                    Text(
                      call.countryFlag,
                      style: const TextStyle(fontSize: 12),
                    ),
                    4.width,
                    Text(
                      call.userId,
                      style: AppFontStyle.styleW400(AppColor.grayText, 12),
                    ),
                  ],
                ),
                4.height,
                Row(
                  children: [
                    Text(
                      '${call.callCount} call${call.callCount > 1 ? 's' : ''}',
                      style: AppFontStyle.styleW500(AppColor.darkGrey, 12),
                    ),
                    Text(
                      ' • ${call.dateTime}',
                      style: AppFontStyle.styleW400(AppColor.grayText, 12),
                    ),
                  ],
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: () => ctrl.onMessageTap(call),
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Image.asset(AppAssets.icMessageBorder, width: 22),
            ),
          ),
        ],
      ),
    );
  }
}
