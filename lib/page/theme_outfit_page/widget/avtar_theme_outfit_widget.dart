import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tingle/custom/widget/custum_frame_image.dart';
import 'package:tingle/page/backpack_page/controller/backpack_controller.dart';
import 'package:tingle/page/store_page/api/purchase_theme_dart.dart';
import 'package:tingle/page/theme_outfit_page/controller/theme_outfit_contoller.dart';
import 'package:tingle/utils/api_params.dart';
import 'package:tingle/utils/assets.dart';
import 'package:tingle/utils/color.dart';
import 'package:tingle/utils/enums.dart';
import 'package:tingle/utils/font_style.dart';
import 'package:tingle/utils/utils.dart';

class AvtarThemeOutfitWidget extends StatelessWidget {
  const AvtarThemeOutfitWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<BackpackController>(
      id: ApiParams.backpack,
      builder: (logic) {
        return Scaffold(
          backgroundColor: AppColor.white,
          body: Container(
              alignment: Alignment.topLeft,
              padding: EdgeInsets.only(left: 15, right: 15),
              color: AppColor.transparent,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    10.height,
                    Text(EnumLocal.txtMyAvatarFrame.name.tr, style: AppFontStyle.styleW600(AppColor.black, 20)),
                    10.height,
                    logic.fetchPurchasedFrameModel?.data?.avatarFrames?.active?.isEmpty ?? true
                        ? SizedBox(
                            height: 200,
                            width: Get.width,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  height: 100,
                                  width: 100,
                                  decoration: BoxDecoration(
                                    color: AppColor.white,
                                    borderRadius: BorderRadius.circular(10),
                                    image: DecorationImage(
                                      image: AssetImage(AppAssets.icEmpty),
                                      fit: BoxFit.contain,
                                    ),
                                  ),
                                ),
                                Text(
                                  EnumLocal.txtNotActivatedYet.name.tr,
                                  style: AppFontStyle.styleW400(AppColor.grayText, 14),
                                ),
                              ],
                            ),
                          )
                        : ListView.builder(
                            shrinkWrap: true,
                            itemCount: logic.fetchPurchasedFrameModel?.data?.avatarFrames?.active?.length ?? 0,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              return InkWell(
                                onTap: () {
                                  logic.isActiveFrame = index;
                                  logic.isExpiredFrame = -1;
                                  logic.update([ApiParams.backpack]);
                                },
                                overlayColor: WidgetStatePropertyAll(AppColor.transparent),
                                child: Container(
                                  margin: const EdgeInsets.only(bottom: 10),
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                      color: AppColor.white,
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(color: logic.isActiveFrame == index ? AppColor.primary : AppColor.black, width: 1.3)),
                                  child: Row(
                                    children: [
                                      Container(
                                          width: 75,
                                          height: 75,
                                          decoration: BoxDecoration(
                                            color: AppColor.lightGray,
                                            borderRadius: BorderRadius.circular(10),
                                          ),
                                          child: Image.asset(logic.fetchPurchasedFrameModel?.data?.avatarFrames?.active?[index].image ?? "")
                                          // CustomSVGAFrameWidget(
                                          //   type: logic.fetchPurchasedFrameModel?.data?.avatarFrames?.active?[index].type ?? 1,
                                          //   itemType: ApiParams.frame,
                                          //   imagePath: logic.fetchPurchasedFrameModel?.data?.avatarFrames?.active?[index].image ?? "",
                                          //   framePath: logic.fetchPurchasedFrameModel?.data?.avatarFrames?.active?[index].svgaImage,
                                          //   svgapadding: EdgeInsets.all(0),
                                          //   borderRadius: BorderRadius.circular(10),
                                          // )
                                          ),
                                      const SizedBox(width: 10),
                                      Column(
                                        children: [
                                          SizedBox(
                                            width: Get.width * 0.6,
                                            child: Wrap(crossAxisAlignment: WrapCrossAlignment.center, children: [
                                              Text(logic.fetchPurchasedFrameModel?.data?.avatarFrames?.active?[index].name ?? "",
                                                  style: AppFontStyle.styleW600(AppColor.black, 14)),
                                              const SizedBox(width: 5),
                                              (logic.fetchPurchasedFrameModel?.data?.avatarFrames?.active?[index].isSelected ?? false)
                                                  ? Container(
                                                      padding: EdgeInsets.symmetric(horizontal: 5, vertical: 3),
                                                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(15), gradient: AppColor.inUseGradient),
                                                      child: Text(EnumLocal.txtInUse.name.tr, style: AppFontStyle.styleW400(AppColor.white, 10)))
                                                  : Container(
                                                      padding: EdgeInsets.symmetric(horizontal: 5, vertical: 3),
                                                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(15), color: AppColor.lightGray),
                                                      child: Text(EnumLocal.txtNotActivatedYet.name.tr, style: AppFontStyle.styleW400(AppColor.colorLightBlue, 10)))
                                            ]),
                                          ),
                                          2.height,
                                          SizedBox(
                                            width: Get.width * 0.6,
                                            child: Text(
                                              "${EnumLocal.txtActivateBefore.name.tr} : ${logic.formatDateTime(logic.fetchPurchasedFrameModel?.data?.avatarFrames?.active?[index].expiryDate ?? DateTime.now())}",
                                              style: AppFontStyle.styleW500(
                                                AppColor.purpleGray,
                                                11,
                                              ),
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                    Text(EnumLocal.txtExpiredAvatarFrame.name.tr, style: AppFontStyle.styleW600(AppColor.black, 20)),
                    const SizedBox(
                      height: 10,
                    ),
                    logic.fetchPurchasedFrameModel?.data?.avatarFrames?.expired?.isEmpty ?? true
                        ? SizedBox(
                            height: 200,
                            width: Get.width,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  height: 100,
                                  width: 100,
                                  decoration: BoxDecoration(
                                    color: AppColor.white,
                                    borderRadius: BorderRadius.circular(10),
                                    image: DecorationImage(
                                      image: AssetImage(AppAssets.icEmpty),
                                      fit: BoxFit.contain,
                                    ),
                                  ),
                                ),
                                Text(
                                  EnumLocal.txtNoExpiredAvatarFramesYet.name.tr,
                                  style: AppFontStyle.styleW400(AppColor.grayText, 14),
                                ),
                              ],
                            ),
                          )
                        : ListView.builder(
                            shrinkWrap: true,
                            itemCount: logic.fetchPurchasedFrameModel?.data?.avatarFrames?.expired?.length ?? 0,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              return InkWell(
                                onTap: () {
                                  logic.isExpiredFrame = index;
                                  logic.isActiveFrame = -1;
                                  logic.update([ApiParams.backpack]);
                                },
                                overlayColor: WidgetStatePropertyAll(AppColor.transparent),
                                child: Container(
                                  margin: const EdgeInsets.only(bottom: 10),
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                      color: AppColor.white,
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(color: logic.isExpiredFrame != -1 ? AppColor.primary : AppColor.black, width: 1.2)),
                                  child: Row(
                                    children: [
                                      Container(
                                          width: 75,
                                          height: 75,
                                          decoration: BoxDecoration(
                                            color: AppColor.lightGray,
                                            borderRadius: BorderRadius.circular(10),
                                          ),
                                          child: CustomSVGAFrameWidget(
                                            type: logic.fetchPurchasedFrameModel?.data?.avatarFrames?.expired?[index].type ?? 1,
                                            itemType: ApiParams.frame,
                                            imagePath: logic.fetchPurchasedFrameModel?.data?.avatarFrames?.expired?[index].image ?? "",
                                            framePath: logic.fetchPurchasedFrameModel?.data?.avatarFrames?.expired?[index].svgaImage,
                                            svgapadding: EdgeInsets.all(0),
                                            borderRadius: BorderRadius.circular(10),
                                          )),
                                      const SizedBox(width: 10),
                                      Column(
                                        children: [
                                          SizedBox(
                                            width: Get.width * 0.6,
                                            child: Wrap(crossAxisAlignment: WrapCrossAlignment.center, children: [
                                              Text(logic.fetchPurchasedFrameModel?.data?.avatarFrames?.expired?[index].name ?? "",
                                                  style: AppFontStyle.styleW600(AppColor.black, 14)),
                                              const SizedBox(width: 5),
                                              (logic.fetchPurchasedFrameModel?.data?.avatarFrames?.expired?[index].isSelected ?? false)
                                                  ? Container(
                                                      padding: EdgeInsets.symmetric(horizontal: 5, vertical: 3),
                                                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(15), gradient: AppColor.inUseGradient),
                                                      child: Text(EnumLocal.txtInUse.name.tr, style: AppFontStyle.styleW400(AppColor.white, 10)))
                                                  : Container(
                                                      padding: EdgeInsets.symmetric(horizontal: 5, vertical: 3),
                                                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(15), color: AppColor.lightGray),
                                                      child: Text(EnumLocal.txtNotActivatedYet.name.tr, style: AppFontStyle.styleW400(AppColor.colorLightBlue, 10)))
                                            ]),
                                          ),
                                          2.height,
                                          SizedBox(
                                            width: Get.width * 0.6,
                                            child: Text(
                                              "${EnumLocal.txtExpiredAt.name.tr} : ${logic.formatDateTime(logic.fetchPurchasedFrameModel?.data?.avatarFrames?.expired?[index].expiryDate ?? DateTime.now())}",
                                              style: AppFontStyle.styleW500(
                                                AppColor.purpleGray,
                                                11,
                                              ),
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                  ],
                ),
              )),
          bottomNavigationBar: GetBuilder<BackpackController>(
            builder: (logic) => Container(
              height: 70,
              width: Get.width,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: AppColor.white,
                borderRadius: BorderRadius.circular(0),
                boxShadow: [],
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    logic.isActiveFrame == -1
                        ? SizedBox()
                        : GetBuilder<ThemeOutfitController>(
                            builder: (controller) => logic.isActiveFrame != -1 && (logic.isSelectedFrame != logic.isActiveFrame)
                                ? GestureDetector(
                                    onTap: () {
                                      if (logic.isActiveFrame != -1) {
                                        logic.isSelectedFrame = logic.isActiveFrame;
                                        logic.update([ApiParams.backpack]);
                                      } else {
                                        Utils.showToast(text: "Not Selected item");
                                      }
                                    },
                                    child: logic.isActiveFrame == -1
                                        ? SizedBox()
                                        : Container(
                                            height: 50,
                                            width: (Get.width - 24),
                                            decoration: BoxDecoration(
                                              color: AppColor.lightGrayBg,
                                              borderRadius: BorderRadius.circular(15),
                                            ),
                                            child: Center(
                                              child: Text(
                                                EnumLocal.txtActivateAndWear.name.tr,
                                                style: AppFontStyle.styleW600(AppColor.black, 16),
                                              ),
                                            ),
                                          ),
                                  )
                                : GestureDetector(
                                    onTap: () {
                                      if (logic.isActiveFrame != -1) {
                                        logic.isSelectedFrame = -1;
                                        logic.update([ApiParams.backpack]);
                                        // SelectThemeApi.callApi(
                                        //   uid: logic.uid,
                                        //   token: logic.token,
                                        //   itemId: logic.fetchPurchasedFrameModel!.data!.avatarFrames!.active![logic.isActiveFrame].itemId!,
                                        //   itemType: 2,
                                        //   action: ApiParams.takeoff,
                                        // ).then((value) async {
                                        //   await logic.init();
                                        //   logic.isSelectedFrame = -1;
                                        //   logic.update([ApiParams.backpack]);
                                        // });
                                      } else {
                                        Utils.showToast(text: "Not Selected item");
                                      }
                                    },
                                    child: logic.isActiveFrame == -1
                                        ? SizedBox()
                                        : Container(
                                            height: 50,
                                            width: (Get.width - 24),
                                            decoration: BoxDecoration(
                                              color: AppColor.lightGrayBg,
                                              borderRadius: BorderRadius.circular(15),
                                            ),
                                            child: Center(
                                              child: Text(
                                                EnumLocal.txtTakeOff.name.tr,
                                                style: AppFontStyle.styleW600(AppColor.black, 16),
                                              ),
                                            ),
                                          ),
                                  ),
                          ),
                    GetBuilder<ThemeOutfitController>(
                      builder: (controller) => InkWell(
                        onTap: () {
                          if (logic.isExpiredFrame != -1) {
                            PurchaseThemeApi.callApi(
                              userId: logic.uid,
                              token: logic.token,
                              directWear: true,
                              itemId: logic.fetchPurchasedFrameModel!.data!.avatarFrames!.expired![logic.isExpiredFrame].itemId!,
                              itemType: ApiParams.frame,
                            ).then(
                              (value) {
                                logic.isExpiredFrame = -1;
                                logic.update([ApiParams.backpack]);
                              },
                            );
                          } else {
                            Utils.showToast(text: "Not Selected item");
                          }
                        },
                        child: logic.isExpiredFrame == -1
                            ? SizedBox()
                            : Container(
                                height: 50,
                                width: (Get.width - 24),
                                decoration: BoxDecoration(
                                  color: AppColor.primary,
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: Center(
                                  child: Text(
                                    EnumLocal.txtRenew.name.tr,
                                    style: AppFontStyle.styleW600(AppColor.white, 16),
                                  ),
                                ),
                              ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
