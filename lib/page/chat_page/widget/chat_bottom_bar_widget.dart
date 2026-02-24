import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';
import 'package:tingle/utils/assets.dart';
import 'package:tingle/utils/color.dart';

class ChatBottomBarWidget extends StatelessWidget {
  const ChatBottomBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: Get.width,
      color: AppColor.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ItemWidget(
            icon: AppAssets.icChatGallery,
            iconSize: 30,
            callBack: () {},
          ),
          ItemWidget(
            icon: AppAssets.icChatEmoji,
            iconSize: 33,
            callBack: () {},
          ),
          ItemWidget(
            icon: AppAssets.icChatGift,
            iconSize: 32,
            callBack: () {},
          ),
        ],
      ),
    );
  }
}

class ItemWidget extends StatelessWidget {
  const ItemWidget({super.key, required this.callBack, required this.icon, required this.iconSize});

  final String icon;
  final double iconSize;
  final Callback callBack;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: callBack,
        child: Container(
          height: 35,
          alignment: Alignment.center,
          color: AppColor.transparent,
          child: Image.asset(icon, width: iconSize),
        ),
      ),
    );
  }
}
