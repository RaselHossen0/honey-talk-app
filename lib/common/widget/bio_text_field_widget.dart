import 'package:flutter/material.dart';
import 'package:tingle/utils/color.dart';
import 'package:tingle/utils/font_style.dart';
import 'package:tingle/utils/utils.dart';

class BioTextFieldWidget extends StatelessWidget {
  const BioTextFieldWidget({super.key, this.title, this.hintText, this.controller});

  final String? title;
  final String? hintText;
  final TextEditingController? controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        title != null
            ? Column(
                children: [
                  Text(
                    title!,
                    style: AppFontStyle.styleW500(AppColor.grayText, 14),
                  ),
                  5.height,
                ],
              )
            : const Offstage(),
        TextFormField(
          keyboardType: TextInputType.text,
          controller: controller,
          maxLines: null,
          minLines: 3,
          cursorColor: AppColor.secondary,
          style: AppFontStyle.styleW600(AppColor.black, 15),
          textAlignVertical: TextAlignVertical.top,
          textAlign: TextAlign.left,
          decoration: InputDecoration(
            filled: true,
            fillColor: AppColor.white,
            hintText: hintText,
            border: InputBorder.none,
            contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 18),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: AppColor.secondary.withValues(alpha: 0.2)),
              borderRadius: BorderRadius.circular(12),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: AppColor.primary.withValues(alpha: 0.5)),
              borderRadius: BorderRadius.circular(12),
            ),
            errorBorder: OutlineInputBorder(
              borderSide: BorderSide(color: AppColor.red.withValues(alpha: 0.5)),
              borderRadius: BorderRadius.circular(12),
            ),
            hintStyle: AppFontStyle.styleW500(AppColor.secondary, 15),
            alignLabelWithHint: true,
          ),
        ),
      ],
    );
  }
}
