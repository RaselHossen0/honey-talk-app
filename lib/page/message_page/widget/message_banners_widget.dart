import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tingle/page/message_page/widget/notification_popup_widget.dart';
import 'package:tingle/utils/color.dart';
import 'package:tingle/utils/enums.dart';
import 'package:tingle/utils/font_style.dart';
import 'package:tingle/utils/utils.dart';

class MessageBannersWidget extends StatefulWidget {
  const MessageBannersWidget({super.key});

  @override
  State<MessageBannersWidget> createState() => _MessageBannersWidgetState();
}

class _MessageBannersWidgetState extends State<MessageBannersWidget> {
  bool _notificationBannerVisible = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildBonusRewardBanner(),
        if (_notificationBannerVisible) _buildNotificationBanner(),
      ],
    );
  }

  Widget _buildBonusRewardBanner() {
    return Container(
      margin: const EdgeInsets.fromLTRB(15, 0, 15, 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [AppColor.primary, AppColor.purple],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  EnumLocal.txtBonusRewardBanner.name.tr,
                  style: AppFontStyle.styleW700(AppColor.white, 16),
                ),
                6.height,
                Text(
                  EnumLocal.txtEveryoneCanJoin.name.tr,
                  style: AppFontStyle.styleW500(AppColor.white.withValues(alpha: 0.95), 12),
                ),
                2.height,
                Text(
                  EnumLocal.txtLiveStreamPartyOnly.name.tr,
                  style: AppFontStyle.styleW500(AppColor.white.withValues(alpha: 0.9), 11),
                ),
              ],
            ),
          ),
          Icon(Icons.star, color: AppColor.lightYellow, size: 48),
        ],
      ),
    );
  }

  Widget _buildNotificationBanner() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 15),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: AppColor.pink.withValues(alpha: 0.25),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              EnumLocal.txtDontMissExcitement.name.tr,
              style: AppFontStyle.styleW500(AppColor.darkGrey, 12),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          GestureDetector(
            onTap: NotificationPopupWidget.show,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: AppColor.pink,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                EnumLocal.txtTurnOn.name.tr,
                style: AppFontStyle.styleW600(AppColor.white, 12),
              ),
            ),
          ),
          8.width,
          GestureDetector(
            onTap: () => setState(() => _notificationBannerVisible = false),
            child: Icon(Icons.close, size: 18, color: AppColor.darkGrey),
          ),
        ],
      ),
    );
  }
}
