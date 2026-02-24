import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';
import 'package:tingle/common/widget/preview_network_image_widget.dart';
import 'package:tingle/utils/assets.dart';
import 'package:tingle/utils/color.dart';
import 'package:tingle/utils/enums.dart';
import 'package:tingle/utils/font_style.dart';
import 'package:tingle/utils/utils.dart';

class MentionUserListTileWidget extends StatelessWidget {
  const MentionUserListTileWidget({
    super.key,
    required this.name,
    required this.userName,
    required this.image,
    required this.callback,
    required this.isVerified,
    required this.isSelected,
    required this.isProfileImageBanned,
  });

  final String name;
  final String userName;
  final String image;
  final bool isVerified;
  final bool isProfileImageBanned;
  final bool isSelected;
  final Callback callback;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      width: Get.width,
      padding: const EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
        color: AppColor.transparent,
        border: Border(
          bottom: BorderSide(color: AppColor.secondary.withValues(alpha: 0.2)),
        ),
      ),
      child: Row(
        children: [
          Container(
            height: 46,
            width: 46,
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(color: AppColor.secondary, shape: BoxShape.circle),
            child: PreviewProfileImageWidget(image: image, isBanned: isProfileImageBanned),
          ),
          12.width,
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Flexible(
                      fit: FlexFit.loose,
                      child: Text(
                        name,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: AppFontStyle.styleW700(AppColor.black, 14.5),
                      ),
                    ),
                    Visibility(
                      visible: isVerified,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 3),
                        child: Image.asset(AppAssets.icAuthoriseIcon, width: 18),
                      ),
                    ),
                  ],
                ),
                Text(
                  userName,
                  maxLines: 1,
                  style: AppFontStyle.styleW400(AppColor.secondary, 13),
                ),
              ],
            ),
          ),
          Spacer(),
          GestureDetector(
            onTap: callback,
            child: Container(
              height: 30,
              alignment: Alignment.center,
              clipBehavior: Clip.antiAlias,
              padding: EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                color: AppColor.primary.withValues(alpha: 0.05),
                borderRadius: BorderRadius.circular(100),
              ),
              child: Text(
                isSelected ? EnumLocal.txtRemove.name.tr : EnumLocal.txtAdd.name.tr,
                style: AppFontStyle.styleW600(AppColor.primary, 12),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
