import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tingle/common/widget/new_preview_frame.dart';
import 'package:tingle/custom/widget/custom_coinday_txt_widget.dart';
import 'package:tingle/custom/widget/custom_light_background_widget.dart';
import 'package:tingle/page/store_page/controller/store_controller.dart';
import 'package:tingle/page/theme_page/controller/theme_controller.dart';
import 'package:tingle/page/theme_page/widget/theme_appbar_widget.dart';
import 'package:tingle/utils/api_params.dart';
import 'package:tingle/utils/assets.dart';
import 'package:tingle/utils/color.dart';
import 'package:tingle/utils/constant.dart';
import 'package:tingle/utils/database.dart';
import 'package:tingle/utils/enums.dart';
import 'package:tingle/utils/font_style.dart';
import 'package:tingle/utils/utils.dart';

//ignore: must_be_immutable
class AvtarThemeView extends GetView<ThemeController> {
  AvtarThemeView({super.key});
  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    final storeController = Get.find<StoreController>();

    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: const Color(0xFFF3EDFF),
      body: GetBuilder<ThemeController>(
        id: AppConstant.onSelectTheme,
        builder: (controller) => Stack(
          children: [
            CustomLightBackgroundWidget(),
            SizedBox(
              height: Get.height,
              width: Get.width,
              child: Column(
                children: [
                  ThemeAppBarWidget(
                    title: EnumLocal.txtAvtarTheme.name.tr,
                  ),
                  SizedBox(height: size.height * 0.02),
                  Center(
                    child: SizedBox(
                      height: 120,
                      width: 120,
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Container(
                            height: 100,
                            width: 100,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                    image: NetworkImage(
                                  "https://randomuser.me/api/portraits/men/32.jpg",
                                ))),
                          ),
                          Container(
                            height: 120,
                            width: 120,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                            ),
                            child: Image.asset(storeController.allStoreItemModel?.data?.avatarFrames?[selectedIndex].image ?? ""),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                  Container(
                    color: AppColor.white,
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              EnumLocal.txtAvtarTheme.name.tr,
                              style: AppFontStyle.styleW700(AppColor.black, 16),
                            ),
                          ),
                        ),
                        10.height
                      ],
                    ),
                  ),
                  Expanded(
                    child: Container(
                      color: AppColor.white,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: GridView.builder(
                          itemCount: storeController.allStoreItemModel!.data!.avatarFrames!.length,
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            mainAxisSpacing: 10,
                            crossAxisSpacing: 5,
                            childAspectRatio: 0.7,
                          ),
                          padding: EdgeInsets.zero,
                          itemBuilder: (context, index) {
                            // final car = cars[index];
                            return GestureDetector(
                              onTap: () {
                                selectedIndex = index;
                                controller.update([AppConstant.onSelectTheme]);
                              },
                              child: LayoutBuilder(
                                builder: (context, constraints) {
                                  final itemWidth = constraints.maxWidth;
                                  final itemHeight = constraints.maxHeight;

                                  return Container(
                                    height: itemHeight,
                                    width: itemWidth,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(16),
                                      boxShadow: [
                                        BoxShadow(
                                          color: AppColor.extraLightGray,
                                          blurRadius: 10,
                                          offset: const Offset(0, 5),
                                        ),
                                      ],
                                    ),
                                    padding: const EdgeInsets.symmetric(vertical: 8),
                                    child: Column(
                                      children: [
                                        Container(
                                            height: itemHeight * 0.55,
                                            width: itemWidth * 0.8,
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(10),
                                              color: AppColor.lightPurple,
                                              border: Border.all(
                                                color: selectedIndex == index ? AppColor.primary : AppColor.transparent,
                                                width: 2,
                                              ),
                                            ),
                                            child: Padding(
                                                padding: const EdgeInsets.all(5.0), child: Image.asset(storeController.allStoreItemModel?.data?.avatarFrames?[index].image ?? ""))),
                                        const SizedBox(height: 8),
                                        Flexible(
                                          child: Text(
                                            storeController.allStoreItemModel!.data!.avatarFrames![index].name!,
                                            style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 12,
                                            ),
                                            textAlign: TextAlign.center,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                        const SizedBox(height: 4),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Image.asset(
                                              AppAssets.icCoinStar,
                                              height: 16,
                                              width: 16,
                                            ),
                                            const SizedBox(width: 4),

                                            CoinValidityText(
                                              coin: storeController.allStoreItemModel?.data?.avatarFrames?[index].coin.toString() ?? "",
                                              validity: storeController.allStoreItemModel?.data?.avatarFrames?[index].validity.toString(),
                                              validityType: storeController.allStoreItemModel?.data?.avatarFrames?[index].validityType,
                                              sortLabel: true,
                                              style: AppFontStyle.styleW600(AppColor.grayText, 12),
                                            ),
                                            // Text("12,000/15d", style: TextStyle(fontSize: 11)
                                          ],
                                        )
                                      ],
                                    ),
                                  );
                                },
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: GetBuilder<ThemeController>(
        id: AppConstant.onSelectTheme,
        builder: (controller) => Container(
          height: 70,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            color: AppColor.white,
            boxShadow: [
              BoxShadow(
                color: AppColor.extraLightGray,
                blurRadius: 10,
                offset: const Offset(0, -2),
              )
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  Expanded(
                    child: Text(
                      storeController.allStoreItemModel?.data?.avatarFrames?[selectedIndex].name ?? "",
                      overflow: TextOverflow.ellipsis,
                      style: AppFontStyle.styleW600(
                        AppColor.black,
                        14,
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      Image.asset(
                        AppAssets.icCoinStar,
                        height: 18,
                        width: 18,
                      ),
                      5.width,
                      CoinValidityText(
                        coin: storeController.allStoreItemModel?.data?.avatarFrames?[selectedIndex].coin.toString(),
                        validity: storeController.allStoreItemModel?.data?.avatarFrames?[selectedIndex].validity.toString(),
                        validityType: storeController.allStoreItemModel?.data?.avatarFrames?[selectedIndex].validityType,
                        sortLabel: true,
                        style: AppFontStyle.styleW600(AppColor.lightGrey, 14),
                      ),
                    ],
                  )
                ],
              ),
              const SizedBox(width: 16),
              ElevatedButton(
                onPressed: () {
                  PreviewSVGADaiLog.show(
                      isfake: true,
                      userId: Database.loginUserId,
                      context: context,
                      frameData: storeController.allStoreItemModel?.data?.avatarFrames?[selectedIndex],
                      itemType: ApiParams.frames);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColor.primary,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                ),
                child: Text(
                  EnumLocal.txtPurchase.name.tr,
                  style: AppFontStyle.styleW600(AppColor.white, 16),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
