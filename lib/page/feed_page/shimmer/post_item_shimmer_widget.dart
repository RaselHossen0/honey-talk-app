import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:tingle/utils/color.dart';
import 'package:tingle/utils/utils.dart';

class PostItemShimmerWidget extends StatelessWidget {
  const PostItemShimmerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: AppColor.baseColor,
      highlightColor: AppColor.highlightColor,
      child: ListView.builder(
        itemCount: 15,
        padding: EdgeInsets.only(top: 10),
        itemBuilder: (context, index) => Padding(
          padding: const EdgeInsets.only(bottom: 15),
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(color: AppColor.secondary),
              borderRadius: BorderRadius.circular(35),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        height: 50,
                        width: 50,
                        decoration: const BoxDecoration(color: AppColor.black, shape: BoxShape.circle),
                      ),
                      10.width,
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              height: 25,
                              width: Get.width,
                              margin: const EdgeInsets.only(bottom: 5),
                              decoration: BoxDecoration(color: AppColor.black, borderRadius: BorderRadius.circular(20)),
                            ),
                            Container(
                              height: 20,
                              width: 120,
                              decoration: BoxDecoration(color: AppColor.black, borderRadius: BorderRadius.circular(20)),
                            ),
                          ],
                        ),
                      ),
                      10.width,
                      Container(
                        height: 50,
                        width: 50,
                        decoration: const BoxDecoration(color: AppColor.black, shape: BoxShape.circle),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 300,
                  width: Get.width,
                  decoration: BoxDecoration(color: AppColor.black),
                ),
                Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          for (int i = 0; i < 3; i++)
                            Container(
                              height: 40,
                              width: 40,
                              margin: const EdgeInsets.only(bottom: 5, right: 10),
                              decoration: const BoxDecoration(color: AppColor.black, shape: BoxShape.circle),
                            ),
                        ],
                      ),
                      3.height,
                      Container(
                        height: 75,
                        width: 300,
                        margin: const EdgeInsets.only(bottom: 5),
                        decoration: BoxDecoration(color: AppColor.black, borderRadius: BorderRadius.circular(10)),
                      ),
                      3.height,
                      Row(
                        children: [
                          for (int i = 0; i < 3; i++)
                            Container(
                              height: 28,
                              width: 85,
                              margin: const EdgeInsets.only(right: 10),
                              decoration: BoxDecoration(
                                color: AppColor.black,
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                        ],
                      ),
                      8.height,
                      Container(
                        height: 30,
                        width: 150,
                        margin: const EdgeInsets.only(right: 10),
                        decoration: BoxDecoration(
                          color: AppColor.black,
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
