import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tingle/common/widget/preview_network_image_widget.dart';
import 'package:tingle/page/my_live_pictures_page/controller/my_live_pictures_controller.dart';
import 'package:tingle/utils/assets.dart';
import 'package:tingle/utils/color.dart';
import 'package:tingle/utils/enums.dart';
import 'package:tingle/utils/font_style.dart';
import 'package:tingle/utils/utils.dart';

class MyLivePicturesView extends GetView<MyLivePicturesController> {
  const MyLivePicturesView({super.key});

  @override
  Widget build(BuildContext context) {
    Utils.onChangeStatusBar(brightness: Brightness.light);
    return Scaffold(
      backgroundColor: AppColor.colorScaffold,
      appBar: AppBar(
        backgroundColor: AppColor.transparent,
        elevation: 0,
        leading: GestureDetector(
          onTap: Get.back,
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Image.asset(AppAssets.icArrowLeft, width: 10, color: AppColor.black),
          ),
        ),
        centerTitle: true,
        title: Text(
          EnumLocal.txtMyLivePictures.name.tr,
          style: AppFontStyle.styleW700(AppColor.black, 18),
        ),
      ),
      body: GetBuilder<MyLivePicturesController>(
        builder: (ctrl) => SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildMainImage(ctrl),
              16.height,
              _buildUploadButton(ctrl),
              20.height,
              _buildThumbnailRow(ctrl),
              24.height,
              _buildGuidelines(),
              const SizedBox(height: 40),
              _buildLiveButton(ctrl),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMainImage(MyLivePicturesController ctrl) {
    return SizedBox(
      width: Get.width,
      height: 280,
      child: Stack(
        fit: StackFit.expand,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: PreviewProfileImageWidget(image: ctrl.mainImageUrl),
          ),
          Positioned(
            top: 12,
            right: 12,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: AppColor.green.withValues(alpha: 0.95),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.check, color: AppColor.white, size: 14),
                  4.width,
                  Text(
                    EnumLocal.txtApproved.name.tr,
                    style: AppFontStyle.styleW600(AppColor.white, 12),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildUploadButton(MyLivePicturesController ctrl) {
    return GestureDetector(
      onTap: ctrl.onUpload,
      child: Container(
        width: Get.width,
        padding: const EdgeInsets.symmetric(vertical: 14),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [AppColor.primary, AppColor.purple],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.add, color: AppColor.white, size: 20),
            8.width,
            Text(
              EnumLocal.txtUpload.name.tr,
              style: AppFontStyle.styleW600(AppColor.white, 14),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildThumbnailRow(MyLivePicturesController ctrl) {
    return SizedBox(
      height: 72,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: ctrl.thumbnails.length,
        separatorBuilder: (_, __) => 12.width,
        itemBuilder: (context, index) {
          final item = ctrl.thumbnails[index];
          return _buildThumbnailItem(item);
        },
      ),
    );
  }

  Widget _buildThumbnailItem(LivePictureModel item) {
    Widget? badge;
    if (item.status == LivePictureStatus.approved) {
      badge = Container(
        padding: const EdgeInsets.all(4),
        decoration: const BoxDecoration(
          color: AppColor.green,
          shape: BoxShape.circle,
        ),
        child: Icon(Icons.check, color: AppColor.white, size: 12),
      );
    } else if (item.status == LivePictureStatus.rejected) {
      badge = Container(
        padding: const EdgeInsets.all(4),
        decoration: const BoxDecoration(
          color: AppColor.red,
          shape: BoxShape.circle,
        ),
        child: Icon(Icons.close, color: AppColor.white, size: 12),
      );
    }

    return SizedBox(
      width: 72,
      height: 72,
      child: Stack(
        fit: StackFit.expand,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: PreviewProfileImageWidget(image: item.imageUrl),
          ),
          if (badge != null)
            Positioned(
              bottom: 4,
              right: 4,
              child: badge,
            ),
        ],
      ),
    );
  }

  Widget _buildGuidelines() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          EnumLocal.txtLiveUploadGuideline1.name.tr,
          style: AppFontStyle.styleW500(AppColor.darkGrey, 13),
        ),
        6.height,
        Text(
          EnumLocal.txtLiveUploadGuideline2.name.tr,
          style: AppFontStyle.styleW500(AppColor.darkGrey, 13),
        ),
        6.height,
        Text(
          EnumLocal.txtLiveUploadGuideline3.name.tr,
          style: AppFontStyle.styleW500(AppColor.darkGrey, 13),
        ),
      ],
    );
  }

  Widget _buildLiveButton(MyLivePicturesController ctrl) {
    return GestureDetector(
      onTap: ctrl.onLive,
      child: Container(
        width: Get.width,
        padding: const EdgeInsets.symmetric(vertical: 14),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [AppColor.primary, AppColor.purple],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Center(
          child: Text(
            'live',
            style: AppFontStyle.styleW600(AppColor.white, 16),
          ),
        ),
      ),
    );
  }
}
