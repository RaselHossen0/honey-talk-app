import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tingle/common/api/fetch_emoji_api.dart';
import 'package:tingle/common/model/fetch_emoji_model.dart';
import 'package:tingle/common/widget/loading_widget.dart';
import 'package:tingle/common/widget/no_data_found_widget.dart';
import 'package:tingle/common/widget/preview_network_image_widget.dart';
import 'package:tingle/database/fake_data/user_fake_data.dart';
import 'package:tingle/firebase/authentication/firebase_access_token.dart';
import 'package:tingle/firebase/authentication/firebase_uid.dart';
import 'package:tingle/page/audio_room_page/controller/audio_room_controller.dart';
import 'package:tingle/utils/assets.dart';
import 'package:tingle/utils/color.dart';

import 'package:tingle/utils/utils.dart';

class EmojiBottomSheetWidget {
  static final controller = Get.find<AudioRoomController>();

  static List<EmojiData> reactions = [];
  static RxBool isLoading = false.obs;
  static FetchEmojiModel? fetchEmojiModel;

  static Future<void> onGetEmoji() async {
    isLoading.value = true;

    final uid = FirebaseUid.onGet() ?? "";
    final token = await FirebaseAccessToken.onGet() ?? "";

    fetchEmojiModel = await FetchEmojiApi.callApi(uid: uid, token: token);

    reactions = fetchEmojiModel?.data ?? [];

    isLoading.value = false;
  }

  static Future<void> onShow() async {
    await showModalBottomSheet(
      isScrollControlled: true,
      context: Get.context!,
      backgroundColor: AppColor.transparent,
      builder: (context) => Container(
        height: 350,
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
                  // Expanded(
                  //   child: Center(
                  //     child: Text(
                  //       EnumLocal.txtReaction.name.tr,
                  //       style: AppFontStyle.styleW700(AppColor.greyBlue, 18),
                  //     ),
                  //   ),
                  // ),
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
                    : reactions.isEmpty
                        ? NoDataFoundWidget()
                        : SingleChildScrollView(
                            child: GridView.builder(
                              itemCount: reactions.length,
                              shrinkWrap: true,
                              padding: EdgeInsets.all(15),
                              physics: NeverScrollableScrollPhysics(),
                              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 4,
                                mainAxisSpacing: 10,
                                crossAxisSpacing: 10,
                              ),
                              itemBuilder: (context, index) {
                                final indexData = reactions[index];
                                return GestureDetector(
                                  onTap: () {
                                    controller.onSendEmojiSocket(
                                      position: controller.audioRoomModel?.selectedSeat,
                                      image: indexData.image ?? "",
                                    );
                                    Get.back();
                                  },
                                  child: Container(
                                    clipBehavior: Clip.antiAlias,
                                    padding: EdgeInsets.all(15),
                                    decoration: BoxDecoration(
                                      color: AppColor.secondary.withValues(alpha: 0.1),
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    child: PreviewPostImageWidget(
                                      image: FakeProfilesSet().fakeEmoji[Random().nextInt(3)],
                                    ),
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
    );
  }
}
