// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';
// import 'package:tingle/common/widget/preview_network_image_widget.dart';
// import 'package:tingle/page/audio_room_page/controller/audio_room_controller.dart';
// import 'package:tingle/utils/assets.dart';
// import 'package:tingle/utils/color.dart';
// import 'package:tingle/utils/enums.dart';
// import 'package:tingle/utils/font_style.dart';
// import 'package:tingle/utils/utils.dart';
//
// class AudioRoomSendGiftBottomSheetWidget {
//   static final controller = Get.find<AudioRoomController>();
//   static RxInt selectedGiftTabIndex = 0.obs;
//   static RxInt selectedSendGiftCount = 0.obs;
//
//   static List giftTab = ["Previlege", "Amethyst", "Ring", "Souvenir", "Car", "Heart"];
//   static List<int> giftCounts = [0, 10, 20, 50];
//
//   static RxBool isSelectedAll = false.obs;
//
//   static void onChangeTab(int index) async {
//     selectedGiftTabIndex.value = index;
//   }
//
//   static void onToggleSwitch() async {
//     isSelectedAll.value = !isSelectedAll.value;
//   }
//
//   static void onChangeGiftCount(int count) => selectedSendGiftCount.value = count;
//
//   static void show({required BuildContext context}) {
//     showModalBottomSheet(
//       isScrollControlled: true,
//       context: context,
//       backgroundColor: AppColor.transparent,
//       shape: const RoundedRectangleBorder(
//         borderRadius: BorderRadiusDirectional.only(
//           topEnd: Radius.circular(25),
//           topStart: Radius.circular(25),
//         ),
//       ),
//       builder: (context) => Container(
//         height: 450,
//         width: Get.width,
//         clipBehavior: Clip.antiAlias,
//         decoration: const BoxDecoration(
//           color: AppColor.black,
//           borderRadius: BorderRadius.only(
//             topLeft: Radius.circular(30),
//             topRight: Radius.circular(30),
//           ),
//         ),
//         child: Column(
//           children: [
//             Container(
//               height: 70,
//               width: Get.width,
//               padding: EdgeInsets.symmetric(horizontal: 15),
//               decoration: const BoxDecoration(
//                 color: AppColor.darkGrey,
//                 borderRadius: BorderRadius.only(
//                   topLeft: Radius.circular(30),
//                   topRight: Radius.circular(30),
//                 ),
//               ),
//               child: Stack(
//                 children: [
//                   SingleChildScrollView(
//                     scrollDirection: Axis.horizontal,
//                     child: Row(
//                       children: [
//                         80.width,
//                         GestureDetector(
//                           onTap: () => Utils.showLog("******"),
//                           child: Container(
//                             height: 40,
//                             width: 40,
//                             margin: EdgeInsets.only(right: 20),
//                             decoration: BoxDecoration(
//                               shape: BoxShape.circle,
//                               border: Border.all(color: AppColor.primary),
//                             ),
//                             child: Container(
//                               height: 40,
//                               width: 40,
//                               alignment: Alignment.center,
//                               clipBehavior: Clip.antiAlias,
//                               decoration: BoxDecoration(
//                                 shape: BoxShape.circle,
//                                 color: AppColor.transparent,
//                               ),
//                               child: Stack(
//                                 alignment: Alignment.center,
//                                 children: [
//                                   PreviewProfileImageWidget(),
//                                   Positioned(
//                                     bottom: -13,
//                                     child: Container(
//                                       height: 28,
//                                       width: 28,
//                                       alignment: Alignment.center,
//                                       padding: EdgeInsets.only(bottom: 12),
//                                       decoration: BoxDecoration(
//                                         shape: BoxShape.circle,
//                                         color: AppColor.primary,
//                                       ),
//                                       child: Image.asset(AppAssets.icSmallHomeIcon, width: 8),
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ),
//                         ),
//                         ListView.builder(
//                           itemCount: controller.audioRoomModel?.seatUsers.length ?? 0,
//                           shrinkWrap: true,
//                           scrollDirection: Axis.horizontal,
//                           physics: NeverScrollableScrollPhysics(),
//                           itemBuilder: (context, index) {
//                             final indexData = controller.audioRoomModel?.seatUsers[index];
//                             return GestureDetector(
//                               onTap: () => Utils.showLog("******$index"),
//                               child: Container(
//                                 height: 40,
//                                 width: 40,
//                                 margin: EdgeInsets.only(right: 20),
//                                 decoration: BoxDecoration(
//                                   shape: BoxShape.circle,
//                                   border: Border.all(color: AppColor.primary),
//                                 ),
//                                 child: Container(
//                                   height: 40,
//                                   width: 40,
//                                   alignment: Alignment.center,
//                                   clipBehavior: Clip.antiAlias,
//                                   decoration: BoxDecoration(
//                                     shape: BoxShape.circle,
//                                     color: AppColor.transparent,
//                                   ),
//                                   child: Stack(
//                                     alignment: Alignment.center,
//                                     children: [
//                                       PreviewProfileImageWidget(
//                                         image: indexData?.seat?.image,
//                                         isBanned: indexData?.seat?.isProfilePicBanned,
//                                       ),
//                                       Positioned(
//                                         bottom: 0,
//                                         child: Container(
//                                           height: 28,
//                                           width: 28,
//                                           alignment: Alignment.center,
//                                           padding: EdgeInsets.only(bottom: 14),
//                                           decoration: BoxDecoration(
//                                             shape: BoxShape.circle,
//                                             color: AppColor.primary,
//                                           ),
//                                           child: Text(
//                                             "${index + 1}",
//                                             style: AppFontStyle.styleW600(AppColor.white, 9),
//                                           ),
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                               ),
//                             );
//                           },
//                         ),
//                         70.width,
//                       ],
//                     ),
//                   ),
//                   Positioned(
//                     left: 0,
//                     child: Container(
//                       height: 70,
//                       width: 100,
//                       alignment: Alignment.centerLeft,
//                       decoration: BoxDecoration(
//                         gradient: LinearGradient(
//                           begin: Alignment.centerRight,
//                           end: Alignment.centerLeft,
//                           colors: [
//                             AppColor.darkGrey.withValues(alpha: 0.1),
//                             AppColor.darkGrey.withValues(alpha: 0.2),
//                             AppColor.darkGrey.withValues(alpha: 0.4),
//                             AppColor.darkGrey.withValues(alpha: 0.8),
//                             for (int i = 0; i < 5; i++) AppColor.darkGrey,
//                           ],
//                         ),
//                       ),
//                       child: Text(
//                         "${EnumLocal.txtSend.name.tr} :",
//                         style: AppFontStyle.styleW600(AppColor.white, 14),
//                       ),
//                     ),
//                   ),
//                   Positioned(
//                     right: 0,
//                     child: Container(
//                       height: 70,
//                       width: 100,
//                       alignment: Alignment.centerRight,
//                       decoration: BoxDecoration(
//                         gradient: LinearGradient(
//                           begin: Alignment.centerLeft,
//                           end: Alignment.centerRight,
//                           colors: [
//                             AppColor.darkGrey.withValues(alpha: 0.1),
//                             AppColor.darkGrey.withValues(alpha: 0.2),
//                             AppColor.darkGrey.withValues(alpha: 0.4),
//                             AppColor.darkGrey.withValues(alpha: 0.8),
//                             for (int i = 0; i < 5; i++) AppColor.darkGrey,
//                           ],
//                         ),
//                       ),
//                       child: GestureDetector(
//                         onTap: onToggleSwitch,
//                         child: Obx(
//                           () => Container(
//                             height: 30,
//                             width: 60,
//                             padding: EdgeInsets.symmetric(horizontal: 4),
//                             decoration: BoxDecoration(
//                               color: isSelectedAll.value ? AppColor.primary : AppColor.white,
//                               borderRadius: BorderRadius.circular(100),
//                             ),
//                             child: Stack(
//                               alignment: Alignment.center,
//                               children: [
//                                 Row(
//                                   children: [
//                                     AnimatedContainer(
//                                       duration: Duration(milliseconds: 300),
//                                       curve: Curves.easeInOut,
//                                       margin: EdgeInsets.only(left: isSelectedAll.value ? 30 : 0),
//                                       height: 22,
//                                       width: 22,
//                                       decoration: BoxDecoration(
//                                         color: isSelectedAll.value ? AppColor.white : AppColor.primary,
//                                         borderRadius: BorderRadius.circular(100),
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                                 Positioned(
//                                   right: 8,
//                                   child: Visibility(
//                                     visible: isSelectedAll.value == false,
//                                     child: Text(
//                                       "All",
//                                       style: AppFontStyle.styleW700(AppColor.secondary, 12),
//                                     ),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             SizedBox(
//               height: 45,
//               width: Get.width,
//               child: SingleChildScrollView(
//                 scrollDirection: Axis.horizontal,
//                 child: Obx(
//                   () => Row(
//                     children: [
//                       for (int index = 0; index < giftTab.length; index++)
//                         GestureDetector(
//                           onTap: () => onChangeTab(index),
//                           child: GiftTabItemWidget(name: giftTab[index], isSelected: selectedGiftTabIndex.value == index),
//                         ),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//             Expanded(
//               child: SingleChildScrollView(
//                 child: GridView.builder(
//                   shrinkWrap: true,
//                   itemCount: 12,
//                   padding: EdgeInsets.all(12),
//                   physics: NeverScrollableScrollPhysics(),
//                   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                     crossAxisCount: 4,
//                     crossAxisSpacing: 8,
//                     mainAxisSpacing: 8,
//                     mainAxisExtent: 100,
//                   ),
//                   itemBuilder: (context, index) {
//                     return GiftItemWidget();
//                   },
//                 ),
//               ),
//             ),
//             Container(
//               height: 60,
//               width: Get.width,
//               padding: EdgeInsets.symmetric(horizontal: 12),
//               decoration: const BoxDecoration(
//                 color: AppColor.transparent,
//               ),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Container(
//                     height: 30,
//                     padding: EdgeInsets.only(left: 5, right: 7),
//                     decoration: BoxDecoration(
//                       gradient: AppColor.coinPinkGradient,
//                       borderRadius: BorderRadius.circular(100),
//                       border: Border.all(color: AppColor.white.withValues(alpha: 0.5)),
//                     ),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         Image.asset(AppAssets.icCoinStar, width: 20),
//                         5.width,
//                         Text(
//                           "65k",
//                           style: AppFontStyle.styleW700(AppColor.white, 15),
//                         ),
//                         8.width,
//                         Image.asset(AppAssets.icArrowRight, color: AppColor.white, width: 6),
//                       ],
//                     ),
//                   ),
//                   Container(
//                     height: 40,
//                     width: Get.width / 1.5,
//                     alignment: Alignment.center,
//                     decoration: BoxDecoration(
//                       color: AppColor.darkGrey,
//                       borderRadius: BorderRadius.circular(100),
//                     ),
//                     child: Obx(
//                       () => Row(
//                         children: [
//                           5.width,
//                           for (int index = 0; index < giftCounts.length; index++)
//                             GiftCountItemWidget(
//                               count: giftCounts[index],
//                               isSelected: selectedSendGiftCount.value == giftCounts[index],
//                               callback: () => onChangeGiftCount(giftCounts[index]),
//                             ),
//                           10.width,
//                           Container(
//                             height: 45,
//                             width: 70,
//                             alignment: Alignment.center,
//                             margin: EdgeInsets.symmetric(vertical: 5),
//                             decoration: BoxDecoration(
//                               color: AppColor.primary,
//                               borderRadius: BorderRadius.circular(100),
//                             ),
//                             child: Text(
//                               "Send",
//                               maxLines: 1,
//                               overflow: TextOverflow.ellipsis,
//                               style: AppFontStyle.styleW600(AppColor.white, 14),
//                             ),
//                           ),
//                           5.width,
//                         ],
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
//
// class GiftTabItemWidget extends StatelessWidget {
//   const GiftTabItemWidget({super.key, required this.isSelected, required this.name});
//
//   final bool isSelected;
//   final String name;
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: 45,
//       alignment: Alignment.center,
//       padding: EdgeInsets.symmetric(horizontal: 15),
//       decoration: BoxDecoration(
//         border: Border(
//           bottom: BorderSide(color: isSelected ? AppColor.lightYellow : AppColor.white.withValues(alpha: 0.2)),
//         ),
//       ),
//       child: Text(
//         name,
//         style: AppFontStyle.styleW600(isSelected ? AppColor.lightYellow : AppColor.secondary.withValues(alpha: 0.5), 14),
//       ),
//     );
//   }
// }
//
// class GiftItemWidget extends StatelessWidget {
//   const GiftItemWidget({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return LayoutBuilder(
//       builder: (context, box) {
//         return Container(
//           height: box.maxHeight,
//           width: box.maxWidth,
//           alignment: Alignment.center,
//           padding: EdgeInsets.symmetric(horizontal: 5),
//           decoration: BoxDecoration(
//             color: AppColor.darkGrey,
//             borderRadius: BorderRadius.circular(10),
//           ),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Image.asset(
//                 AppAssets.icDiamondRing,
//                 width: 45,
//               ),
//               5.height,
//               Text(
//                 "Couple Ring",
//                 style: AppFontStyle.styleW600(AppColor.white, 9),
//               ),
//               5.height,
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Container(
//                     padding: EdgeInsets.only(left: 5, right: 7, top: 2, bottom: 2),
//                     decoration: BoxDecoration(
//                       color: AppColor.lightYellow.withValues(alpha: 0.1),
//                       borderRadius: BorderRadius.circular(100),
//                     ),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         Image.asset(AppAssets.icCoinStar, width: 12),
//                         3.width,
//                         Text(
//                           "5000",
//                           style: AppFontStyle.styleW700(AppColor.lightYellow, 10),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }
// }
//
// class GiftCountItemWidget extends StatelessWidget {
//   const GiftCountItemWidget({super.key, required this.count, required this.isSelected, required this.callback});
//
//   final int count;
//   final bool isSelected;
//   final Callback callback;
//
//   @override
//   Widget build(BuildContext context) {
//     return Expanded(
//       child: GestureDetector(
//         onTap: callback,
//         child: Container(
//           height: 45,
//           alignment: Alignment.center,
//           margin: EdgeInsets.symmetric(horizontal: 0, vertical: 5),
//           decoration: BoxDecoration(
//             color: isSelected ? AppColor.white.withValues(alpha: 0.1) : AppColor.transparent,
//             borderRadius: BorderRadius.circular(100),
//           ),
//           child: Text(
//             count.toString(),
//             maxLines: 1,
//             overflow: TextOverflow.ellipsis,
//             style: AppFontStyle.styleW600(AppColor.white, 12),
//           ),
//         ),
//       ),
//     );
//   }
// }
