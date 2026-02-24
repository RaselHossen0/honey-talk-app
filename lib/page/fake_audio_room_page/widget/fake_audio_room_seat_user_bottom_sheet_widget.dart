import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tingle/common/function/country_flag_icon.dart';
import 'package:tingle/common/widget/preview_network_image_widget.dart';
import 'package:tingle/firebase/authentication/firebase_access_token.dart';
import 'package:tingle/firebase/authentication/firebase_uid.dart';
import 'package:tingle/page/audio_room_page/shimmer/audio_room_seat_user_bottom_sheet_shimmer_ui.dart';
import 'package:tingle/page/fake_audio_room_page/controller/fake_audio_room_controller.dart';
import 'package:tingle/page/profile_page/api/fetch_other_user_profile_api.dart';
import 'package:tingle/page/profile_page/model/fetch_user_profile_model.dart';
import 'package:tingle/utils/api_params.dart';
import 'package:tingle/utils/assets.dart';
import 'package:tingle/utils/color.dart';
import 'package:tingle/utils/enums.dart';
import 'package:tingle/utils/font_style.dart';
import 'package:tingle/utils/utils.dart';

class FakeAudioRoomSeatUserBottomSheetWidget {
  static FetchUserProfileModel? fetchProfileModel;
  static RxBool isLoadingProfile = false.obs;

  static RxBool isMute = false.obs;

  static Future<void> onGetProfile(String userId) async {
    isLoadingProfile.value = true;

    final uid = FirebaseUid.onGet() ?? "";
    final token = await FirebaseAccessToken.onGet() ?? "";

    fetchProfileModel = await FetchOtherUserProfileApi.callApi(uid: uid, token: token, toUserId: userId);

    if (fetchProfileModel?.user?.name != null) {
      isLoadingProfile.value = false;
    }
  }

  static void onShow({required int position}) {
    final controller = Get.find<FakeAudioRoomController>();

    isMute.value = controller.fakeAudioRoomModel?.audioRoomSeats[position].mute == 3 ? true : false;

    onGetProfile(controller.fakeAudioRoomModel?.audioRoomSeats[position].userId ?? "");

    showModalBottomSheet(
      isScrollControlled: true,
      context: Get.context!,
      backgroundColor: AppColor.transparent,
      builder: (context) => Container(
        height: 405,
        width: Get.width,
        clipBehavior: Clip.antiAlias,
        decoration: const BoxDecoration(
          color: AppColor.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(40),
            topRight: Radius.circular(40),
          ),
        ),
        child: Column(
          children: [
            Container(
              height: 65,
              color: AppColor.secondary.withValues(alpha: 0.08),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  50.width,
                  const Spacer(),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: 4,
                        width: 35,
                        decoration: BoxDecoration(
                          color: AppColor.grayText.withValues(alpha: 0.5),
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      10.height,
                      Text(
                        EnumLocal.txtViewProfile.name.tr,
                        style: AppFontStyle.styleW700(AppColor.black, 17),
                      ),
                    ],
                  ),
                  const Spacer(),
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
                () => isLoadingProfile.value
                    ? AudioRoomSeatUserBottomSheetShimmerUi()
                    : SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
                          child: Column(
                            children: [
                              Container(
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  gradient: AppColor.primaryGradient,
                                ),
                                child: Container(
                                    height: 110,
                                    width: 110,
                                    margin: const EdgeInsets.all(2),
                                    clipBehavior: Clip.antiAlias,
                                    decoration: BoxDecoration(shape: BoxShape.circle, color: AppColor.white),
                                    child: PreviewProfileImageWidget(image: fetchProfileModel?.user?.image)),
                              ),
                              10.height,
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    fetchProfileModel?.user?.name ?? "",
                                    style: AppFontStyle.styleW700(AppColor.black, 18),
                                  ),
                                  Visibility(
                                    visible: fetchProfileModel?.user?.isVerified ?? false,
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 3),
                                      child: Image.asset(AppAssets.icAuthoriseIcon, width: 20),
                                    ),
                                  ),
                                ],
                              ),
                              Text(
                                fetchProfileModel?.user?.userName ?? "",
                                style: AppFontStyle.styleW400(AppColor.grayText, 13),
                              ),
                              10.height,
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    width: 22,
                                    child: Text(
                                      CountryFlagIcon.onShow(fetchProfileModel?.user?.countryFlagImage ?? ""),
                                      style: AppFontStyle.styleW700(AppColor.primary, 20),
                                    ),
                                  ),
                                  10.width,
                                  Container(
                                    padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 12),
                                    decoration: BoxDecoration(
                                      color: AppColor.secondary.withValues(alpha: 0.8),
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Image.asset(
                                          fetchProfileModel?.user?.gender?.toLowerCase().trim() == ApiParams.male ? AppAssets.icMale : AppAssets.icFemale,
                                          width: 14,
                                          color: AppColor.white,
                                        ),
                                        5.width,
                                        Text(
                                          fetchProfileModel?.user?.gender?.toLowerCase().trim() == ApiParams.male ? EnumLocal.txtMale.name.tr : EnumLocal.txtFemale.name.tr,
                                          style: AppFontStyle.styleW600(AppColor.white, 12),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              20.height,
                              Row(
                                children: [
                                  Expanded(
                                    child: Obx(
                                      () => Column(
                                        children: [
                                          GestureDetector(
                                            onTap: () {
                                              if (isMute.value) {
                                                isMute.value = false;
                                                controller.onSeatMutedSocket(
                                                    position: position, mute: 1, userId: controller.fakeAudioRoomModel?.audioRoomSeats[position].userId ?? "");
                                              } else {
                                                isMute.value = true;
                                                controller.onSeatMutedSocket(
                                                    position: position, mute: 3, userId: controller.fakeAudioRoomModel?.audioRoomSeats[position].userId ?? "");
                                              }
                                            },
                                            child: Container(
                                              height: 56,
                                              width: 56,
                                              alignment: Alignment.center,
                                              decoration: BoxDecoration(
                                                gradient: AppColor.primaryGradient,
                                                shape: BoxShape.circle,
                                              ),
                                              child: Image.asset(isMute.value ? AppAssets.icMicOn : AppAssets.icMicOff, color: AppColor.white, width: 25),
                                            ),
                                          ),
                                          5.height,
                                          Text(
                                            isMute.value ? EnumLocal.txtUnmuteMic.name.tr : EnumLocal.txtMuteMic.name.tr,
                                            style: AppFontStyle.styleW700(AppColor.black, 13),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Column(
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            Get.back();
                                            controller.onParticipantRemoveSocket(position: position, userId: controller.fakeAudioRoomModel?.audioRoomSeats[position].userId ?? "");
                                          },
                                          child: Container(
                                            height: 56,
                                            width: 56,
                                            alignment: Alignment.center,
                                            decoration: BoxDecoration(
                                              gradient: AppColor.primaryGradient,
                                              shape: BoxShape.circle,
                                            ),
                                            child: Image.asset(AppAssets.icRemoveSeatIcon, color: AppColor.white, width: 30),
                                          ),
                                        ),
                                        5.height,
                                        Text(
                                          EnumLocal.txtRemoveMic.name.tr,
                                          style: AppFontStyle.styleW700(AppColor.black, 13),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    child: Column(
                                      children: [
                                        GestureDetector(
                                          onTap: () async {
                                            Get.back();
                                            controller.onAddToBlockedListSocket(userId: controller.fakeAudioRoomModel?.audioRoomSeats[position].userId ?? "");
                                            await 1.seconds.delay();

                                            controller.onParticipantRemoveSocket(position: position, userId: controller.fakeAudioRoomModel?.audioRoomSeats[position].userId ?? "");
                                          },
                                          child: Container(
                                            height: 56,
                                            width: 56,
                                            alignment: Alignment.center,
                                            padding: EdgeInsets.only(left: 5),
                                            decoration: BoxDecoration(
                                              gradient: AppColor.primaryGradient,
                                              shape: BoxShape.circle,
                                            ),
                                            child: Image.asset(AppAssets.icLogOut, color: AppColor.white, width: 28),
                                          ),
                                        ),
                                        5.height,
                                        Text(
                                          EnumLocal.txtKickOut.name.tr,
                                          style: AppFontStyle.styleW700(AppColor.black, 13),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
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
