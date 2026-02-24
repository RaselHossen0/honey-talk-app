import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tingle/common/widget/no_data_found_widget.dart';
import 'package:tingle/page/stream_page/controller/stream_controller.dart';
import 'package:tingle/page/stream_page/shimmer/stream_gridview_shimmer_widget.dart';
import 'package:tingle/page/stream_page/widget/stream_tab_item_widget.dart';
import 'package:tingle/utils/color.dart';
import 'package:tingle/utils/constant.dart';

class StreamExploreTabWidget extends StatelessWidget {
  const StreamExploreTabWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<StreamController>(
      id: AppConstant.onGetExploreLiveUser,
      builder: (controller) => LayoutBuilder(
        builder: (context, box) {
          return RefreshIndicator(
            color: AppColor.primary,
            onRefresh: () => controller.onRefresh(),
            child: SingleChildScrollView(
              child: Container(
                height: box.minHeight + 1,
                color: Colors.transparent,
                child: RefreshIndicator(
                  color: AppColor.primary,
                  onRefresh: () => controller.onRefresh(),
                  child: SingleChildScrollView(
                    controller: controller.exploreScrollController,
                    padding: const EdgeInsets.only(bottom: 15),
                    child: controller.isLoadingExplore
                        ? StreamGridviewShimmerWidget()
                        : controller.exploreLiveUsers.isEmpty
                            ? SizedBox(
                                height: box.minHeight + 1,
                                child: Center(child: NoDataFoundWidget()),
                              )
                            : GridView.builder(
                                itemCount: controller.exploreLiveUsers.length,
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                padding: const EdgeInsets.symmetric(horizontal: 15),
                                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  crossAxisSpacing: 12,
                                  mainAxisSpacing: 12,
                                  mainAxisExtent: 226,
                                ),
                                itemBuilder: (context, index) {
                                  final indexData = controller.exploreLiveUsers[index];
                                  return StreamTabItemWidget(indexData: indexData);
                                },
                              ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
