import 'dart:math';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:tingle/common/api/fetch_category_wise_gift_api.dart';
import 'package:tingle/common/api/fetch_gift_category_api.dart';
import 'package:tingle/common/api/fetch_gift_gallery_api.dart';
import 'package:tingle/common/model/fake_gift_gallary_model.dart';
import 'package:tingle/common/model/fetch_category_wise_gift_model.dart';
import 'package:tingle/common/model/fetch_gift_category_model.dart';
import 'package:tingle/common/model/fetch_gift_gallery_model.dart';
import 'package:tingle/common/widget/loading_widget.dart';
import 'package:tingle/common/widget/no_data_found_widget.dart';
import 'package:tingle/common/widget/preview_network_image_widget.dart';
import 'package:tingle/custom/function/custom_format_number.dart';
import 'package:tingle/firebase/authentication/firebase_access_token.dart';
import 'package:tingle/firebase/authentication/firebase_uid.dart';
import 'package:tingle/utils/assets.dart';
import 'package:tingle/utils/color.dart';
import 'package:tingle/utils/font_style.dart';
import 'package:tingle/utils/utils.dart';

class FakeGiftGalleryBottomSheetWidget {
  static ScrollController scrollController = ScrollController();

  static FetchGiftGalleryModel? fetchMyGiftGalleryModel;

  static RxBool isLoading = false.obs;
  static RxBool isPagination = false.obs;

  static List<Data> giftGallery = [];

  static FetchCategoryWiseGiftModel? fetchCategoryWiseGiftModel;
  static FetchGiftCategoryModel? fetchGiftCategoryModel;
  static List<GiftData> giftCategory = [];

  static List<Datas>? categorygift = [];
  static List<CategoryWiseGift> giftData = [];
  static FetchCategoryWiseGiftModel? local;

  static Future<void> allGiftDataApi() async {
    final uid = FirebaseUid.onGet() ?? "";
    final token = await FirebaseAccessToken.onGet() ?? "";

    fetchGiftCategoryModel = await FetchGiftCategoryApi.callApi(token: token, uid: uid);

    List<GiftData> category = fetchGiftCategoryModel?.data ?? [];

    await onGetCategoryWiseGift(category);

    giftGallery = generateSampleGiftGalleryModel().data ?? [];
    isLoading.value = false;
  }

  static Future<void> onGetCategoryWiseGift(List<GiftData> category) async {
    final uid = FirebaseUid.onGet() ?? "";
    final token = await FirebaseAccessToken.onGet() ?? "";

    for (int i = 0; i < (category.length); i++) {
      local = null;
      local = await FetchCategoryWiseGiftApi.callApi(token: token, uid: uid, giftCategoryId: category[i].id ?? "");
      giftData.addAll(local!.data!);
    }
  }

  static RxInt giftCreateCount = 0.obs;
  static void init(int count) async {
    giftCreateCount.value = count;
    isLoading.value = true;
    giftGallery.clear();
    giftCategory.clear();
    giftData.clear();

    scrollController.addListener(onPagination);
    await allGiftDataApi();
  }

  static void dispose() {
    scrollController.removeListener(onPagination);
  }

  static Future<void> onRefresh() async {
    FetchGiftGalleryApi.startPagination = 0;

    // isLoading.value = true;
    giftGallery.clear();
  }

  static FetchGiftGalleryModel generateSampleGiftGalleryModel() {
    giftData.shuffle();
    int giftShowLength = 0;
    if (giftCreateCount.value <= giftData.length) {
      giftShowLength = giftCreateCount.value;
    } else {
      giftShowLength = (Random().nextInt(giftData.length));
    }
    List<Data> giftList = List.generate(giftShowLength, (index) {
      final id = giftData[index].id ?? "";
      final date = DateTime.now().subtract(Duration(days: index));
      final formattedDate = DateFormat("yyyy-MM-ddTHH:mm:ss.SSS'Z'").format(date);

      return Data(
        id: id,
        totalGiftCount: Random().nextInt(10) + 1,
        latestDate: formattedDate,
        giftId: id,
        giftTitle: giftData[index].title ?? "",
        giftImage: giftData[index].image ?? "",
        giftCoin: giftData[index].coin,
        giftType: giftData[index].type, // types from 1 to 4
      );
    });

    return FetchGiftGalleryModel(
      status: true,
      message: "Received gift history retrieved successfully.",
      data: giftList,
    );
  }

  static Future<void> onGetGiftGallery() async {
    giftGallery.addAll(fetchMyGiftGalleryModel?.data ?? []);

    isLoading.value = false;

    if (fetchMyGiftGalleryModel?.data?.isEmpty ?? true) {
      FetchGiftGalleryApi.startPagination--;
    }
  }

  static void onPagination() async {
    if (scrollController.position.pixels == scrollController.position.maxScrollExtent && !isPagination.value) {
      isPagination.value = true;
      await onGetGiftGallery();
      isPagination.value = false;
    }
  }

  static Future<void> show({required BuildContext context, required int count}) async {
    init(count);
    await showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      barrierColor: AppColor.black.withValues(alpha: 0.8),
      backgroundColor: AppColor.transparent,
      builder: (context) => Container(
        height: Get.height / 1.5,
        width: Get.width,
        clipBehavior: Clip.antiAlias,
        decoration: const BoxDecoration(
          color: AppColor.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(40),
            topRight: Radius.circular(40),
          ),
        ),
        child: Stack(
          fit: StackFit.expand,
          children: [
            Container(
              height: Get.height,
              width: Get.width,
              decoration: BoxDecoration(color: AppColor.black),
            ),
            Column(
              children: [
                Container(
                  height: 60,
                  color: AppColor.darkGrey,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      50.width,
                      const Spacer(),
                      10.height,
                      Text(
                        "Gift Gallery",
                        style: AppFontStyle.styleW700(AppColor.white, 17),
                      ),
                      const Spacer(),
                      GestureDetector(
                        onTap: () => Get.back(),
                        child: Container(
                          height: 30,
                          width: 30,
                          margin: const EdgeInsets.only(right: 20),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(shape: BoxShape.circle, border: Border.all(color: AppColor.white)),
                          child: Image.asset(width: 18, AppAssets.icClose, color: AppColor.white),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Obx(
                    () => isLoading.value
                        ? LoadingWidget(color: AppColor.white)
                        : giftGallery.isEmpty
                            ? NoDataFoundWidget()
                            : SingleChildScrollView(
                                controller: scrollController,
                                child: GridView.builder(
                                  shrinkWrap: true,
                                  itemCount: giftGallery.length,
                                  padding: EdgeInsets.all(12),
                                  physics: AlwaysScrollableScrollPhysics(),
                                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 4,
                                    crossAxisSpacing: 8,
                                    mainAxisSpacing: 8,
                                    mainAxisExtent: 120,
                                  ),
                                  itemBuilder: (context, index) {
                                    final indexData = giftGallery[index];
                                    return GiftItemWidget(gift: indexData);
                                  },
                                ),
                              ),
                  ),
                ),
                SizedBox(
                  height: 3,
                  child: Obx(
                    () => Visibility(
                      visible: isPagination.value,
                      child: LinearProgressIndicator(color: AppColor.primary),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    ).whenComplete(() => dispose());
  }
}

class GiftItemWidget extends StatelessWidget {
  const GiftItemWidget({super.key, this.gift});

  final Data? gift;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, box) {
        return GestureDetector(
          child: Container(
            height: box.maxHeight,
            width: box.maxWidth,
            alignment: Alignment.center,
            padding: EdgeInsets.symmetric(horizontal: 5),
            decoration: BoxDecoration(
              color: AppColor.white.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                10.height,
                Container(
                  height: 40,
                  width: 40,
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(),
                  child: PreviewGiftWidget(
                    url: gift?.giftImage ?? "",
                    type: gift?.giftType ?? 0,
                  ),
                ),
                5.height,
                Text(
                  gift?.giftTitle ?? '',
                  style: AppFontStyle.styleW600(AppColor.white, 10),
                ),
                3.height,
                Text(
                  "${gift?.totalGiftCount} Gifts",
                  style: AppFontStyle.styleW700(AppColor.colorBorder, 9),
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
                            CustomFormatNumber.onConvert(gift?.giftCoin ?? 0),
                            style: AppFontStyle.styleW700(AppColor.lightYellow, 10),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                10.height,
              ],
            ),
          ),
        );
      },
    );
  }
}
