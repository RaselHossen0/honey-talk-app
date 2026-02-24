import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';
import 'package:tingle/utils/color.dart';
import 'package:tingle/utils/font_style.dart';
import 'package:tingle/utils/utils.dart';

class CountryTextFieldWidget extends StatelessWidget {
  const CountryTextFieldWidget({super.key, required this.flag, required this.country, required this.callback});

  final String flag;
  final String country;
  final Callback callback;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: callback,
      child: Container(
        height: 60,
        width: Get.width,
        padding: const EdgeInsets.only(left: 20),
        decoration: BoxDecoration(
          color: AppColor.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: AppColor.secondary.withValues(alpha: 0.2)),
        ),
        child: Row(
          children: [
            Text(
              flag,
              style: AppFontStyle.styleW500(AppColor.grayText, 20),
            ),
            10.width,
            Text(
              country.isNotEmpty ? (country[0].toUpperCase() + country.substring(1).toLowerCase()) : country,
              style: AppFontStyle.styleW600(AppColor.black, 15),
            ),
            Spacer(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Icon(Icons.keyboard_arrow_down_rounded, color: AppColor.secondary),
            ),
            10.width,
          ],
        ),
      ),
    );
  }
}
