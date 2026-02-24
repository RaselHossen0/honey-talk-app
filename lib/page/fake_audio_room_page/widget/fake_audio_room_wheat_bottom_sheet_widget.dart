import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';
import 'package:tingle/page/fake_audio_room_page/controller/fake_audio_room_controller.dart';
import 'package:tingle/utils/assets.dart';
import 'package:tingle/utils/color.dart';
import 'package:tingle/utils/font_style.dart';
import 'package:tingle/utils/utils.dart';

class FakeAudioRoomWheatBottomSheetWidget {
  static Future<void> onShow() async {
    final controller = Get.find<FakeAudioRoomController>();
    await showModalBottomSheet(
      isScrollControlled: true,
      context: Get.context!,
      backgroundColor: AppColor.white,
      builder: (context) => Container(
        height: Get.height / 1.5,
        width: Get.width,
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          color: AppColor.secondary.withValues(alpha: 0.15),
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
              color: AppColor.white,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  50.width,
                  Expanded(
                    child: Center(
                      child: Text(
                        "Wheat Mode",
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
                child: Column(
                  children: [
                    10.height,
                    _ItemWidget(
                      count: 8,
                      callback: () {
                        controller.onSeatCountModifiedSocket(seatCount: 8);
                        Get.back();
                      },
                    ),
                    10.height,
                    _ItemWidget(
                      count: 12,
                      callback: () {
                        controller.onSeatCountModifiedSocket(seatCount: 12);
                        Get.back();
                      },
                    ),
                    10.height,
                    _ItemWidget(
                      count: 15,
                      callback: () {
                        controller.onSeatCountModifiedSocket(seatCount: 15);
                        Get.back();
                      },
                    ),
                    10.height,
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ItemWidget extends StatelessWidget {
  const _ItemWidget({required this.count, required this.callback});

  final int count;
  final Callback callback;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        gradient: AppColor.audioRoomGradient,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          GridView.builder(
            itemCount: count,
            shrinkWrap: true,
            padding: EdgeInsets.all(15),
            physics: NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: count == 15 ? 5 : 4,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
            ),
            itemBuilder: (context, index) {
              return Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: AppColor.white.withValues(alpha: 0.1),
                ),
                child: Image.asset(AppAssets.icSeat, width: 25),
              );
            },
          ),
          GestureDetector(
            onTap: callback,
            child: Container(
              height: 50,
              width: Get.width,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: AppColor.white.withValues(alpha: 0.2),
              ),
              child: Text(
                "Join Room In $count Seating",
                style: AppFontStyle.styleW600(AppColor.white, 16),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
