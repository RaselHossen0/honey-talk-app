import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:tingle/utils/color.dart';
import 'package:tingle/utils/utils.dart';

class PreviewUserProfileShimmerWidget extends StatelessWidget {
  const PreviewUserProfileShimmerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: AppColor.baseColor,
      highlightColor: AppColor.highlightColor,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 350,
              width: Get.width,
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(
                color: AppColor.white.withValues(alpha: 0.2),
              ),
            ),
            SizedBox(
              height: 50,
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  Positioned(
                    top: -40,
                    child: SizedBox(
                      width: Get.width,
                      child: Row(
                        children: [
                          15.width,
                          Container(
                            height: 80,
                            width: 80,
                            clipBehavior: Clip.antiAlias,
                            decoration: BoxDecoration(shape: BoxShape.circle, color: AppColor.white),
                          ),
                          Spacer(),
                          Container(
                            height: 80,
                            width: 230,
                            clipBehavior: Clip.antiAlias,
                            padding: EdgeInsets.only(right: 10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(15),
                                bottomLeft: Radius.circular(15),
                              ),
                              color: AppColor.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: 25,
              width: 100,
              margin: const EdgeInsets.only(left: 15, top: 5),
              decoration: BoxDecoration(
                color: AppColor.black,
                borderRadius: BorderRadius.circular(5),
              ),
            ),
            Row(
              children: [
                Container(
                  height: 25,
                  width: 70,
                  margin: const EdgeInsets.only(left: 15, top: 5),
                  decoration: BoxDecoration(
                    color: AppColor.black,
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
                Container(
                  height: 25,
                  width: 70,
                  margin: const EdgeInsets.only(left: 5, top: 5),
                  decoration: BoxDecoration(
                    color: AppColor.black,
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
              ],
            ),
            Container(
              height: 25,
              width: 175,
              margin: const EdgeInsets.only(left: 15, top: 5),
              decoration: BoxDecoration(
                color: AppColor.black,
                borderRadius: BorderRadius.circular(5),
              ),
            ),
            Container(
              height: 50,
              width: Get.width,
              margin: const EdgeInsets.only(top: 15),
              decoration: BoxDecoration(color: AppColor.black),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                15.width,
                Expanded(
                  child: Container(
                    height: 60,
                    margin: const EdgeInsets.only(top: 15),
                    decoration: BoxDecoration(
                      color: AppColor.black,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                15.width,
                Expanded(
                  child: Container(
                    height: 60,
                    margin: const EdgeInsets.only(top: 15),
                    decoration: BoxDecoration(
                      color: AppColor.black,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                15.width,
              ],
            ),
            15.height,
            Container(
              height: 80,
              margin: const EdgeInsets.symmetric(horizontal: 15),
              decoration: BoxDecoration(
                color: AppColor.black,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            10.height,
            Container(
              height: 80,
              margin: const EdgeInsets.symmetric(horizontal: 15),
              decoration: BoxDecoration(
                color: AppColor.black,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            15.height,
          ],
        ),
      ),
    );
  }
}
