import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:tingle/custom/widget/custom_light_background_widget.dart';
import 'package:tingle/utils/color.dart';
import 'package:tingle/utils/utils.dart';

class StoreShimmerWidget extends StatelessWidget {
  const StoreShimmerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        const CustomLightBackgroundWidget(),
        SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Title Shimmer
              SizedBox(
                height: 30,
              ),
              Shimmer.fromColors(
                baseColor: AppColor.baseColor,
                highlightColor: AppColor.highlightColor,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: Get.width,
                      height: 32,
                      color: AppColor.black,
                    ),
                    const SizedBox(height: 8),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Shimmer.fromColors(
                    baseColor: AppColor.baseColor,
                    highlightColor: AppColor.highlightColor,
                    child: Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColor.black,
                      ),
                    ),
                  ),
                  Shimmer.fromColors(
                    baseColor: AppColor.baseColor,
                    highlightColor: AppColor.highlightColor,
                    child: Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColor.black,
                      ),
                    ),
                  ),
                  Shimmer.fromColors(
                    baseColor: AppColor.baseColor,
                    highlightColor: AppColor.highlightColor,
                    child: Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColor.black,
                      ),
                    ),
                  ),
                ],
              ),
              5.height,
              Shimmer.fromColors(
                baseColor: AppColor.baseColor,
                highlightColor: AppColor.highlightColor,
                child: Container(
                  height: 200,
                  width: Get.width,
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(20), color: AppColor.black),
                ),
              ),

              5.height,
              Shimmer.fromColors(
                baseColor: AppColor.baseColor,
                highlightColor: AppColor.highlightColor,
                child: Container(
                  width: 180,
                  height: 20,
                  color: AppColor.black,
                  margin: const EdgeInsets.only(bottom: 16),
                ),
              ),
              5.height,
              Shimmer.fromColors(
                baseColor: AppColor.baseColor,
                highlightColor: AppColor.highlightColor,
                child: Container(
                  height: 100,
                  width: Get.width,
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(20), color: AppColor.black),
                ),
              ),
              // Month's Hot Test Section
              //  _buildSectionShimmer(title: EnumLocal.txtMonthHottest.name.tr, itemCount: 3),
              const SizedBox(height: 32),
              Shimmer.fromColors(
                baseColor: AppColor.baseColor,
                highlightColor: AppColor.highlightColor,
                child: Container(
                  width: 180,
                  height: 20,
                  color: AppColor.black,
                  margin: const EdgeInsets.only(bottom: 16),
                ),
              ),
              5.height,

              GridView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: 6,
                padding: const EdgeInsets.all(12),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, // 2 items per row
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio: 3 / 4, // Adjust for item shape
                ),
                itemBuilder: (context, index) {
                  return Shimmer.fromColors(
                    baseColor: AppColor.baseColor,
                    highlightColor: AppColor.highlightColor,
                    child: Container(
                      decoration: BoxDecoration(
                        color: AppColor.black,
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  );
                },
              )
            ],
          ),
        ),
      ],
    ));
  }
}
