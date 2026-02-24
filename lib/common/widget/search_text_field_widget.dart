import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';
import 'package:tingle/utils/assets.dart';
import 'package:tingle/utils/color.dart';
import 'package:tingle/utils/font_style.dart';
import 'package:tingle/utils/utils.dart';

class SearchTextFieldWidget extends StatelessWidget {
  const SearchTextFieldWidget({
    super.key,
    required this.onClickClear,
    required this.controller,
    required this.onChanged,
    required this.isShowClearIcon,
    required this.onTap, required this.hintText,
  });

  final Callback onClickClear;
  final Callback onTap;
  final TextEditingController controller;
  final Function(String value) onChanged;
  final bool isShowClearIcon;
  final String hintText;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 45,
      width: Get.width,
      padding: const EdgeInsets.only(left: 12, right: 12),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: AppColor.secondary.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(100),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            height: 20,
            width: 20,
            AppAssets.icSearch,
            color: AppColor.black,
          ),
          12.width,
          Expanded(
            child: TextFormField(
              controller: controller,
              cursorColor: AppColor.secondary,
              maxLines: 1,
              onTap: onTap,
              onChanged: onChanged,
              style: AppFontStyle.styleW600(AppColor.black, 15),
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.only(bottom: 5),
                border: InputBorder.none,
                hintText: hintText,
                hintStyle: AppFontStyle.styleW500(AppColor.secondary, 15),
              ),
            ),
          ),
          GestureDetector(
            onTap: onClickClear,
            child: Container(
              height: 22,
              width: 22,
              decoration: BoxDecoration(
                color: isShowClearIcon ? AppColor.red : AppColor.secondary.withValues(alpha: 0.8),
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Image.asset(
                  height: 15,
                  width: 15,
                  AppAssets.icClose,
                  color: AppColor.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
