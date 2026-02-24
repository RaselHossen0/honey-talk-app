import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:tingle/common/function/gender_icon.dart';
import 'package:tingle/common/widget/preview_network_image_widget.dart';
import 'package:tingle/page/profile_page/controller/profile_controller.dart';
import 'package:tingle/routes/app_routes.dart';
import 'package:tingle/utils/assets.dart';
import 'package:tingle/utils/color.dart';
import 'package:tingle/utils/constant.dart';
import 'package:tingle/utils/enums.dart';
import 'package:tingle/utils/font_style.dart';
import 'package:tingle/utils/utils.dart';

class ProfileDetailsWidget extends StatelessWidget {
  const ProfileDetailsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProfileController>(
      id: AppConstant.onGetProfile,
      builder: (controller) => GestureDetector(
        onTap: () => Get.toNamed(
          AppRoutes.previewUserProfilePage,
          arguments: controller.fetchUserProfileModel?.user?.id ?? "",
        )?.then((value) {
          Utils.onChangeStatusBar(brightness: Brightness.dark);
          controller.scrollController.jumpTo(0.0);
        }),
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 15),
          color: AppColor.transparent,
          child: Row(
            children: [
              Container(
                height: 68,
                width: 68,
                margin: const EdgeInsets.all(2),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: (controller.fetchUserProfileModel?.user?.activeAvtarFrame?.image?.trim().isEmpty ?? true) ? Border.all(color: AppColor.white, width: 2) : null,
                ),
                child: Container(
                  height: 68,
                  width: 68,
                  clipBehavior: Clip.none,
                  decoration: const BoxDecoration(
                    color: AppColor.transparent,
                    shape: BoxShape.circle,
                  ),
                  child: PreviewProfileImageWithFrameWidget(
                    image: controller.fetchUserProfileModel?.user?.image,
                    isBanned: controller.fetchUserProfileModel?.user?.isProfilePicBanned ?? false,
                    fit: BoxFit.cover,
                    frame: controller.fetchUserProfileModel?.user?.activeAvtarFrame?.image ?? "",
                    type: controller.fetchUserProfileModel?.user?.activeAvtarFrame?.type ?? 1,
                    margin: EdgeInsets.all(10),
                  ),
                ),
              ),
              10.width,
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: Get.width,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Flexible(
                            fit: FlexFit.loose,
                            child: Text(
                              maxLines: 1,
                              controller.fetchUserProfileModel?.user?.name ?? "",
                              style: AppFontStyle.styleW700(AppColor.black, 16),
                            ),
                          ),
                          Visibility(
                            visible: controller.fetchUserProfileModel?.user?.isVerified ?? false,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 5, top: 6),
                              child: Image.asset(AppAssets.icAuthoriseIcon, width: 15),
                            ),
                          ),
                        ],
                      ),
                    ),
                    3.height,
                    Row(
                      children: [
                        Container(
                          height: 18,
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          decoration: BoxDecoration(
                            color: AppColor.primary,
                            borderRadius: BorderRadius.circular(100),
                          ),
                          child: Row(
                            children: [
                              Image.asset(GenderIcon.onShow(controller.fetchUserProfileModel?.user?.gender ?? ""), width: 10),
                              3.width,
                              Text(
                                (controller.fetchUserProfileModel?.user?.age ?? 0).toString(),
                                style: AppFontStyle.styleW600(AppColor.white, 10),
                              ),
                            ],
                          ),
                        ),
                        5.width,
                        PreviewWealthLevelImage(
                          image: controller.fetchUserProfileModel?.user?.wealthLevel?.levelImage,
                          height: 18,
                          width: 40,
                        ),
                      ],
                    ),
                    5.height,
                    GestureDetector(
                      onTap: () {
                        Clipboard.setData(ClipboardData(text: (controller.fetchUserProfileModel?.user?.uniqueId).toString()));
                        Utils.showToast(text: EnumLocal.txtCopiedOnClipboard.name.tr);
                      },
                      child: Container(
                        color: AppColor.transparent,
                        child: Row(
                          children: [
                            Text(
                              "ID: ${controller.fetchUserProfileModel?.user?.uniqueId ?? 0}",
                              style: AppFontStyle.styleW400(AppColor.grayText, 11),
                            ),
                            5.width,
                            Image.asset(AppAssets.icCopyId, width: 13),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Image.asset(AppAssets.icArrowRight, width: 8),
              10.width,
            ],
          ),
        ),
      ),
    );
  }
}
