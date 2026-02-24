import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:tingle/common/model/fetch_emoji_model.dart';
import 'package:tingle/common/widget/loading_widget.dart';
import 'package:tingle/common/widget/no_data_found_widget.dart';
import 'package:tingle/common/widget/preview_network_image_widget.dart';
import 'package:tingle/custom/widget/custom_radio_button_widget.dart';

import 'package:tingle/page/audio_room_page/controller/audio_room_controller.dart';
import 'package:tingle/utils/assets.dart';
import 'package:tingle/utils/color.dart';
import 'package:tingle/utils/constant.dart';
import 'package:tingle/utils/enums.dart';
import 'package:tingle/utils/font_style.dart';
import 'package:tingle/utils/utils.dart';

class AudioRoomChangeBgBottomSheetWidget {
  static ScrollController scrollController = ScrollController();
  static final controller = Get.find<AudioRoomController>();

  static List<EmojiData> themes = [];
  static RxBool isLoading = false.obs;
  static RxBool isPagination = false.obs;
  static FetchEmojiModel? fetchEmojiModel;

  static void init() async {
    themes.clear();
    isLoading.value = true;
    scrollController.addListener(onPagination);
    await onGetEmoji();
  }

  static Future<void> onPagination() async {
    isPagination.value = true;
    await onGetEmoji();
    isPagination.value = false;
  }

  static Future<void> onGetEmoji() async {
    isLoading.value = false;
  }

  static Future<void> onShow() async {
    init();
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
                        style: AppFontStyle.styleW700(AppColor.greyBlue, 18),
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
              child: Obx(
                () => isLoading.value
                    ? LoadingWidget()
                    : themes.isEmpty
                        ? NoDataFoundWidget()
                        : SingleChildScrollView(
                            child: GridView.builder(
                              itemCount: themes.length,
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
                                final indexData = themes[index];
                                return GetBuilder<AudioRoomController>(
                                  id: AppConstant.onChangeTheme,
                                  builder: (controller) => GestureDetector(
                                    onTap: () => controller.onChangeTheme(bgTheme: indexData.image ?? ""),
                                    child: Container(
                                      clipBehavior: Clip.antiAlias,
                                      decoration: BoxDecoration(
                                        color: AppColor.black,
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                      child: Stack(
                                        fit: StackFit.expand,
                                        children: [
                                          PreviewPostImageWidget(
                                            image: indexData.image,
                                            fit: BoxFit.cover,
                                          ),
                                          Positioned(
                                            top: 5,
                                            right: 5,
                                            child: CustomRadioButtonWidget(
                                              isSelected: controller.audioRoomModel?.bgTheme == indexData.image,
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
            ),
            GestureDetector(
              onTap: () {
                Get.back();
              },
              child: Container(
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
                    EnumLocal.txtChangesSave.name.tr,
                    style: AppFontStyle.styleW700(AppColor.white, 17),
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
