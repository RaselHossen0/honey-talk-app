import 'package:flutter/material.dart';

class CustomCircleCheckbox extends StatelessWidget {
  final bool isChecked;
  final ValueChanged<bool> onChanged;
  final double size;
  final Color activeColor;
  final Color borderColor;

  const CustomCircleCheckbox({
    super.key,
    required this.isChecked,
    required this.onChanged,
    this.size = 24,
    this.activeColor = Colors.blue,
    this.borderColor = Colors.grey,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onChanged(!isChecked),
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: isChecked ? activeColor : Colors.transparent,
          border: Border.all(
            color: isChecked ? activeColor : borderColor,
            width: 2,
          ),
        ),
        child: isChecked
            ? Center(
                child: Icon(
                  Icons.check,
                  size: size * 0.7,
                  color: Colors.white,
                ),
              )
            : null,
      ),
    );
  }
}
