import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:tingle/utils/color.dart';

class ThemeOutfitShimmerWidget extends StatelessWidget {
  const ThemeOutfitShimmerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Padding(
      padding: const EdgeInsets.all(16),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Shimmer.fromColors(
              baseColor: AppColor.baseColor,
              highlightColor: AppColor.highlightColor,
              child: Container(
                height: 32,
                width: 120,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Active Avatar Frame Box
            buildShimmerBox(width),
            const SizedBox(height: 24),

            // Expired Frame Title
            ShimmerBox(height: 30, width: 180),

            const SizedBox(height: 24),

            // Empty state icon
            buildShimmerBox(width),
            const SizedBox(height: 12),
            buildShimmerBox(width),
            const SizedBox(height: 12),
            buildShimmerBox(width),
            const SizedBox(height: 24),

            // Bottom Buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(child: ShimmerBox(height: 48, width: double.infinity, borderRadius: 30)),
                const SizedBox(width: 16),
                Expanded(child: ShimmerBox(height: 48, width: double.infinity, borderRadius: 30)),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildShimmerBox(double width) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.deepPurple.shade100),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          ShimmerBox(height: 60, width: 60, borderRadius: 30),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ShimmerBox(height: 16, width: width * 0.4),
                const SizedBox(height: 8),
                ShimmerBox(height: 14, width: width * 0.5),
              ],
            ),
          ),
          const SizedBox(width: 8),
          ShimmerBox(height: 24, width: 50, borderRadius: 12),
        ],
      ),
    );
  }
}

class ShimmerBox extends StatelessWidget {
  final double height;
  final double width;
  final double borderRadius;

  const ShimmerBox({
    super.key,
    required this.height,
    required this.width,
    this.borderRadius = 8,
  });

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: AppColor.baseColor,
      highlightColor: AppColor.highlightColor,
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(borderRadius),
        ),
      ),
    );
  }
}
