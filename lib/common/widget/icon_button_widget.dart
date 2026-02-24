import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';
import 'package:tingle/utils/color.dart';

class IconButtonWidget extends StatelessWidget {
  const IconButtonWidget({
    super.key,
    this.circleColor,
    this.circleBorderColor,
    this.circleSize,
    this.circleGradient,
    required this.icon,
    this.iconColor,
    this.iconSize,
    this.callback,
    required this.visible,
    this.margin,
  });

  final Color? circleColor;
  final Color? circleBorderColor;
  final Gradient? circleGradient;
  final String icon;
  final Color? iconColor;
  final double? circleSize;
  final double? iconSize;
  final Callback? callback;
  final bool visible;
  final EdgeInsetsGeometry? margin;

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: visible,
      child: GestureDetector(
        onTap: callback,
        child: Container(
          height: circleSize ?? 42,
          width: circleSize ?? 42,
          margin: margin,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: circleColor,
            gradient: circleGradient,
            border: Border.all(color: circleBorderColor ?? AppColor.transparent),
          ),
          child: Image.asset(icon, height: iconSize, width: iconSize, color: iconColor),
        ),
      ),
    );
  }
}
