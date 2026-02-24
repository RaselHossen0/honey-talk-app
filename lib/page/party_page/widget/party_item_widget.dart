import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tingle/common/widget/preview_network_image_widget.dart';
import 'package:tingle/custom/function/custom_format_number.dart';
import 'package:tingle/custom/function/custom_random_light_color.dart';
import 'package:tingle/page/stream_page/model/fetch_live_user_model.dart';
import 'package:tingle/utils/assets.dart';
import 'package:tingle/utils/color.dart';
import 'package:tingle/utils/font_style.dart';
import 'package:tingle/utils/utils.dart';

class PartyItemWidget extends StatelessWidget {
  const PartyItemWidget({super.key, required this.liveUser});

  final LiveUserList liveUser;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      width: Get.width,
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        border: Border.all(color: AppColor.white),
        color: CustomRandomLightColor.onGet(),
        borderRadius: BorderRadius.circular(23),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            height: 100,
            width: 100,
            child: Container(
              height: 100,
              width: 100,
              margin: const EdgeInsets.all(8),
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(
                color: AppColor.transparent,
                borderRadius: BorderRadius.circular(15),
              ),
              child: PreviewPostImageWidget(
                image: liveUser.roomImage,
                fit: BoxFit.cover,
                size: 50,
              ),
            ),
          ),
          5.width,
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Flexible(
                  fit: FlexFit.loose,
                  child: Text(
                    liveUser.name ?? "",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: AppFontStyle.styleW700(AppColor.black, 14),
                  ),
                ),
                5.height,
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                  decoration: BoxDecoration(
                    color: AppColor.primary.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Text(
                    liveUser.roomName ?? "",
                    style: AppFontStyle.styleW600(AppColor.primary, 10),
                  ),
                ),
                8.height,
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: 26,
                        color: AppColor.transparent,
                        child: Stack(
                          children: [
                            for (int i = 0; i < 4; i++)
                              Positioned(
                                left: i == 0 ? 0 : i * 20,
                                child: Container(
                                  height: 26,
                                  width: 26,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: AppColor.transparent,
                                    border: Border.all(color: AppColor.white),
                                  ),
                                  child: Container(
                                    height: 26,
                                    width: 26,
                                    clipBehavior: Clip.antiAlias,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: AppColor.white.withValues(alpha: 0.1),
                                    ),
                                    child: (liveUser.viewers?.length ?? 0) > i
                                        ? PreviewProfileImageWidget(
                                            image: liveUser.viewers?[i].image,
                                            isBanned: liveUser.viewers?[i].isProfilePicBanned,
                                          )
                                        : Center(child: Image.asset(AppAssets.icSeat, width: 12, color: AppColor.white)),
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),
                    ),
                    5.width,
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                      decoration: BoxDecoration(
                        color: AppColor.black.withValues(alpha: 0.15),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Row(
                        children: [
                          Image.asset(
                            AppAssets.icLiveWave,
                            width: 12,
                            color: AppColor.white,
                          ),
                          5.width,
                          Text(
                            CustomFormatNumber.onConvert(liveUser.view ?? 0),
                            style: AppFontStyle.styleW600(AppColor.white, 10),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          15.width,
        ],
      ),
    );
  }
}
