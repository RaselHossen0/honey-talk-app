import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';
import 'package:tingle/page/bottom_bar_page/controller/bottom_bar_controller.dart';
import 'package:tingle/page/message_page/controller/message_controller.dart';
import 'package:tingle/utils/assets.dart';
import 'package:tingle/utils/color.dart';
import 'package:tingle/utils/constant.dart';
import 'package:tingle/utils/font_style.dart';
import 'package:tingle/utils/utils.dart';

class BottomBarWidget extends StatelessWidget {
  const BottomBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<BottomBarController>(
      id: AppConstant.onChangeBottomBar,
      builder: (logic) {
        return Obx(
          () => Container(
            height: AppConstant.bottomBarSize.toDouble(),
            color: Utils.isExtendBody.value ? AppColor.transparent : AppColor.white,
            width: Get.width,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                ItemWidget(
                  icon: logic.selectedTabIndex == 0 ? AppAssets.icSelectedStream : AppAssets.icStream,
                  callback: () => logic.onChangeBottomBar(0),
                ),
                ItemWidget(
                  icon: logic.selectedTabIndex == 1 ? AppAssets.icSelectedParty : AppAssets.icParty,
                  callback: () => logic.onChangeBottomBar(1),
                ),
                ItemWidget(
                  icon: logic.selectedTabIndex == 2 ? AppAssets.icSelectedFeed : AppAssets.icFeed,
                  callback: () => logic.onChangeBottomBar(2),
                ),
                _MessageTabItem(
                  isSelected: logic.selectedTabIndex == 3,
                  callback: () => logic.onChangeBottomBar(3),
                ),
                ItemWidget(
                  icon: logic.selectedTabIndex == 4 ? AppAssets.icSelectedProfile : AppAssets.icProfile,
                  callback: () => logic.onChangeBottomBar(4),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class ItemWidget extends StatelessWidget {
  const ItemWidget({super.key, required this.icon, required this.callback});

  final String icon;

  final Callback callback;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: callback,
        child: Container(
          color: AppColor.transparent,
          alignment: Alignment.center,
          padding: const EdgeInsets.only(top: 15),
          child: Image.asset(icon, width: 30),
        ),
      ),
    );
  }
}

class _MessageTabItem extends StatelessWidget {
  const _MessageTabItem({required this.isSelected, required this.callback});

  final bool isSelected;
  final Callback callback;

  @override
  Widget build(BuildContext context) {
    final unread = Get.find<MessageController>().totalUnreadCount;
    return Expanded(
      child: GestureDetector(
        onTap: callback,
        child: Container(
          color: AppColor.transparent,
          alignment: Alignment.center,
          padding: const EdgeInsets.only(top: 15),
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Image.asset(
                isSelected ? AppAssets.icSelectedMessage : AppAssets.icMessage,
                width: 30,
              ),
              if (unread > 0)
                Positioned(
                  top: -4,
                  right: 8,
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    constraints: const BoxConstraints(minWidth: 18, minHeight: 18),
                    decoration: const BoxDecoration(
                      color: AppColor.red,
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Text(
                        unread > 99 ? "99+" : "$unread",
                        style: AppFontStyle.styleW600(AppColor.white, 10),
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
