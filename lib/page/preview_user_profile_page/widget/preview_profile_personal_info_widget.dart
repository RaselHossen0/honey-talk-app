import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:tingle/routes/app_routes.dart';
import 'package:tingle/utils/color.dart';
import 'package:tingle/utils/enums.dart';
import 'package:tingle/utils/font_style.dart';
import 'package:tingle/utils/utils.dart';

class PreviewProfilePersonalInfoWidget extends StatelessWidget {
  const PreviewProfilePersonalInfoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Get.toNamed(AppRoutes.editProfilePage),
      child: Container(
        height: 80,
        width: Get.width,
        margin: EdgeInsets.symmetric(horizontal: 15),
        padding: EdgeInsets.symmetric(horizontal: 15),
        decoration: BoxDecoration(
          color: AppColor.transparent,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Row(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  EnumLocal.txtPersonalInformation.name.tr,
                  style: AppFontStyle.styleW700(AppColor.black, 16),
                ),
                3.height,
                Text(
                  EnumLocal.txtSheHeWasLazyAndLeft.name.tr,
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
