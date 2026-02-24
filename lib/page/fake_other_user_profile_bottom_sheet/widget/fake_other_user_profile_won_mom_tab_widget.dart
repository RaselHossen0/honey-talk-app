import 'package:flutter/material.dart';
import 'package:tingle/common/widget/loading_widget.dart';
import 'package:tingle/common/widget/no_data_found_widget.dart';
import 'package:tingle/common/widget/preview_network_image_widget.dart';
import 'package:tingle/page/feed_video_page/model/fetch_video_model.dart';

import 'package:tingle/utils/assets.dart';
import 'package:tingle/utils/color.dart';
import 'package:tingle/utils/font_style.dart';
import 'package:tingle/utils/utils.dart';

class FakeOtherUserProfileWonMomTabWidget extends StatelessWidget {
  final List<VideoData> userVideos;
  final bool isLoadingVideo;
  final Function(int) onClickVideo;

  const FakeOtherUserProfileWonMomTabWidget({
    super.key,
    required this.userVideos,
    required this.isLoadingVideo,
    required this.onClickVideo,
  });

  @override
  Widget build(BuildContext context) {
    if (isLoadingVideo) {
      return const LoadingWidget();
    }

    if (userVideos.isEmpty) {
      return const NoDataFoundWidget();
    }

    return GridView.builder(
      shrinkWrap: true,
      itemCount: userVideos.length,
      padding: const EdgeInsets.symmetric(horizontal: 15),
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        childAspectRatio: 0.75,
      ),
      itemBuilder: (context, index) {
        final indexData = userVideos[index];
        return GestureDetector(
          onTap: () => onClickVideo(index),
          child: Container(
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(
              color: AppColor.colorBorder.withValues(alpha: 0.5),
              borderRadius: BorderRadius.circular(15),
            ),
            child: LayoutBuilder(builder: (context, box) {
              return Stack(
                fit: StackFit.expand,
                alignment: Alignment.bottomRight,
                children: [
                  PreviewPostImageWidget(
                    size: 50,
                    image: indexData.videoImage ?? "",
                    isBanned: indexData.isProfilePicBanned,
                    fit: BoxFit.cover,
                  ),
                  Positioned(
                    bottom: -3,
                    left: 0,
                    child: Container(
                      height: 35,
                      width: box.maxWidth,
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(14),
                          bottomRight: Radius.circular(14),
                        ),
                        gradient: LinearGradient(
                          colors: [AppColor.transparent, AppColor.black.withValues(alpha: 0.6)],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Image.asset(
                              AppAssets.icLikeFill,
                              width: 12,
                              color: AppColor.white,
                            ),
                            5.width,
                            Text(
                              "10M",
                              style: AppFontStyle.styleW600(AppColor.white, 10),
                            ),
                            8.width,
                            Image.asset(AppAssets.icCommentFill, width: 12),
                            5.width,
                            Text(
                              "50k",
                              style: AppFontStyle.styleW600(AppColor.white, 10),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              );
            }),
          ),
        );
      },
    );
  }
}
