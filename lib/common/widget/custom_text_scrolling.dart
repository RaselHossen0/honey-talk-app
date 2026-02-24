import 'package:flutter/material.dart';

import 'package:text_scroll/text_scroll.dart';

class CustomTextScrolling extends StatelessWidget {
  const CustomTextScrolling({
    super.key,
    required this.text,
    required this.style,
  });

  final String text;
  final TextStyle style;

  @override
  Widget build(BuildContext context) {
    return TextScroll(
      text,
      fadeBorderVisibility: FadeBorderVisibility.always,
      mode: TextScrollMode.endless,
      velocity: Velocity(pixelsPerSecond: Offset(40, 0)),
      delayBefore: Duration(milliseconds: 500),
      // numberOfReps: 10,
      pauseBetween: Duration(seconds: 2),
      style: style,
      textAlign: TextAlign.left,
      selectable: true,
    );
  }
}
