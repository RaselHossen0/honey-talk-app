import 'package:flutter/material.dart';
import 'package:text_scroll/text_scroll.dart';

class FadingAutoScrollText extends StatelessWidget {
  final String text;
  final TextStyle style;

  const FadingAutoScrollText({
    super.key,
    required this.text,
    required this.style,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 2.0),
      child: ShaderMask(
        shaderCallback: (Rect bounds) {
          return LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: [
              Colors.transparent,
              Colors.white,
              Colors.white,
              Colors.transparent,
            ],
            stops: const [0.0, 0.1, 0.9, 1.0],
          ).createShader(bounds);
        },
        blendMode: BlendMode.dstIn,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 0.0),
          child: TextScroll(
            text,
            style: style,
            velocity: const Velocity(pixelsPerSecond: Offset(40, 0)),
            fadedBorderWidth: 70,
            delayBefore: Duration.zero, // No delay before start
            pauseBetween: Duration.zero, // No pause between loops
            mode: TextScrollMode.endless, // Keep scrolling forever
            textAlign: TextAlign.left,
            intervalSpaces: 10,

            fadeBorderVisibility: FadeBorderVisibility.auto,
            selectable: false,
          ),
        ),
      ),
    );
  }
}
