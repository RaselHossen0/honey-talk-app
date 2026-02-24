import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tingle/common/function/fetch_user_coin.dart';
import 'package:tingle/common/widget/preview_network_image_widget.dart';
import 'package:tingle/custom/widget/custom_check_box.dart';
import 'package:tingle/page/profile_page/api/fetch_user_profile_api.dart';
import 'package:tingle/page/profile_page/model/fetch_user_profile_model.dart';
import 'package:tingle/page/store_page/api/purchase_theme_dart.dart';
import 'package:tingle/page/store_page/controller/store_controller.dart';
import 'package:tingle/routes/app_routes.dart';
import 'package:tingle/utils/assets.dart';
import 'package:tingle/utils/color.dart';
import 'package:tingle/utils/database.dart';
import 'package:tingle/utils/enums.dart';
import 'package:tingle/utils/font_style.dart';
import 'package:tingle/utils/utils.dart';

class PreviewSVGADaiLog {
  static FetchUserProfileModel? fetchUserProfileModel;
  static RxBool isLoadingProfile = false.obs;
  static RxBool isWearDirectly = false.obs;
  static RxBool isFollow = false.obs;

  static Future<void> onGetProfile(String userId) async {
    isLoadingProfile.value = true;

    fetchUserProfileModel = getDummyFetchUserProfile();
    if (fetchUserProfileModel?.user?.name != null) {
      // isFollow.value = fetchUserProfileModel?.user?.isFollow ?? false;
      isLoadingProfile.value = false;
    }
  }

  static Future<void> onClickFollow(String userId) async {
    if (userId != Database.loginUserId) {
      isFollow.value = !isFollow.value;
    } else {
      Utils.showToast(text: EnumLocal.txtYouCantFollowYourOwnAccount.name.tr);
    }
  }

  static void show({
    required String userId,
    required BuildContext context,
    String? itemType,
    bool? isfake,
    dynamic frameData,
  }) {
    onGetProfile(userId);
    FetchUserCoin.init();

    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return Obx(() {
          return Dialog(
              insetPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 40),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
              child: Container(
                // height: 100,
                width: Get.width * 0.8,
                decoration: BoxDecoration(
                  color: AppColor.white,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      height: 65,
                      alignment: Alignment.topRight,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30),
                          topRight: Radius.circular(30),
                        ),
                      ),
                      child: GestureDetector(
                        onTap: () => Navigator.of(context).pop(),
                        child: Container(
                          height: 30,
                          width: 30,
                          margin: const EdgeInsets.only(right: 20, top: 20),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: AppColor.transparent,
                            border: Border.all(color: AppColor.black),
                          ),
                          child: Center(
                            child: Image.asset(
                              AppAssets.icClose,
                              width: 18,
                              color: AppColor.black,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      height: 100,
                      width: 100,
                      decoration: BoxDecoration(shape: BoxShape.circle),
                      child: PreviewProfileWithSVGAWidget(
                        isfake: isfake,
                        height: 100,
                        width: 100,
                        isBanned: fetchUserProfileModel?.user?.isProfilePicBanned,
                        image: fetchUserProfileModel?.user?.image,
                        fit: BoxFit.cover,
                        frame: frameData,
                        itemType: itemType,
                      ),
                    ),
                    10.height,
                    Text(
                      frameData!.name ?? "",
                      style: AppFontStyle.styleW700(AppColor.colorLightBlue, 18),
                    ),
                    10.height,
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        textAlign: TextAlign.center,
                        EnumLocal.txtSureBuyThisFrame.name.tr,
                        style: AppFontStyle.styleW700(AppColor.black, 20),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CustomCircleCheckbox(
                          onChanged: (value) => isWearDirectly.value = !isWearDirectly.value,
                          isChecked: isWearDirectly.value,
                          size: 20,
                          activeColor: AppColor.primary,
                          borderColor: AppColor.primary,
                        ),
                        5.width,
                        Text(EnumLocal.txtWearDirectly.name.tr, style: AppFontStyle.styleW500(AppColor.colorLightBlue, 14)),
                      ],
                    ),
                    GetBuilder<StoreController>(builder: (logic) {
                      return GestureDetector(
                        onTap: () {
                          if (FetchUserCoin.coin >= frameData.coin) {
                            PurchaseThemeApi.callApi(
                              token: logic.token,
                              itemType: itemType ?? "",
                              itemId: frameData.id,
                              userId: logic.uid,
                              directWear: isWearDirectly.value,
                            );
                          } else {
                            Get.toNamed(AppRoutes.rechargeCoinPage);
                          }
                        },
                        child: Container(
                          margin: const EdgeInsets.only(
                            top: 10,
                            left: 15,
                            right: 15,
                            bottom: 10,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                            color: AppColor.primary,
                          ),
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(EnumLocal.txtPayTheCoins.name.tr, style: AppFontStyle.styleW600(AppColor.white, 14)),
                                  Image.asset(AppAssets.icCoinStar, height: 22, width: 22),
                                  5.width,
                                  CoinText(coin: frameData.coin.toString()),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    })
                  ],
                ),
              ));
        });
      },
    );
  }
}

class CoinText extends StatelessWidget {
  final String? coin;

  const CoinText({super.key, this.coin});

  @override
  Widget build(BuildContext context) {
    return Text(
      "${coin ?? "0"}/coin",
      style: AppFontStyle.styleW700(AppColor.white, 12),
    );
  }
}
