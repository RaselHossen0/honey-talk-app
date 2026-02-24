import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:tingle/utils/assets.dart';
import 'package:tingle/utils/color.dart';
import 'package:tingle/utils/utils.dart';

class PkItemShimmerWidget extends StatelessWidget {
  const PkItemShimmerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.0),
      child: Shimmer.fromColors(
        baseColor: AppColor.baseColor,
        highlightColor: AppColor.highlightColor,
        child: ListView.builder(
          itemCount: 10,
          shrinkWrap: true,
          padding: EdgeInsets.zero,
          itemBuilder: (context, index) {
            return Container(
              height: 150,
              width: Get.width,
              margin: EdgeInsets.only(bottom: 10),
              padding: EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                color: AppColor.black.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(23),
                border: Border.all(color: AppColor.black),
              ),
              child: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            10.height,
                            Container(
                              height: 55,
                              width: 55,
                              clipBehavior: Clip.antiAlias,
                              decoration: BoxDecoration(
                                color: AppColor.black.withValues(alpha: 0.99),
                                shape: BoxShape.circle,
                              ),
                            ),
                            5.height,
                            Container(
                              height: 15,
                              width: 80,
                              decoration: BoxDecoration(
                                color: AppColor.black.withValues(alpha: 0.99),
                                borderRadius: BorderRadius.circular(5),
                              ),
                            ),
                            3.height,
                            Container(
                              height: 15,
                              width: 60,
                              decoration: BoxDecoration(
                                color: AppColor.black.withValues(alpha: 0.99),
                                borderRadius: BorderRadius.circular(5),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        height: 100,
                        width: 100,
                        alignment: Alignment.center,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Image.asset(AppAssets.imgRandomPk, width: 100),
                            Spacer(),
                            Image.asset(AppAssets.icYellowVs, width: 100),
                            Spacer(),
                            const Offstage(),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            10.height,
                            Container(
                              height: 50,
                              width: 50,
                              clipBehavior: Clip.antiAlias,
                              decoration: BoxDecoration(
                                color: AppColor.black.withValues(alpha: 0.99),
                                shape: BoxShape.circle,
                              ),
                            ),
                            5.height,
                            Container(
                              height: 15,
                              width: 80,
                              decoration: BoxDecoration(
                                color: AppColor.black.withValues(alpha: 0.99),
                                borderRadius: BorderRadius.circular(5),
                              ),
                            ),
                            3.height,
                            Container(
                              height: 15,
                              width: 60,
                              decoration: BoxDecoration(
                                color: AppColor.black.withValues(alpha: 0.99),
                                borderRadius: BorderRadius.circular(5),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Spacer(),
                  Container(
                    height: 25,
                    width: Get.width,
                    decoration: BoxDecoration(
                      color: AppColor.black.withValues(alpha: 0.99),
                      borderRadius: BorderRadius.circular(100),
                    ),
                  ),
                  10.height,
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
