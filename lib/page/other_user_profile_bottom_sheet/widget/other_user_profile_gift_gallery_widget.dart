import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:tingle/common/widget/gift_gallery_bottom_sheet_widget.dart';
import 'package:tingle/page/other_user_profile_bottom_sheet/view/other_user_profile_bottom_sheet.dart';
import 'package:tingle/utils/color.dart';
import 'package:tingle/utils/enums.dart';
import 'package:tingle/utils/font_style.dart';
import 'package:tingle/utils/utils.dart';

class OtherUserProfileGiftGalleryWidget extends StatelessWidget {
  const OtherUserProfileGiftGalleryWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => GiftGalleryBottomSheetWidget.show(context: context, userId: OtherUserProfileBottomSheet.userid.value),
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
                  "${EnumLocal.txtTotalGiftReceived.name.tr} : ${OtherUserProfileBottomSheet.otherUserProfileModel?.user?.receivedGifts ?? 0}",
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
