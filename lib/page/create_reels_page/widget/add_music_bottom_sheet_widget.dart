import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';
import 'package:tingle/common/shimmer/sound_shimmer_ui.dart';
import 'package:tingle/common/widget/no_data_found_widget.dart';
import 'package:tingle/common/widget/preview_network_image_widget.dart';
import 'package:tingle/custom/function/custom_format_time.dart';
import 'package:tingle/page/create_reels_page/controller/create_reels_controller.dart';
import 'package:tingle/utils/assets.dart';
import 'package:tingle/utils/color.dart';
import 'package:tingle/utils/enums.dart';
import 'package:tingle/utils/font_style.dart';
import 'package:tingle/utils/utils.dart';

class AddMusicBottomSheetWidget {
  static void show({required BuildContext context}) {
    final controller = Get.find<CreateReelsController>();
    controller.initAllSound();
    controller.initFavoriteSound();

    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      useSafeArea: true,
      barrierColor: AppColor.black,
      backgroundColor: AppColor.transparent,
      builder: (context) => Container(
        height: (Get.height - 30),
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
                        EnumLocal.txtAddMusic.name.tr,
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
            Padding(
              padding: EdgeInsets.all(15),
              child: SearchSoundFieldUi(
                onChanged: (value) => controller.onSearchSound(),
                controller: controller.searchController,
                onClickClear: () {},
                isShowClearIcon: false,
              ),
            ),
            const SoundTabBarUi(),
            Expanded(
              child: GetBuilder<CreateReelsController>(
                id: "onChangeTabBar",
                builder: (logic) => PageView.builder(
                  itemCount: 2,
                  onPageChanged: (value) => logic.onChangeTabBar(value),
                  itemBuilder: (context, index) => logic.soundTabPages[logic.selectedTabIndex],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SoundTabBarUi extends StatelessWidget {
  const SoundTabBarUi({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColor.transparent,
        border: Border(bottom: BorderSide(color: AppColor.colorBorder.withAlpha(76))),
      ),
      child: GetBuilder<CreateReelsController>(
        id: "onChangeTabBar",
        builder: (logic) => Row(
          children: [
            TabBarItemUi(
              title: EnumLocal.txtDiscover.name.tr,
              callback: () => logic.onChangeTabBar(0),
              isSelected: logic.selectedTabIndex == 0,
            ),
            TabBarItemUi(
              title: EnumLocal.txtFavourite.name.tr,
              callback: () => logic.onChangeTabBar(1),
              isSelected: logic.selectedTabIndex == 1,
            ),
          ],
        ),
      ),
    );
  }
}

class TabBarItemUi extends StatelessWidget {
  const TabBarItemUi({super.key, required this.title, required this.callback, required this.isSelected});

  final String title;
  final Callback callback;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: callback,
        child: Container(
          height: 50,
          color: AppColor.transparent,
          child: Center(
            child: Text(
              title,
              style: AppFontStyle.styleW500(isSelected ? AppColor.primary : AppColor.grayText, 17),
            ),
          ),
        ),
      ),
    );
  }
}

class DiscoverTabUi extends StatelessWidget {
  const DiscoverTabUi({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CreateReelsController>(
      id: "onChangeSearchEvent",
      builder: (controller) => controller.isSearching
          ? GetBuilder<CreateReelsController>(
              id: "onSearchSound",
              builder: (controller) => controller.isSearchLoading
                  ? SoundShimmerUi()
                  : controller.searchSounds.isEmpty
                      ? NoDataFoundWidget()
                      : SingleChildScrollView(
                          padding: EdgeInsets.zero,
                          child: ListView.builder(
                            itemCount: controller.searchSounds.length,
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) => GetBuilder<CreateReelsController>(
                              id: "onChangeSound",
                              builder: (controller) => SoundItemUi(
                                id: controller.searchSounds[index].id ?? "",
                                songTitle: controller.searchSounds[index].songTitle ?? "",
                                songImage: controller.searchSounds[index].songImage ?? "",
                                songCategoryName: controller.searchSounds[index].songCategoryName ?? "",
                                singerName: controller.searchSounds[index].singerName ?? "",
                                songTime: CustomFormatTime.convert(controller.searchSounds[index].songTime ?? 0),
                                isFavorite: controller.searchSounds[index].isFavorite ?? false,
                                isSelected: controller.selectedSound?["id"] == (controller.searchSounds[index].id ?? ""),
                                callback: () => controller.onChangeSound(
                                  {
                                    "id": controller.searchSounds[index].id ?? "",
                                    "name": controller.searchSounds[index].songTitle ?? "",
                                    "image": controller.searchSounds[index].songImage ?? "",
                                    "link": ((controller.searchSounds[index].songLink ?? "")),
                                  },
                                ),
                              ),
                            ),
                          ),
                        ),
            )
          : GetBuilder<CreateReelsController>(
              id: "onGetAllSound",
              builder: (controller) => controller.isLoadingSound
                  ? SoundShimmerUi()
                  : controller.mainSoundCollection.isEmpty
                      ? NoDataFoundWidget()
                      : SingleChildScrollView(
                          padding: EdgeInsets.zero,
                          child: ListView.builder(
                            itemCount: controller.mainSoundCollection.length,
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) => GetBuilder<CreateReelsController>(
                              id: "onChangeSound",
                              builder: (controller) => SoundItemUi(
                                id: controller.mainSoundCollection[index].id ?? "",
                                songTitle: controller.mainSoundCollection[index].songTitle ?? "",
                                songImage: controller.mainSoundCollection[index].songImage ?? "",
                                songCategoryName: controller.mainSoundCollection[index].songCategoryName ?? "",
                                singerName: controller.mainSoundCollection[index].singerName ?? "",
                                songTime: CustomFormatTime.convert(controller.mainSoundCollection[index].songTime ?? 0),
                                isFavorite: controller.mainSoundCollection[index].isFavorite ?? false,
                                isSelected: controller.selectedSound?["id"] == (controller.mainSoundCollection[index].id ?? ""),
                                callback: () => controller.onChangeSound({
                                  "id": controller.mainSoundCollection[index].id ?? "",
                                  "name": controller.mainSoundCollection[index].songTitle ?? "",
                                  "image": controller.mainSoundCollection[index].songImage ?? "",
                                  "link": (controller.mainSoundCollection[index].songLink ?? ""),
                                }),
                              ),
                            ),
                          ),
                        ),
            ),
    );
  }
}

class FavouriteTabUi extends StatelessWidget {
  const FavouriteTabUi({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CreateReelsController>(
      id: "onChangeSearchEvent",
      builder: (controller) => controller.isSearching
          ? GetBuilder<CreateReelsController>(
              id: "onSearchSound",
              builder: (controller) => controller.isSearchLoading
                  ? SoundShimmerUi()
                  : controller.searchSounds.isEmpty
                      ? NoDataFoundWidget()
                      : SingleChildScrollView(
                          padding: EdgeInsets.zero,
                          child: ListView.builder(
                            itemCount: controller.searchSounds.length,
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) => GetBuilder<CreateReelsController>(
                              id: "onChangeSound",
                              builder: (controller) => SoundItemUi(
                                id: controller.searchSounds[index].id ?? "",
                                songTitle: controller.searchSounds[index].songTitle ?? "",
                                songImage: controller.searchSounds[index].songImage ?? "",
                                songCategoryName: controller.searchSounds[index].songCategoryName ?? "",
                                singerName: controller.searchSounds[index].singerName ?? "",
                                songTime: CustomFormatTime.convert(controller.searchSounds[index].songTime ?? 0),
                                isFavorite: controller.searchSounds[index].isFavorite ?? false,
                                isSelected: controller.selectedSound?["id"] == (controller.searchSounds[index].id ?? ""),
                                callback: () => controller.onChangeSound(
                                  {
                                    "id": controller.searchSounds[index].id ?? "",
                                    "name": controller.searchSounds[index].songTitle ?? "",
                                    "image": controller.searchSounds[index].songImage ?? "",
                                    "link": ((controller.searchSounds[index].songLink ?? "")),
                                  },
                                ),
                              ),
                            ),
                          ),
                        ),
            )
          : GetBuilder<CreateReelsController>(
              id: "onGetFavoriteSound",
              builder: (controller) => controller.isLoadingFavoriteSound
                  ? SoundShimmerUi()
                  : controller.favoriteSoundCollection.isEmpty
                      ? NoDataFoundWidget()
                      : SingleChildScrollView(
                          padding: EdgeInsets.zero,
                          child: ListView.builder(
                            itemCount: controller.favoriteSoundCollection.length,
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) => GetBuilder<CreateReelsController>(
                              id: "onChangeSound",
                              builder: (controller) => SoundItemUi(
                                id: controller.favoriteSoundCollection[index].songId?.id ?? "",
                                songTitle: controller.favoriteSoundCollection[index].songId?.songTitle ?? "",
                                songImage: controller.favoriteSoundCollection[index].songId?.songImage ?? "",
                                songCategoryName: controller.favoriteSoundCollection[index].songId?.songCategoryId?.name ?? "",
                                singerName: controller.favoriteSoundCollection[index].songId?.singerName ?? "",
                                songTime: CustomFormatTime.convert(controller.favoriteSoundCollection[index].songId?.songTime ?? 0),
                                isFavorite: true,
                                isSelected: controller.selectedSound?["id"] == (controller.favoriteSoundCollection[index].songId?.id ?? ""),
                                callback: () => controller.onChangeSound({
                                  "id": controller.favoriteSoundCollection[index].songId?.id ?? "",
                                  "name": controller.favoriteSoundCollection[index].songId?.songTitle ?? "",
                                  "image": controller.favoriteSoundCollection[index].songId?.songImage ?? "",
                                  "link": (controller.favoriteSoundCollection[index].songId?.songLink ?? ""),
                                }),
                              ),
                            ),
                          ),
                        ),
            ),
    );
  }
}

class SoundItemUi extends StatefulWidget {
  const SoundItemUi({
    super.key,
    required this.id,
    required this.songTitle,
    required this.songImage,
    required this.songCategoryName,
    required this.singerName,
    required this.songTime,
    required this.isFavorite,
    required this.isSelected,
    required this.callback,
  });

  final String id;
  final String songTitle;
  final String songImage;
  final String songCategoryName;
  final String singerName;
  final String songTime;
  final bool isFavorite;
  final bool isSelected;
  final Callback callback;

  @override
  State<SoundItemUi> createState() => _SoundItemUiState();
}

class _SoundItemUiState extends State<SoundItemUi> {
  final controller = Get.find<CreateReelsController>();
  RxBool isFavorite = false.obs;

  @override
  void initState() {
    isFavorite.value = widget.isFavorite;
    super.initState();
  }

  Future<void> onChangeFavorite() async {
    isFavorite.value = !isFavorite.value;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.callback,
      child: Container(
        height: 92,
        width: Get.width,
        padding: EdgeInsets.only(left: 15, right: 5),
        decoration: BoxDecoration(color: widget.isSelected ? AppColor.colorBorder : AppColor.transparent),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: 76,
              width: 76,
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(
                color: AppColor.colorBorder.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Image.asset(AppAssets.icImagePlaceHolder, width: 45),
                  AspectRatio(
                    aspectRatio: 1,
                    child: PreviewPostImageWidget(
                      image: widget.songImage,
                    ),
                  ),
                ],
              ),
            ),
            15.width,
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.songTitle,
                      maxLines: 1,
                      style: AppFontStyle.styleW600(AppColor.black, 15),
                    ),
                    Text(
                      widget.songCategoryName,
                      maxLines: 1,
                      style: AppFontStyle.styleW500(AppColor.black, 11),
                    ),
                    Text(
                      widget.singerName,
                      maxLines: 1,
                      style: AppFontStyle.styleW500(AppColor.black, 11),
                    ),
                    Text(
                      widget.songTime,
                      maxLines: 1,
                      style: AppFontStyle.styleW500(AppColor.black, 11),
                    ),
                  ],
                ),
              ),
            ),
            Column(
              children: [
                GestureDetector(
                  onTap: onChangeFavorite,
                  child: Container(
                    height: 50,
                    width: 50,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColor.transparent,
                    ),
                    child: Center(
                      child: Obx(
                        () => Image.asset(
                          isFavorite.value ? AppAssets.icSaveBold : AppAssets.icSaveBorder,
                          width: 24,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class SoundCheckBoxUi extends StatelessWidget {
  const SoundCheckBoxUi({super.key, required this.isSelected});

  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: isSelected
          ? Container(
              height: 20,
              width: 20,
              decoration: BoxDecoration(
                color: AppColor.primary,
                gradient: AppColor.primaryGradient,
                borderRadius: BorderRadius.circular(4),
              ),
              child: Center(
                child: Icon(Icons.done_rounded, color: AppColor.white, size: 15),
              ),
            )
          : Offstage(),
    );
  }
}

class SearchSoundFieldUi extends StatelessWidget {
  const SearchSoundFieldUi({
    super.key,
    required this.onClickClear,
    required this.controller,
    required this.onChanged,
    required this.isShowClearIcon,
  });

  final Callback onClickClear;
  final TextEditingController controller;
  final Function(String value) onChanged;
  final bool isShowClearIcon;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      padding: const EdgeInsets.only(left: 15, right: 12),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: AppColor.grayText.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: AppColor.colorBorder.withValues(alpha: 0.8)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            height: 20,
            width: 20,
            AppAssets.icSearch,
            color: AppColor.black,
          ),
          5.width,
          VerticalDivider(
            indent: 12,
            endIndent: 12,
            color: AppColor.grayText.withValues(alpha: 0.3),
          ),
          5.width,
          Expanded(
            child: TextFormField(
              controller: controller,
              cursorColor: AppColor.grayText,
              maxLines: 1,
              onChanged: onChanged,
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.only(top: 0),
                border: InputBorder.none,
                hintText: EnumLocal.txtSearchHintText.name.tr,
                hintStyle: AppFontStyle.styleW400(AppColor.grayText, 17),
              ),
            ),
          ),
          GestureDetector(
            onTap: onClickClear,
            child: Container(
              height: 30,
              width: 30,
              color: AppColor.transparent,
              child: Center(
                child: Image.asset(
                  height: 20,
                  width: 20,
                  AppAssets.icClose,
                  color: AppColor.black,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
