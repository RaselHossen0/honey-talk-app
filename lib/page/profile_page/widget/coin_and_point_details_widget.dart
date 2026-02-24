import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';
import 'package:tingle/page/profile_page/controller/profile_controller.dart';
import 'package:tingle/routes/app_routes.dart';
import 'package:tingle/utils/assets.dart';
import 'package:tingle/utils/color.dart';
import 'package:tingle/utils/constant.dart';
import 'package:tingle/utils/enums.dart';
import 'package:tingle/utils/font_style.dart';
import 'package:tingle/utils/utils.dart';

class CoinAndPointDetailsWidget extends GetView<ProfileController> {
  const CoinAndPointDetailsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProfileController>(
      id: AppConstant.onGetProfile,
      builder: (controller) => Container(
        color: AppColor.transparent,
        margin: const EdgeInsets.symmetric(horizontal: 15),
        child: Row(
          children: [
            ItemWidget(
              title: EnumLocal.txtMyCoins.name.tr,
              count: (controller.fetchUserProfileModel?.user?.coin ?? 0).toInt(),
              image: AppAssets.icMyCoin,
              gradient: AppColor.orangeYellowGradient,
              callback: () => Get.toNamed(AppRoutes.coinHistoryPage)?.then((value) {
                Utils.onChangeStatusBar(brightness: Brightness.dark);
                controller.scrollController.jumpTo(0.0);
              }),
            ),
          ],
        ),
      ),
    );
  }
}

class ItemWidget extends StatelessWidget {
  const ItemWidget({
    super.key,
    required this.title,
    required this.count,
    required this.image,
    required this.gradient,
    required this.callback,
  });

  final String title;
  final int count;
  final String image;
  final Gradient gradient;
  final Callback callback;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: callback,
        child: Container(
          height: 72,
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            gradient: gradient,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: AppColor.white,
              width: 1.5,
            ),
          ),
          child: Row(
            children: [
              Image.asset(image, width: 48),
              15.width,
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Stack(
                    children: [
                      Text(
                        "Available My Coins",
                        style: AppFontStyle.styleW600(AppColor.white.withValues(alpha: 0.8), 10),
                      ),
                      Positioned(
                        left: 0,
                        right: 0,
                        bottom: 0,
                        child: Container(
                          height: 1,
                          color: AppColor.white.withValues(alpha: 0.8),
                        ),
                      ),
                    ],
                  ),
                  8.height,
                  Text(
                    (count).toStringAsFixed(2),
                    style: AppFontStyle.styleW900(AppColor.white, 18),
                  ),
                ],
              ),
              const Spacer(),
              Image.asset(AppAssets.icDoubleArrowRight, width: 20),
            ],
          ),
        ),
      ),
    );
  }
}

// class ItemWidget extends StatelessWidget {
//   const ItemWidget({
//     super.key,
//     required this.title,
//     required this.count,
//     required this.image,
//     required this.gradient,
//     required this.callback,
//   });
//
//   final String title;
//   final int count;
//   final String image;
//   final Gradient gradient;
//   final Callback callback;
//
//   @override
//   Widget build(BuildContext context) {
//     return Expanded(
//       child: GestureDetector(
//         onTap: callback,
//         child: Container(
//           height: 72,
//           padding: const EdgeInsets.symmetric(horizontal: 12),
//           decoration: BoxDecoration(
//             gradient: gradient,
//             borderRadius: BorderRadius.circular(16),
//             border: Border.all(
//               color: AppColor.white,
//               width: 1.5,
//             ),
//           ),
//           child: Row(
//             children: [
//               Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Text(
//                     "$title >>",
//                     style: AppFontStyle.styleW600(AppColor.white, 10),
//                   ),
//                   11.height,
//                   Text(
//                     CustomFormatNumber.onConvert(count),
//                     style: AppFontStyle.styleW900(AppColor.white, 18),
//                   ),
//                 ],
//               ),
//               const Spacer(),
//               Image.asset(image, width: 52),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
