import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tingle/custom/widget/custom_radio_button_widget.dart';
import 'package:tingle/utils/assets.dart';
import 'package:tingle/utils/color.dart';
import 'package:tingle/utils/font_style.dart';
import 'package:tingle/utils/utils.dart';

class FakeAudioRoomChangeBgBottomSheetWidget {
  static RxInt selectedIndex = 0.obs;
  static Future<void> onShow() async {
    await showModalBottomSheet(
      isScrollControlled: true,
      context: Get.context!,
      backgroundColor: AppColor.transparent,
      builder: (context) => Container(
        height: Get.height / 1.5,
        width: Get.width,
        decoration: BoxDecoration(
          color: AppColor.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(40),
            topRight: Radius.circular(40),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              height: 65,
              color: AppColor.secondary.withValues(alpha: 0.08),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  50.width,
                  Expanded(
                    child: Center(
                      child: Text(
                        "Background",
                        style: AppFontStyle.styleW700(AppColor.black, 18),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () => Get.back(),
                    child: Container(
                      height: 30,
                      width: 30,
                      margin: const EdgeInsets.only(right: 20),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColor.secondary.withValues(alpha: 0.6),
                      ),
                      child: Image.asset(width: 18, AppAssets.icClose, color: AppColor.white),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: GridView.builder(
                  itemCount: 6,
                  shrinkWrap: true,
                  padding: EdgeInsets.all(15),
                  physics: NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
                    mainAxisExtent: 150,
                  ),
                  itemBuilder: (context, index) {
                    return Obx(
                      () => GestureDetector(
                        onTap: () => selectedIndex.value = index,
                        child: Container(
                          clipBehavior: Clip.antiAlias,
                          decoration: BoxDecoration(
                            color: AppColor.black,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Stack(
                            fit: StackFit.expand,
                            children: [
                              Image.network(
                                "https://img.freepik.com/free-photo/leaf-with-water-drops-it_1340-42425.jpg?semt=ais_incoming",
                                fit: BoxFit.cover,
                              ),
                              Positioned(
                                top: 5,
                                right: 5,
                                child: CustomRadioButtonWidget(
                                  isSelected: selectedIndex.value == index,
                                  size: 20,
                                  borderColor: AppColor.white,
                                  activeColor: AppColor.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
            Container(
              width: Get.width,
              color: AppColor.white,
              alignment: Alignment.center,
              child: Container(
                height: 55,
                width: Get.width,
                alignment: Alignment.center,
                margin: EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: AppColor.primary,
                  borderRadius: BorderRadius.circular(100),
                ),
                child: Text(
                  "Changes Save",
                  style: AppFontStyle.styleW700(AppColor.white, 17),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
