import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:tingle/utils/assets.dart';
import 'package:tingle/utils/color.dart';
import 'package:tingle/utils/utils.dart';

class PartyItemShimmerWidget extends StatelessWidget {
  const PartyItemShimmerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.0),
      child: Shimmer.fromColors(
        baseColor: AppColor.baseColor,
        highlightColor: AppColor.highlightColor,
        child: ListView.builder(
          itemCount: 10,
          padding: EdgeInsets.zero,
          physics: NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            return Container(
              height: 110,
              width: Get.width,
              margin: EdgeInsets.only(bottom: 10),
              decoration: BoxDecoration(
                color: AppColor.black.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(23),
                border: Border.all(color: AppColor.black),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 110,
                    width: 110,
                    child: Container(
                      height: 110,
                      width: 110,
                      margin: const EdgeInsets.all(8),
                      clipBehavior: Clip.antiAlias,
                      decoration: BoxDecoration(
                        color: AppColor.black.withValues(alpha: 0.99),
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                  ),
                  5.width,
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: 20,
                          width: 150,
                          decoration: BoxDecoration(
                            color: AppColor.black.withValues(alpha: 0.99),
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                        5.height,
                        Container(
                          height: 20,
                          width: 100,
                          decoration: BoxDecoration(
                            color: AppColor.black.withValues(alpha: 0.99),
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                        8.height,
                        Row(
                          children: [
                            Expanded(
                              child: Container(
                                height: 30,
                                color: AppColor.transparent,
                                child: Stack(
                                  children: [
                                    for (int i = 0; i < 4; i++)
                                      Positioned(
                                        left: i == 0 ? 0 : i * 25,
                                        child: Container(
                                          height: 30,
                                          width: 30,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: AppColor.transparent,
                                            border: Border.all(color: AppColor.white),
                                          ),
                                          child: Container(
                                            height: 30,
                                            width: 30,
                                            clipBehavior: Clip.antiAlias,
                                            alignment: Alignment.center,
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: AppColor.white.withValues(alpha: 0.1),
                                            ),
                                            child: Image.asset(AppAssets.icSeat, width: 15),
                                          ),
                                        ),
                                      ),
                                  ],
                                ),
                              ),
                            ),
                            5.width,
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                              decoration: BoxDecoration(
                                border: Border.all(color: AppColor.black.withValues(alpha: 0.5)),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Row(
                                children: [
                                  Image.asset(
                                    AppAssets.icLiveWave,
                                    width: 12,
                                    color: AppColor.black,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  15.width,
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
