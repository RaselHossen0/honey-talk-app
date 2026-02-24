import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:flutter/widgets.dart';
import 'package:tingle/utils/color.dart';
import 'package:tingle/utils/utils.dart';

class AudioRoomSeatUserBottomSheetShimmerUi extends StatelessWidget {
  const AudioRoomSeatUserBottomSheetShimmerUi({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: AppColor.baseColor,
      highlightColor: AppColor.highlightColor,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: 100,
              width: 100,
              margin: const EdgeInsets.only(bottom: 10),
              decoration: const BoxDecoration(color: AppColor.black, shape: BoxShape.circle),
            ),
            Container(
              height: 22,
              width: 175,
              margin: const EdgeInsets.only(bottom: 5),
              decoration: BoxDecoration(color: AppColor.black, borderRadius: BorderRadius.circular(20)),
            ),
            Container(
              height: 22,
              width: 250,
              margin: const EdgeInsets.only(bottom: 8),
              decoration: BoxDecoration(color: AppColor.black, borderRadius: BorderRadius.circular(20)),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 30,
                  width: 30,
                  margin: const EdgeInsets.only(bottom: 20),
                  decoration: const BoxDecoration(color: AppColor.black, shape: BoxShape.circle),
                ),
                8.width,
                Container(
                  height: 30,
                  width: 100,
                  margin: const EdgeInsets.only(bottom: 20),
                  decoration: BoxDecoration(color: AppColor.black, borderRadius: BorderRadius.circular(20)),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  children: [
                    Container(
                      height: 50,
                      width: 50,
                      margin: const EdgeInsets.only(bottom: 10),
                      decoration: const BoxDecoration(color: AppColor.black, shape: BoxShape.circle),
                    ),
                    Container(
                      height: 15,
                      width: 50,
                      decoration: BoxDecoration(color: AppColor.black, borderRadius: BorderRadius.circular(20)),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Container(
                      height: 50,
                      width: 50,
                      margin: const EdgeInsets.only(bottom: 10),
                      decoration: const BoxDecoration(color: AppColor.black, shape: BoxShape.circle),
                    ),
                    Container(
                      height: 15,
                      width: 50,
                      decoration: BoxDecoration(color: AppColor.black, borderRadius: BorderRadius.circular(20)),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Container(
                      height: 50,
                      width: 50,
                      margin: const EdgeInsets.only(bottom: 10),
                      decoration: const BoxDecoration(color: AppColor.black, shape: BoxShape.circle),
                    ),
                    Container(
                      height: 15,
                      width: 50,
                      decoration: BoxDecoration(color: AppColor.black, borderRadius: BorderRadius.circular(20)),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
