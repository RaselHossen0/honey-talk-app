import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';
import 'package:tingle/common/api/fetch_category_wise_gift_api.dart';
import 'package:tingle/common/api/fetch_gift_category_api.dart';
import 'package:tingle/common/function/fetch_user_coin.dart';
import 'package:tingle/common/function/show_received_gift.dart';
import 'package:tingle/common/model/fetch_category_wise_gift_model.dart';
import 'package:tingle/common/widget/coin_purchase_bottom_sheet.dart';
import 'package:tingle/common/widget/loading_widget.dart';
import 'package:tingle/common/widget/no_data_found_widget.dart';
import 'package:tingle/common/widget/preview_network_image_widget.dart';
import 'package:tingle/custom/function/custom_format_number.dart';
import 'package:tingle/firebase/authentication/firebase_access_token.dart';
import 'package:tingle/firebase/authentication/firebase_uid.dart';
import 'package:tingle/page/fake_live_page/controller/fake_live_controller.dart';
import 'package:tingle/utils/assets.dart';
import 'package:tingle/utils/color.dart';
import 'package:tingle/utils/database.dart';
import 'package:tingle/utils/enums.dart';
import 'package:tingle/utils/font_style.dart';
import 'package:tingle/utils/utils.dart';

class FakeLiveGiftBottomSheetWidget {
  static final controller = Get.find<FakeLiveController>();
  static RxString selectedCategoryId = "".obs;
  static RxInt selectedGiftIndex = 0.obs;
  static RxList selectedUserId = [].obs;

  static RxBool isLoading = false.obs;
  static FetchCategoryWiseGiftModel? fetchCategoryWiseGiftModel;

  static RxInt selectedSendGiftCount = 1.obs;
  static List<int> giftCounts = [1, 5, 10, 20];
  static void onChangeGiftCount(int count) => selectedSendGiftCount.value = count;

  static RxInt selectedPkRecipient = 0.obs;
  static bool isPkMode = false;
  static String host1UserId = "";
  static String host1Name = "";
  static String host1Image = "";
  static bool host1ProfilePicIsBanned = false;
  static String host2UserId = "";
  static String host2Name = "";
  static String host2Image = "";
  static bool host2ProfilePicIsBanned = false;

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

    FetchCategoryWiseGiftApi.categoryWiseGift[category] = fetchCategoryWiseGiftModel?.data ?? [];

    isLoading.value = false;
  }

  static void onSendGift({CategoryWiseGift? gift}) async {
    final giftCoin = ((gift?.coin ?? 1) * selectedSendGiftCount.value * selectedUserId.length);
    Utils.showLog("Gift Coin => $giftCoin My Coin => ${FetchUserCoin.coin.value}");

    if (FetchUserCoin.coin.value > giftCoin) {
      ShowReceivedGift.onGetNewGift(
        GiftModel(
          giftUrl: gift?.image ?? "",
          giftType: gift?.type ?? 0,
          giftCount: selectedSendGiftCount.value,
          senderName: Database.fetchLoginUserProfile()?.user?.name ?? "",
          senderImage: Database.fetchLoginUserProfile()?.user?.image ?? "",
          senderUniqueId: Database.fetchLoginUserProfile()?.user?.uniqueId ?? "",
          senderProfilePicBanned: Database.fetchLoginUserProfile()?.user?.isProfilePicBanned ?? false,
        ),
      );

      // Get.back();
    } else {
      Utils.showToast(text: EnumLocal.txtYouDonHaveSufficientDiamondsToSendTheGift.name.tr);
    }
  }

  // static void onSendGift({
  //   CategoryWiseGift? gift,
  //   required String liveHistoryId,
  //   required String receiverUserId,
  // }) async {
  //   if (FetchUserCoin.coin.value > ((gift?.coin ?? 1) * selectedSendGiftCount.value)) {
  //     if (controller.FakeliveModel?.isChannelMediaRelay == true) {
  //       SocketEmit.onPkGift(
  //         giftId: gift?.id ?? "",
  //         giftUrl: gift?.image ?? "",
  //         giftType: gift?.type ?? 0,
  //         giftCount: selectedSendGiftCount.value,
  //         receiverUserId: receiverUserId,
  //         liveHistoryId: liveHistoryId,
  //         senderUserId: Database.fetchLoginUserProfile()?.user?.id ?? "",
  //         senderUniqueId: Database.fetchLoginUserProfile()?.user?.uniqueId ?? "",
  //         senderName: Database.fetchLoginUserProfile()?.user?.name ?? "",
  //         senderImage: Database.fetchLoginUserProfile()?.user?.image ?? "",
  //         senderProfilePicBanned: Database.fetchLoginUserProfile()?.user?.isProfilePicBanned ?? false,
  //       );
  //     } else {
  //       SocketEmit.onGiftToLiveStream(
  //         giftId: gift?.id ?? "",
  //         giftUrl: gift?.image ?? "",
  //         giftType: gift?.type ?? 0,
  //         giftCount: selectedSendGiftCount.value,
  //         liveHistoryId: liveHistoryId,
  //         receiverUserId: receiverUserId,
  //         senderUserId: Database.fetchLoginUserProfile()?.user?.id ?? "",
  //         senderUniqueId: Database.fetchLoginUserProfile()?.user?.uniqueId ?? "",
  //         senderName: Database.fetchLoginUserProfile()?.user?.name ?? "",
  //         senderImage: Database.fetchLoginUserProfile()?.user?.image ?? "",
  //         senderProfilePicBanned: Database.fetchLoginUserProfile()?.user?.isProfilePicBanned ?? false,
  //       );
  //     }
  //
  //     Get.back();
  //   } else {
  //     Utils.showToast(text: EnumLocal.txtYouDonHaveSufficientDiamondsToSendTheGift.name.tr);
  //   }
  // }

  static void show({
    required BuildContext context,
    required String liveHistoryId,
    required String receiverUserId,
    bool isPk = false,
    String? pkHost1UserId,
    String? pkHost1Name,
    String? pkHost1Image,
    bool? pkHost1ProfilePicIsBanned,
    String? pkHost2UserId,
    String? pkHost2Name,
    String? pkHost2Image,
    bool? pkHost2ProfilePicIsBanned,
  }) {
    isPkMode = isPk;
    if (isPk && pkHost1UserId != null && pkHost2UserId != null) {
      host1UserId = pkHost1UserId;
      host1Name = pkHost1Name ?? "";
      host1Image = pkHost1Image ?? "";
      host1ProfilePicIsBanned = pkHost1ProfilePicIsBanned ?? false;
      host2UserId = pkHost2UserId;
      host2Name = pkHost2Name ?? "";
      host2Image = pkHost2Image ?? "";
      host2ProfilePicIsBanned = pkHost2ProfilePicIsBanned ?? false;
      selectedPkRecipient.value = 0;
    }
    onChangeCategory(FetchGiftCategoryApi.giftCategory[0].id ?? "");
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
      builder: (context) => Obx(() {
        // Read all observables at top level to satisfy GetX
        final coin = FetchUserCoin.coin.value;
        final selectedCount = selectedSendGiftCount.value;
        final selectedCategory = selectedCategoryId.value;
        final selectedGiftIdx = selectedGiftIndex.value;
        final selectedPk = selectedPkRecipient.value;
        final loading = isLoading.value;

        return Container(
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
                height: 60,
                width: Get.width,
                padding: EdgeInsets.symmetric(horizontal: 15),
                decoration: BoxDecoration(
                  color: AppColor.black,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    30.width,
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
                          "Send Gift",
                          style: AppFontStyle.styleW700(AppColor.white, 17),
                        ),
                      ],
                    ),
                    const Spacer(),
                    GestureDetector(
                      onTap: () => Get.back(),
                      child: Container(
                        height: 30,
                        width: 30,
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
              if (isPkMode)
                _FakePkRecipientSelector(
                  selectedIndex: selectedPk,
                  onSelect: (index) => selectedPkRecipient.value = index,
                  host1Name: host1Name,
                  host1Image: host1Image,
                  host1IsBanned: host1ProfilePicIsBanned,
                  host2Name: host2Name,
                  host2Image: host2Image,
                  host2IsBanned: host2ProfilePicIsBanned,
                ),
              SizedBox(
                height: 45,
                width: Get.width,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      for (var i = 0; i < FetchGiftCategoryApi.giftCategory.length; i++) ...[
                        if (i > 0) 8.width,
                        Builder(
                          builder: (context) {
                            final data = FetchGiftCategoryApi.giftCategory[i];
                            return GiftTabItemWidget(
                              name: data.name ?? "",
                              isSelected: selectedCategory == data.id,
                              callback: () => onChangeCategory(data.id ?? ""),
                            );
                          },
                        ),
                      ],
                    ],
                  ),
                ),
              ),
              Expanded(
                child: loading
                    ? LoadingWidget()
                    : FetchCategoryWiseGiftApi.categoryWiseGift[selectedCategory]?.isEmpty ?? true
                        ? NoDataFoundWidget()
                        : SingleChildScrollView(
                            child: GridView.builder(
                              shrinkWrap: true,
                              itemCount: FetchCategoryWiseGiftApi.categoryWiseGift[selectedCategory]?.length ?? 0,
                              padding: EdgeInsets.all(12),
                              physics: const NeverScrollableScrollPhysics(),
                              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 4,
                                crossAxisSpacing: 8,
                                mainAxisSpacing: 8,
                                mainAxisExtent: 100,
                              ),
                              itemBuilder: (context, index) {
                                final indexData = FetchCategoryWiseGiftApi.categoryWiseGift[selectedCategory]?[index];
                                return GiftItemWidget(
                                  gift: indexData,
                                  isSelected: selectedGiftIdx == index,
                                  callback: () => selectedGiftIndex.value = index,
                                );
                              },
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
                    GestureDetector(
                      onTap: () {
                        Get.back();
                        CoinPurchaseBottomSheet.show(
                          context: context,
                        );
                      },
                      child: Container(
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
                            Image.asset(AppAssets.icMyDiamond, width: 20),
                            5.width,
                            Text(
                              CustomFormatNumber.onConvert(coin),
                              style: AppFontStyle.styleW700(AppColor.white, 15),
                            ),
                            8.width,
                            Image.asset(AppAssets.icArrowRight, color: AppColor.white, width: 6),
                          ],
                        ),
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
                      child: Row(
                        children: [
                          5.width,
                          for (int index = 0; index < giftCounts.length; index++)
                            GiftCountItemWidget(
                              count: giftCounts[index],
                              isSelected: selectedCount == giftCounts[index],
                              callback: () => onChangeGiftCount(giftCounts[index]),
                            ),
                          10.width,
                          GestureDetector(
                            onTap: () {
                              Get.back();
                              onSendGift(
                                gift: FetchCategoryWiseGiftApi.categoryWiseGift[selectedCategory]?[selectedGiftIdx],
                              );
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
                  ],
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}

class _FakePkRecipientSelector extends StatelessWidget {
  const _FakePkRecipientSelector({
    required this.selectedIndex,
    required this.onSelect,
    required this.host1Name,
    required this.host1Image,
    required this.host1IsBanned,
    required this.host2Name,
    required this.host2Image,
    required this.host2IsBanned,
  });

  final int selectedIndex;
  final ValueChanged<int> onSelect;
  final String host1Name;
  final String host1Image;
  final bool host1IsBanned;
  final String host2Name;
  final String host2Image;
  final bool host2IsBanned;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          InkWell(
            onTap: () => onSelect(0),
            borderRadius: BorderRadius.circular(30),
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: selectedIndex == 0 ? AppColor.red : AppColor.white.withValues(alpha: 0.3),
                      width: 2,
                    ),
                  ),
                  clipBehavior: Clip.antiAlias,
                  child: PreviewProfileImageWidget(
                    image: host1Image,
                    isBanned: host1IsBanned,
                    fit: BoxFit.cover,
                  ),
                ),
                4.height,
                SizedBox(
                  width: 60,
                  child: Text(
                    host1Name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                    style: AppFontStyle.styleW500(AppColor.white, 10),
                  ),
                ),
              ],
            ),
          ),
        ),
          12.width,
          Text("PK", style: AppFontStyle.styleW700(AppColor.primary, 14)),
          12.width,
          InkWell(
            onTap: () => onSelect(1),
            borderRadius: BorderRadius.circular(30),
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: selectedIndex == 1 ? AppColor.red : AppColor.white.withValues(alpha: 0.3),
                      width: 2,
                    ),
                  ),
                  clipBehavior: Clip.antiAlias,
                  child: PreviewProfileImageWidget(
                    image: host2Image,
                    isBanned: host2IsBanned,
                    fit: BoxFit.cover,
                  ),
                ),
                4.height,
                SizedBox(
                  width: 60,
                  child: Text(
                    host2Name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                    style: AppFontStyle.styleW500(AppColor.white, 10),
                  ),
                ),
              ],
            ),
          ),
        ),
        ],
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
                SizedBox(
                  height: 45,
                  width: 45,
                  child: Center(
                    child: SizedBox(
                      height: 40,
                      width: 40,
                      child: PreviewPostImageWidget(
                        image: gift?.image,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ),
                5.height,
                Text(
                  "Couple Ring",
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
                          Image.asset(AppAssets.icMyDiamond, width: 12),
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
