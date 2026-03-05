import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tingle/page/preview_user_profile_page/controller/preview_user_profile_controller.dart';
import 'package:tingle/utils/color.dart';
import 'package:tingle/utils/constant.dart';
import 'package:tingle/utils/enums.dart';
import 'package:tingle/utils/font_style.dart';
import 'package:tingle/utils/utils.dart';

class PreviewProfileReviewWidget extends StatelessWidget {
  const PreviewProfileReviewWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PreviewUserProfileController>(
      id: AppConstant.onGetProfile,
      builder: (_) {
        // Placeholder tags - can be wired to API later
        final tags = <Map<String, dynamic>>[
          {"label": "Young", "count": 2, "color": const Color(0xFFE8E0F5)},
          {"label": "Beautiful", "count": 2, "color": const Color(0xFFE8E0F5)},
          {"label": "Graceful", "count": 2, "color": const Color(0xFFE8E0F5)},
          {"label": "Elegant", "count": 1, "color": const Color(0xFFE8E0F5)},
          {"label": "Cute", "count": 1, "color": const Color(0xFFFFE4EC)},
          {"label": "Charming voice", "count": 1, "color": const Color(0xFFFFE4EC)},
          {"label": "Coquettish", "count": 1, "color": const Color(0xFFFFE4EC)},
        ];

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                EnumLocal.txtReview.name.tr,
                style: AppFontStyle.styleW700(AppColor.black, 16),
              ),
              10.height,
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: tags
                    .map(
                      (t) => Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: t["color"] as Color,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          "${t["label"]}-${t["count"]}",
                          style: AppFontStyle.styleW500(AppColor.grayText, 12),
                        ),
                      ),
                    )
                    .toList(),
              ),
            ],
          ),
        );
      },
    );
  }
}
