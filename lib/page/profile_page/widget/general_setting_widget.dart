import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';
import 'package:tingle/page/profile_page/controller/profile_controller.dart';
import 'package:tingle/routes/app_routes.dart';
import 'package:tingle/utils/assets.dart';
import 'package:tingle/utils/color.dart';
import 'package:tingle/utils/enums.dart';
import 'package:tingle/utils/font_style.dart';
import 'package:tingle/utils/utils.dart';

class GeneralSettingWidget extends StatelessWidget {
  const GeneralSettingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width,
      margin: const EdgeInsets.symmetric(horizontal: 15),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: AppColor.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: AppColor.secondary.withValues(alpha: 0.08),
            blurRadius: 2,
            spreadRadius: 2,
          ),
        ],
      ),
      child: GetBuilder<ProfileController>(builder: (controller) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // ItemWidget(
                //   title: EnumLocal.txtGuardian.name.tr,
                //   image: AppAssets.icGuardianIcon,
                //   callback: () async {},
                // ),
                ItemWidget(
                  title: EnumLocal.txtLiveData.name.tr,
                  image: AppAssets.icLiveDataIcon,
                  callback: () {},
                ),
                ItemWidget(
                  title: EnumLocal.txtMyIncome.name.tr,
                  image: AppAssets.icMyCoin,
                  callback: () => Get.toNamed(AppRoutes.myIncomePage)?.then(
                    (value) {
                      Utils.onChangeStatusBar(brightness: Brightness.dark);
                      controller.scrollController.jumpTo(0.0);
                    },
                  ),
                ),
                ItemWidget(
                  title: EnumLocal.txtBackpack.name.tr,
                  image: AppAssets.icBackpackIcon,
                  callback: () {
                    Get.toNamed(AppRoutes.backpackPage)?.then(
                      (value) {
                        Utils.onChangeStatusBar(brightness: Brightness.dark);
                        controller.scrollController.jumpTo(0.0);
                      },
                    );
                  },
                ),
                ItemWidget(
                  title: EnumLocal.txtHelp.name.tr,
                  image: AppAssets.icHelpIcon,
                  callback: () => Get.toNamed(AppRoutes.helpPage)?.then((value) {
                    Utils.onChangeStatusBar(brightness: Brightness.dark);
                    controller.scrollController.jumpTo(0.0);
                  }),
                ),
                ItemWidget(
                  title: EnumLocal.txtMyAgency.name.tr,
                  image: AppAssets.icMyAgencyIcon,
                  callback: () {},
                ),
              ],
            ),
            15.height,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ItemWidget(
                  title: EnumLocal.txtMyProfile.name.tr,
                  image: AppAssets.icProfile,
                  callback: () => Get.toNamed(AppRoutes.myProfilePage)?.then(
                    (value) {
                      Utils.onChangeStatusBar(brightness: Brightness.dark);
                      controller.scrollController.jumpTo(0.0);
                    },
                  ),
                ),
                ItemWidget(
                  title: EnumLocal.txtAboutUs.name.tr,
                  image: AppAssets.icAboutUsIcon,
                  callback: () {},
                ),
                ItemWidget(
                  title: EnumLocal.txtSettings.name.tr,
                  image: AppAssets.icSettingIcon,
                  callback: () {},
                ),
                ItemWidget(
                  title: EnumLocal.txtMyChatPrice.name.tr,
                  image: AppAssets.icVideoCallBorder,
                  callback: () => Get.toNamed(AppRoutes.myChatPricePage)?.then(
                    (value) {
                      Utils.onChangeStatusBar(brightness: Brightness.dark);
                      controller.scrollController.jumpTo(0.0);
                    },
                  ),
                ),
              ],
            ),
            15.height,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ItemWidget(
                  title: EnumLocal.txtMyLivePictures.name.tr,
                  image: AppAssets.icUploadLiveRoomImage,
                  callback: () => Get.toNamed(AppRoutes.myLivePicturesPage)?.then(
                    (value) {
                      Utils.onChangeStatusBar(brightness: Brightness.dark);
                      controller.scrollController.jumpTo(0.0);
                    },
                  ),
                ),
                ItemWidget(
                  title: EnumLocal.txtCharmingLevel.name.tr,
                  image: AppAssets.icLevelIcon,
                  callback: () => Get.toNamed(AppRoutes.charmingLevelPage)?.then(
                    (value) {
                      Utils.onChangeStatusBar(brightness: Brightness.dark);
                      controller.scrollController.jumpTo(0.0);
                    },
                  ),
                ),
                ItemWidget(
                  title: EnumLocal.txtWealthLevel.name.tr,
                  image: AppAssets.icWealthLevel,
                  callback: () => Get.toNamed(AppRoutes.wealthLevelPage)?.then(
                    (value) {
                      Utils.onChangeStatusBar(brightness: Brightness.dark);
                      controller.scrollController.jumpTo(0.0);
                    },
                  ),
                ),
              ],
            ),
          ],
        );
      }),
    );
  }
}

class ItemWidget extends StatelessWidget {
  const ItemWidget({
    super.key,
    required this.title,
    required this.image,
    required this.callback,
  });

  final String title;
  final String image;

  final Callback callback;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: callback,
      child: Column(
        children: [
          Container(
            height: 54,
            width: 54,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: AppColor.secondary.withValues(alpha: 0.07),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Image.asset(
              image,
              width: 26,
            ),
          ),
          5.height,
          Text(
            title,
            style: AppFontStyle.styleW500(AppColor.lightGreyPurple, 11),
          )
        ],
      ),
    );
  }
}
