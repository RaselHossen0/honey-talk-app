import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:tingle/common/widget/gift_gallery_bottom_sheet_widget.dart';
import 'package:tingle/page/preview_user_profile_page/controller/preview_user_profile_controller.dart';
import 'package:tingle/utils/color.dart';
import 'package:tingle/utils/enums.dart';
import 'package:tingle/utils/font_style.dart';
import 'package:tingle/utils/utils.dart';

class PreviewProfileGiftGalleryWidget extends GetView<PreviewUserProfileController> {
  const PreviewProfileGiftGalleryWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => GiftGalleryBottomSheetWidget.show(context: context, userId: controller.userId),
      child: Container(
        height: 80,
        width: Get.width,
        margin: EdgeInsets.symmetric(horizontal: 15),
        padding: EdgeInsets.symmetric(horizontal: 15),
        decoration: BoxDecoration(
          color: AppColor.colorBorder.withValues(alpha: 0.5),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Row(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  EnumLocal.txtGiftGallery.name.tr,
                  style: AppFontStyle.styleW700(AppColor.black, 16),
                ),
                3.height,
                Text(
                  "${EnumLocal.txtTotalReceivedGift.name.tr} ${controller.fetchUserProfileModel?.user?.receivedGifts ?? 0}",
                  style: AppFontStyle.styleW500(AppColor.grayText, 12),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
