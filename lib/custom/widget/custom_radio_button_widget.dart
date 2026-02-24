import 'package:flutter/material.dart';

class CustomRadioButtonWidget extends StatelessWidget {
  const CustomRadioButtonWidget({super.key, required this.isSelected, required this.size, required this.borderColor, required this.activeColor});

  final bool isSelected;
  final double size;
  final Color borderColor;
  final Color activeColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size,
      width: size,
      padding: const EdgeInsets.all(1.5),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: borderColor),
      ),
      child: Visibility(
        visible: isSelected,
        child: Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: activeColor,
          ),
        ),
      ),
    );
  }
}
