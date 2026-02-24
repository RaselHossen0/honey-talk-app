import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';
import 'package:tingle/page/backpack_page/model/fetch_purchased_model.dart';
import 'package:tingle/utils/assets.dart';
import 'package:tingle/utils/color.dart';
import 'package:tingle/utils/enums.dart';
import 'package:tingle/utils/font_style.dart';
import 'package:tingle/utils/utils.dart';

class NetworkFrameWidget extends StatelessWidget {
  final int ownedCount;
  final AvatarFrames? frameAssets;
  final String title;
  final String itemType;
  final Callback callback;

  const NetworkFrameWidget({
    super.key,
    required this.ownedCount,
    required this.frameAssets,
    required this.title,
    required this.itemType,
    required this.callback,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: callback,
      child: Container(
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: AppFontStyle.styleW600(AppColor.black, 14),
                ),
                Row(
                  children: [
                    Text(
                      ownedCount == 0 ? EnumLocal.txtNotYetOwned.name.tr : "${EnumLocal.txtOwn.name.tr} $ownedCount",
                      style: AppFontStyle.styleW600(AppColor.secondary, 10),
                    ),
                    5.width,
                    Image.asset(AppAssets.icArrowRight, width: 5, color: AppColor.secondary),
                  ],
                )
              ],
            ),
            8.height,
            ownedCount == 0
                ? SizedBox(
                    height: 70,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: 4,
                      itemBuilder: (context, index) {
                        return Container(
                          width: 75,
                          height: 75,
                          clipBehavior: Clip.antiAlias,
                          margin: EdgeInsets.only(right: 12),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Image.asset(
                            width: 75,
                            height: 75,
                            AppAssets.icFrameIcon,
                            fit: BoxFit.cover,
                          ),
                        );
                      },
                    ),
                  )
                : SizedBox(
                    height: 70,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: frameAssets?.active?.length ?? 0,
                      itemBuilder: (context, index) {
                        return Container(
                            width: 75,
                            height: 75,
                            margin: EdgeInsets.only(right: 12),
                            decoration: BoxDecoration(
                              color: AppColor.lightGray,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Image.asset(frameAssets?.active?[index].image ?? "")
                            // CustomSVGAFrameWidget(
                            //   type: frameAssets?.active?[index].type ?? 1,
                            //   itemType: itemType,
                            //   imagePath: frameAssets?.active?[index].image ?? "",
                            //   framePath: frameAssets?.active?[index].svgaImage,
                            //   svgapadding: EdgeInsets.all(8),
                            //   borderRadius: BorderRadius.circular(12),
                            // ),
                            );
                      },
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
