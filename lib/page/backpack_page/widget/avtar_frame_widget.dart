import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tingle/utils/color.dart';
import 'package:tingle/utils/enums.dart';
import 'package:tingle/utils/font_style.dart';
import 'package:tingle/utils/utils.dart';

class AvatarFrameWidget extends StatelessWidget {
  final int ownedCount;
  final List<String> frameAssets;
  final String title;

  const AvatarFrameWidget({
    super.key,
    required this.ownedCount,
    required this.frameAssets,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: AppFontStyle.styleW600(AppColor.black, 16),
              ),
              Row(
                children: [
                  Text("${EnumLocal.txtOwn.name.tr} $ownedCount", style: AppFontStyle.styleW600(AppColor.darkGray, 14)),
                  const Icon(Icons.arrow_forward_ios, size: 14, color: Colors.grey),
                ],
              )
            ],
          ),
          const SizedBox(height: 12),
          SizedBox(
            height: 70,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: frameAssets.length,
              separatorBuilder: (_, __) => 12.width,
              itemBuilder: (context, index) {
                return Container(
                  width: 75,
                  height: 75,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Image.asset(
                    frameAssets[index],
                    fit: BoxFit.cover,
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
