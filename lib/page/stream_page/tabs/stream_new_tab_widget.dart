import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tingle/common/widget/no_data_found_widget.dart';
import 'package:tingle/page/stream_page/controller/stream_controller.dart';
import 'package:tingle/page/stream_page/shimmer/stream_gridview_shimmer_widget.dart';
import 'package:tingle/page/stream_page/widget/stream_tab_item_widget.dart';
import 'package:tingle/utils/color.dart';
import 'package:tingle/utils/constant.dart';

class StreamNewTabWidget extends StatelessWidget {
  const StreamNewTabWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<StreamController>(
      id: AppConstant.onGetNewLiveUser,
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
                    controller: controller.newScrollController,
                    padding: const EdgeInsets.only(bottom: 15),
                    child: controller.isLoadingNew
                        ? StreamGridviewShimmerWidget()
                        : controller.newLiveUsers.isEmpty
                            ? SizedBox(
                                height: box.minHeight + 1,
                                child: Center(child: NoDataFoundWidget()),
                              )
                            : GridView.builder(
                                itemCount: controller.newLiveUsers.length,
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
                                  final indexData = controller.newLiveUsers[index];
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
