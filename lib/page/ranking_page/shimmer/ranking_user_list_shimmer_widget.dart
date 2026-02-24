import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shimmer/shimmer.dart';
import 'package:tingle/utils/color.dart';
import 'package:tingle/utils/utils.dart';

class RankingUserListShimmerWidget extends StatelessWidget {
  const RankingUserListShimmerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: AppColor.baseColor,
      highlightColor: AppColor.highlightColor,
      child: ListView.builder(
        itemCount: 15,
        shrinkWrap: true,
        padding: EdgeInsets.only(top: 15, left: 15, right: 15),
        itemBuilder: (context, index) => Container(
          margin: const EdgeInsets.only(bottom: 15),
          padding: EdgeInsets.all(15),
          decoration: BoxDecoration(
            color: AppColor.black.withValues(alpha: 0.3),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: 30,
                width: 30,
                decoration: BoxDecoration(color: AppColor.black, borderRadius: BorderRadius.circular(100)),
              ),
              10.width,
              Container(
                height: 54,
                width: 54,
                decoration: const BoxDecoration(color: AppColor.black, shape: BoxShape.circle),
              ),
              10.width,
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 22,
                      margin: const EdgeInsets.only(bottom: 5),
                      decoration: BoxDecoration(color: AppColor.black, borderRadius: BorderRadius.circular(5)),
                    ),
                    Row(
                      children: [
                        Container(
                          height: 22,
                          width: 100,
                          margin: const EdgeInsets.only(bottom: 5),
                          decoration: BoxDecoration(color: AppColor.black, borderRadius: BorderRadius.circular(5)),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          height: 22,
                          width: 60,
                          decoration: BoxDecoration(color: AppColor.black, borderRadius: BorderRadius.circular(100)),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
