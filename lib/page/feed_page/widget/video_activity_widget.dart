import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:tingle/utils/assets.dart';
import 'package:tingle/utils/color.dart';
import 'package:tingle/utils/enums.dart';
import 'package:tingle/utils/font_style.dart';
import 'package:tingle/utils/utils.dart';

class VideoActivityWidget extends StatelessWidget {
  const VideoActivityWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          EnumLocal.txtVideoActivity.name.tr,
          style: AppFontStyle.styleW700(AppColor.black, 18),
        ),
        12.height,
        SizedBox(
          height: 50,
          child: Row(
            children: [
              const Expanded(
                child: ActivityItemWidget(
                  image: "https://img.freepik.com/premium-photo/colorful-video-game-is-shown-with-purple-blue-background_1020200-11995.jpg?semt=ais_hybrid",
                  count: 2560,
                  isMoreButton: false,
                ),
              ),
              12.width,
              const Expanded(
                child: ActivityItemWidget(
                  image:
                      "https://media.istockphoto.com/id/1809656344/photo/gameplay-of-a-racing-simulator-video-game-with-interface-computer-generated-3d-car-driving.jpg?s=612x612&w=0&k=20&c=4zCHqOOE3GcTMyVH37rSN7hDz6_u_vFeZm2WwWu8WCg=",
                  count: 2560,
                  isMoreButton: false,
                ),
              ),
              12.width,
              const Expanded(
                child: ActivityItemWidget(
                  image: "https://cdn.pixabay.com/photo/2019/02/06/10/11/play-3978841_1280.jpg",
                  count: 2560,
                  isMoreButton: true,
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}

class ActivityItemWidget extends StatelessWidget {
  const ActivityItemWidget({
    super.key,
    required this.image,
    required this.count,
    required this.isMoreButton,
  });

  final String image;
  final int count;
  final bool isMoreButton;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: 120,
      decoration: BoxDecoration(
        border: Border.all(color: AppColor.white),
        borderRadius: BorderRadius.circular(100),
      ),
      child: Container(
        height: 50,
        width: 120,
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
        ),
        child: Stack(
          clipBehavior: Clip.antiAlias,
          alignment: Alignment.center,
          children: [
            ImageFiltered(
              imageFilter: ColorFilter.mode(
                AppColor.black.withValues(alpha: 0.3),
                BlendMode.colorBurn,
              ),
              child: Image.network(
                height: 50,
                width: 120,
                image,
                fit: BoxFit.cover,
              ),
            ),
            isMoreButton
                ? Positioned(
                    left: 15,
                    child: Text(
                      "More\nView Now >>",
                      style: AppFontStyle.styleW800(AppColor.white, 12),
                    ),
                  )
                : SizedBox.expand(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            AppAssets.icFire,
                            width: 14,
                          ),
                          5.width,
                          Text(
                            count.toString(),
                            style: AppFontStyle.styleW700(AppColor.white, 14),
                          ),
                        ],
                      ),
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
