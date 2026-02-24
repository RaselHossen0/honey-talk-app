import 'package:flutter/material.dart';
import 'package:tingle/custom/function/custom_format_number.dart';
import 'package:tingle/utils/color.dart';
import 'package:tingle/utils/font_style.dart';

class CoinValidityText extends StatelessWidget {
  final String? coin;
  final String? validity;
  final int? validityType; // 1 = Day, 2 = Month, 3 = Year
  final bool? sortLabel;
  final TextStyle? style;
  const CoinValidityText({
    super.key,
    this.coin,
    this.validity,
    this.validityType,
    this.sortLabel,
    this.style,
  });

  String getValidityLabel() {
    switch (validityType) {
      case 1:
        return "day";
      case 2:
        return "month";
      case 3:
        return "year";
      default:
        return "day"; // fallback
    }
  }

  String getShortValidityLabel() {
    switch (validityType) {
      case 1:
        return "d";
      case 2:
        return "m";
      case 3:
        return "y";
      default:
        return "d"; // fallback
    }
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      sortLabel != null && sortLabel == true
          ? "${CustomFormatNumber.onConvert(int.parse(coin ?? "0"))}/${validity ?? ""}${getShortValidityLabel()}"
          : "${CustomFormatNumber.onConvert(int.parse(coin ?? "0"))}/${validity ?? ""}${getValidityLabel()}",
      style: style ?? AppFontStyle.styleW600(AppColor.darkYellow, 14),
    );
  }
}

//ignore: must_be_immutable
class TimeValidityText extends StatelessWidget {
  final int? validity;
  final int? validityType; // 1 = Day, 2 = Month, 3 = Year
  Color? textColor;
  TimeValidityText({
    super.key,
    this.validity,
    this.validityType,
    this.textColor,
  });

  String getValidityLabel() {
    switch (validityType) {
      case 1:
        return "day";
      case 2:
        return "month";
      case 3:
        return "year";
      default:
        return "day"; // fallback
    }
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      "${validity ?? ""}${getValidityLabel()}",
      style: AppFontStyle.styleW600(textColor ?? AppColor.darkYellow, 14),
    );
  }
}
