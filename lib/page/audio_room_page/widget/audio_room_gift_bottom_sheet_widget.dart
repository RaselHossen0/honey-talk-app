import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';
import 'package:tingle/common/api/fetch_category_wise_gift_api.dart';
import 'package:tingle/common/api/fetch_gift_category_api.dart';
import 'package:tingle/common/function/fetch_user_coin.dart';
import 'package:tingle/common/model/fetch_category_wise_gift_model.dart';
import 'package:tingle/common/widget/loading_widget.dart';
import 'package:tingle/common/widget/no_data_found_widget.dart';
import 'package:tingle/common/widget/preview_network_image_widget.dart';
import 'package:tingle/custom/function/custom_format_number.dart';
import 'package:tingle/firebase/authentication/firebase_access_token.dart';
import 'package:tingle/firebase/authentication/firebase_uid.dart';
import 'package:tingle/page/audio_room_page/controller/audio_room_controller.dart';
import 'package:tingle/utils/assets.dart';
import 'package:tingle/utils/color.dart';
import 'package:tingle/utils/constant.dart';
import 'package:tingle/utils/enums.dart';
import 'package:tingle/utils/font_style.dart';
import 'package:tingle/utils/utils.dart';

class AudioRoomGiftBottomSheetWidget {
  static final controller = Get.find<AudioRoomController>();

  static RxBool isSelectedAll = false.obs;
  static RxList selectedUserId = [].obs;

  static RxString selectedCategoryId = "".obs;
  static RxInt selectedGiftIndex = 0.obs;

  static RxBool isLoading = false.obs;
  static FetchCategoryWiseGiftModel? fetchCategoryWiseGiftModel;

  static RxInt selectedSendGiftCount = 1.obs;
  static List<int> giftCounts = [1, 5, 10, 20];
  static void onChangeGiftCount(int count) => selectedSendGiftCount.value = count;

  static void onChangeUser(String id) async {
    if (selectedUserId.contains(id)) {
      selectedUserId.remove(id);
    } else {
      selectedUserId.add(id);
    }
    if (selectedUserId.length != controller.audioRoomModel?.seatUsers.length) {
      isSelectedAll.value = false;
    }
  }

  static void onToggleSwitch() async {
    if (isSelectedAll.value) {
      isSelectedAll.value = false;
      selectedUserId.clear();
    } else {
      isSelectedAll.value = true;
      selectedUserId.value = controller.audioRoomModel?.seatUsers.map((user) => user.seat?.userId ?? "").where((id) => id.isNotEmpty).toList() ?? [];
    }
  }

  static void onChangeCategory(String category) async {
    if (FetchCategoryWiseGiftApi.categoryWiseGift.containsKey(category) == false) {
      await onFetchCategoryWiseGift(category);
    }
    selectedCategoryId.value = category;
  }

  static Future<void> onFetchCategoryWiseGift(String category) async {
    isLoading.value = true;

    final uid = FirebaseUid.onGet() ?? "";
    final token = await FirebaseAccessToken.onGet() ?? "";

    fetchCategoryWiseGiftModel = await FetchCategoryWiseGiftApi.callApi(token: token, uid: uid, giftCategoryId: category);

    isLoading.value = false;
  }

  static void onSendGift({CategoryWiseGift? gift}) async {
    if (selectedUserId.isNotEmpty) {
      final giftCoin = ((gift?.coin ?? 1) * selectedSendGiftCount.value * selectedUserId.length);
      Utils.showLog("Gift Coin => $giftCoin My Coin => ${FetchUserCoin.coin.value}");

      if (FetchUserCoin.coin.value > giftCoin) {
        Get.back();
      } else {
        Utils.showToast(text: EnumLocal.txtYouDonHaveSufficientCoinsToSendTheGift.name.tr);
      }
    } else {
      Utils.showToast(text: "Please select the user who sent the gift.");
    }
  }

  static void init() {
    if (FetchGiftCategoryApi.giftCategory.isNotEmpty) {
      onChangeCategory(FetchGiftCategoryApi.giftCategory[0].id ?? "");
    }

    FetchUserCoin.init();
  }

  static void onShow({required BuildContext context}) {
    FetchUserCoin.init();

    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      backgroundColor: AppColor.transparent,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadiusDirectional.only(
          topEnd: Radius.circular(25),
          topStart: Radius.circular(25),
        ),
      ),
      builder: (context) => Container(
        height: 450,
        width: Get.width,
        clipBehavior: Clip.antiAlias,
        decoration: const BoxDecoration(
          color: AppColor.black,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
        ),
        child: Column(
          children: [
            Container(
              height: 70,
              width: Get.width,
              padding: EdgeInsets.symmetric(horizontal: 15),
              decoration: const BoxDecoration(
                color: AppColor.darkGrey,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
              child: Stack(
                children: [
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        75.width,
                        GetBuilder<AudioRoomController>(
                          id: AppConstant.onSeatUserUpdate,
                          builder: (controller) => ListView.builder(
                            itemCount: controller.audioRoomModel?.seatUsers.length ?? 0,
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            physics: NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              final indexData = controller.audioRoomModel?.seatUsers[index];
                              return Obx(
                                () => GestureDetector(
                                  onTap: () => onChangeUser(indexData?.seat?.userId ?? ""),
                                  child: Container(
                                    height: 45,
                                    width: 45,
                                    margin: EdgeInsets.only(right: 20),
                                    decoration: BoxDecoration(
                                      color: AppColor.transparent,
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                        color: selectedUserId.contains(indexData?.seat?.userId ?? "") ? AppColor.primary : AppColor.white,
                                        width: 2,
                                      ),
                                    ),
                                    child: Container(
                                      height: 45,
                                      width: 45,
                                      alignment: Alignment.center,
                                      clipBehavior: Clip.antiAlias,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: AppColor.transparent,
                                      ),
                                      child: Stack(
                                        alignment: Alignment.center,
                                        children: [
                                          PreviewProfileImageWidget(
                                            image: indexData?.seat?.image,
                                            isBanned: indexData?.seat?.isProfilePicBanned,
                                          ),
                                          Positioned(
                                            bottom: 0,
                                            child: Container(
                                              height: 28,
                                              width: 28,
                                              alignment: Alignment.center,
                                              padding: EdgeInsets.only(bottom: 12),
                                              decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: selectedUserId.contains(indexData?.seat?.userId ?? "") ? AppColor.primary : AppColor.white,
                                              ),
                                              child: index == 0
                                                  ? Image.asset(
                                                      AppAssets.icSmallHomeIcon,
                                                      width: 8,
                                                      color: selectedUserId.contains(indexData?.seat?.userId ?? "") ? AppColor.white : AppColor.primary,
                                                    )
                                                  : Text(
                                                      "${index + 1}",
                                                      style: AppFontStyle.styleW600(
                                                        selectedUserId.contains(indexData?.seat?.userId ?? "") ? AppColor.white : AppColor.primary,
                                                        9,
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
                          ),
                        ),
                        70.width,
                      ],
                    ),
                  ),
                  Positioned(
                    left: 0,
                    child: Container(
                      height: 70,
                      width: 75,
                      alignment: Alignment.centerLeft,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.centerRight,
                          end: Alignment.centerLeft,
                          colors: [
                            AppColor.darkGrey.withValues(alpha: 0.1),
                            AppColor.darkGrey.withValues(alpha: 0.2),
                            AppColor.darkGrey.withValues(alpha: 0.4),
                            AppColor.darkGrey.withValues(alpha: 0.8),
                            for (int i = 0; i < 5; i++) AppColor.darkGrey,
                          ],
                        ),
                      ),
                      child: Text(
                        "Send :",
                        style: AppFontStyle.styleW600(AppColor.white, 14),
                      ),
                    ),
                  ),
                  Positioned(
                    right: 0,
                    child: Container(
                      height: 70,
                      width: 100,
                      alignment: Alignment.centerRight,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                          colors: [
                            AppColor.darkGrey.withValues(alpha: 0.1),
                            AppColor.darkGrey.withValues(alpha: 0.2),
                            AppColor.darkGrey.withValues(alpha: 0.4),
                            AppColor.darkGrey.withValues(alpha: 0.8),
                            for (int i = 0; i < 5; i++) AppColor.darkGrey,
                          ],
                        ),
                      ),
                      child: GestureDetector(
                        onTap: onToggleSwitch,
                        child: Obx(
                          () => Container(
                            height: 30,
                            width: 60,
                            padding: EdgeInsets.symmetric(horizontal: 4),
                            decoration: BoxDecoration(
                              color: isSelectedAll.value ? AppColor.primary : AppColor.white,
                              borderRadius: BorderRadius.circular(100),
                            ),
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                Row(
                                  children: [
                                    AnimatedContainer(
                                      duration: Duration(milliseconds: 300),
                                      curve: Curves.easeInOut,
                                      margin: EdgeInsets.only(left: isSelectedAll.value ? 30 : 0),
                                      height: 22,
                                      width: 22,
                                      decoration: BoxDecoration(
                                        color: isSelectedAll.value ? AppColor.white : AppColor.primary,
                                        borderRadius: BorderRadius.circular(100),
                                      ),
                                    ),
                                  ],
                                ),
                                Positioned(
                                  right: 8,
                                  child: Visibility(
                                    visible: isSelectedAll.value == false,
                                    child: Text(
                                      "All",
                                      style: AppFontStyle.styleW700(AppColor.secondary, 12),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 45,
              width: Get.width,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: FetchGiftCategoryApi.giftCategory.length,
                  itemBuilder: (context, index) {
                    final indexData = FetchGiftCategoryApi.giftCategory[index];

                    return Obx(
                      () => GiftTabItemWidget(
                        name: indexData.name ?? "",
                        isSelected: selectedCategoryId.value == indexData.id,
                        callback: () => onChangeCategory(indexData.id ?? ""),
                      ),
                    );
                  },
                ),
              ),
            ),
            Expanded(
              child: Obx(
                () => isLoading.value
                    ? LoadingWidget()
                    : FetchCategoryWiseGiftApi.categoryWiseGift[selectedCategoryId.value]?.isEmpty ?? true
                        ? NoDataFoundWidget()
                        : SingleChildScrollView(
                            child: GridView.builder(
                              shrinkWrap: true,
                              itemCount: FetchCategoryWiseGiftApi.categoryWiseGift[selectedCategoryId.value]?.length,
                              padding: EdgeInsets.all(12),
                              physics: NeverScrollableScrollPhysics(),
                              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 4,
                                crossAxisSpacing: 8,
                                mainAxisSpacing: 8,
                                mainAxisExtent: 100,
                              ),
                              itemBuilder: (context, index) {
                                final indexData = FetchCategoryWiseGiftApi.categoryWiseGift[selectedCategoryId.value]?[index];
                                return Obx(
                                  () => GiftItemWidget(
                                    gift: indexData,
                                    isSelected: selectedGiftIndex.value == index,
                                    callback: () => selectedGiftIndex.value = index,
                                  ),
                                );
                              },
                            ),
                          ),
              ),
            ),
            Container(
              height: 60,
              width: Get.width,
              padding: EdgeInsets.symmetric(horizontal: 12),
              decoration: const BoxDecoration(
                color: AppColor.transparent,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    height: 30,
                    padding: EdgeInsets.only(left: 5, right: 7),
                    decoration: BoxDecoration(
                      gradient: AppColor.coinPinkGradient,
                      borderRadius: BorderRadius.circular(100),
                      border: Border.all(color: AppColor.white.withValues(alpha: 0.5)),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(AppAssets.icCoinStar, width: 20),
                        5.width,
                        Obx(
                          () => Text(
                            CustomFormatNumber.onConvert(FetchUserCoin.coin.value),
                            style: AppFontStyle.styleW700(AppColor.white, 15),
                          ),
                        ),
                        8.width,
                        Image.asset(AppAssets.icArrowRight, color: AppColor.white, width: 6),
                      ],
                    ),
                  ),
                  Container(
                    height: 40,
                    width: Get.width / 1.5,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: AppColor.darkGrey,
                      borderRadius: BorderRadius.circular(100),
                    ),
                    child: Obx(
                      () => Row(
                        children: [
                          5.width,
                          for (int index = 0; index < giftCounts.length; index++)
                            GiftCountItemWidget(
                              count: giftCounts[index],
                              isSelected: selectedSendGiftCount.value == giftCounts[index],
                              callback: () => onChangeGiftCount(giftCounts[index]),
                            ),
                          10.width,
                          GestureDetector(
                            onTap: () {
                              onSendGift(gift: FetchCategoryWiseGiftApi.categoryWiseGift[selectedCategoryId.value]?[selectedGiftIndex.value]);
                            },
                            child: Container(
                              height: 45,
                              width: 70,
                              alignment: Alignment.center,
                              margin: EdgeInsets.symmetric(vertical: 5),
                              decoration: BoxDecoration(
                                color: AppColor.primary,
                                borderRadius: BorderRadius.circular(100),
                              ),
                              child: Text(
                                "Send",
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: AppFontStyle.styleW600(AppColor.white, 14),
                              ),
                            ),
                          ),
                          5.width,
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class GiftTabItemWidget extends StatelessWidget {
  const GiftTabItemWidget({super.key, required this.isSelected, required this.name, required this.callback});

  final bool isSelected;
  final String name;
  final Callback callback;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: callback,
      child: Container(
        height: 45,
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(horizontal: 15),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(color: isSelected ? AppColor.lightYellow : AppColor.white.withValues(alpha: 0.2)),
          ),
        ),
        child: Text(
          name,
          style: AppFontStyle.styleW600(isSelected ? AppColor.lightYellow : AppColor.secondary.withValues(alpha: 0.5), 14),
        ),
      ),
    );
  }
}

class GiftItemWidget extends StatelessWidget {
  const GiftItemWidget({super.key, this.gift, required this.callback, required this.isSelected});

  final CategoryWiseGift? gift;
  final Callback callback;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, box) {
        return GestureDetector(
          onTap: callback,
          child: Container(
            height: box.maxHeight,
            width: box.maxWidth,
            alignment: Alignment.center,
            padding: EdgeInsets.symmetric(horizontal: 5),
            decoration: BoxDecoration(
              color: AppColor.darkGrey,
              borderRadius: BorderRadius.circular(10),
              border: isSelected ? Border.all(color: AppColor.white.withValues(alpha: 0.5)) : null,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                5.height,
                Container(
                  height: 40,
                  width: 40,
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(),
                  child: PreviewGiftWidget(
                    url: gift?.image,
                    type: gift?.type ?? 0,
                  ),
                ),
                5.height,
                Text(
                  gift?.title ?? "",
                  style: AppFontStyle.styleW600(AppColor.white, 9),
                ),
                5.height,
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: EdgeInsets.only(left: 5, right: 7, top: 2, bottom: 2),
                      decoration: BoxDecoration(
                        color: AppColor.lightYellow.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(100),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(AppAssets.icCoinStar, width: 12),
                          3.width,
                          Text(
                            CustomFormatNumber.onConvert(gift?.coin ?? 0),
                            style: AppFontStyle.styleW700(AppColor.lightYellow, 10),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class GiftCountItemWidget extends StatelessWidget {
  const GiftCountItemWidget({super.key, required this.count, required this.isSelected, required this.callback});

  final int count;
  final bool isSelected;
  final Callback callback;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: callback,
        child: Container(
          height: 45,
          alignment: Alignment.center,
          margin: EdgeInsets.symmetric(horizontal: 0, vertical: 5),
          decoration: BoxDecoration(
            color: isSelected ? AppColor.white.withValues(alpha: 0.1) : AppColor.transparent,
            borderRadius: BorderRadius.circular(100),
          ),
          child: Text(
            count.toString(),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: AppFontStyle.styleW600(AppColor.white, 12),
          ),
        ),
      ),
    );
  }
}
