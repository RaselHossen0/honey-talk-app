import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:flutter/widgets.dart';
import 'package:tingle/utils/color.dart';

class CountryTabShimmerWidget extends StatelessWidget {
  const CountryTabShimmerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: 10,
      padding: EdgeInsets.zero,
      scrollDirection: Axis.horizontal,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        return Shimmer.fromColors(
          baseColor: AppColor.baseColor,
          highlightColor: AppColor.highlightColor,
          child: Container(
            height: 35,
            width: 130,
            margin: EdgeInsets.only(right: 10, bottom: 1),
            decoration: BoxDecoration(
              color: AppColor.black,
              borderRadius: BorderRadius.circular(100),
            ),
          ),
        );
      },
    );
  }
}
