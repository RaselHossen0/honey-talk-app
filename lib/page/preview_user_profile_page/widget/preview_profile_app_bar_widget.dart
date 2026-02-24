import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tingle/page/preview_user_profile_page/controller/preview_user_profile_controller.dart';
import 'package:tingle/routes/app_routes.dart';
import 'package:tingle/utils/assets.dart';
import 'package:tingle/utils/color.dart';
import 'package:tingle/utils/constant.dart';
import 'package:tingle/utils/database.dart';
import 'package:tingle/utils/font_style.dart';

class PreviewProfileAppBarWidget extends StatelessWidget {
  const PreviewProfileAppBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PreviewUserProfileController>(
      id: AppConstant.onToggleAppBar,
      builder: (controller) => Container(
        height: MediaQuery.of(context).viewPadding.top + 50,
        padding: EdgeInsets.only(top: MediaQuery.of(context).viewPadding.top, left: 0, right: 5),
        alignment: Alignment.center,
        width: Get.width,
        color: controller.isShowAppBar ? AppColor.white : AppColor.transparent,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: Get.back,
              child: Container(
                height: 45,
                width: 45,
                alignment: Alignment.center,
                decoration: const BoxDecoration(shape: BoxShape.circle, color: AppColor.transparent),
                child: Image.asset(
                  AppAssets.icArrowLeft,
                  color: controller.isShowAppBar ? AppColor.black : AppColor.white,
                  width: 10,
                ),
              ),
            ),
            Expanded(
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  (controller.fetchUserProfileModel?.user?.name ?? ""),
                  maxLines: 1,
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                  style: AppFontStyle.styleW700(controller.isShowAppBar ? AppColor.black : AppColor.transparent, 19),
                ),
              ),
            ),
            Visibility(
              visible: Database.loginUserId == controller.userId,
              child: GestureDetector(
                onTap: () => Get.toNamed(AppRoutes.editProfilePage),
                child: Container(
                  height: 45,
                  width: 45,
                  alignment: Alignment.center,
                  decoration: const BoxDecoration(shape: BoxShape.circle, color: AppColor.transparent),
                  child: Image.asset(
                    AppAssets.icEditPen,
                    color: controller.isShowAppBar ? AppColor.black : AppColor.white,
                    width: 25,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
