import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tingle/common/widget/no_data_found_widget.dart';
import 'package:tingle/page/party_page/controller/party_controller.dart';
import 'package:tingle/page/party_page/shimmer/party_item_shimmer_widget.dart';
import 'package:tingle/page/party_page/widget/fake_party_item_widget.dart';
import 'package:tingle/page/party_page/widget/party_item_widget.dart';
import 'package:tingle/page/stream_page/widget/stream_tab_item_widget.dart';
import 'package:tingle/utils/color.dart';
import 'package:tingle/utils/constant.dart';

class PartyFollowTabWidget extends GetView<PartyController> {
  const PartyFollowTabWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, box) {
        return GetBuilder<PartyController>(
          id: AppConstant.onGetFollowLiveUser,
          builder: (controller) => controller.isLoadingFollow
              ? PartyItemShimmerWidget()
              : RefreshIndicator(
                  color: AppColor.primary,
                  onRefresh: () async => await controller.onRefresh(delay: 0),
                  child: controller.followLiveUsers.isEmpty
                      ? Center(
                          child: SingleChildScrollView(
                            child: SizedBox(
                              height: box.maxHeight + 1,
                              child: NoDataFoundWidget(),
                            ),
                          ),
                        )
                      : SingleChildScrollView(
                          child: SizedBox(
                            height: box.maxHeight + 1,
                            child: SingleChildScrollView(
                              controller: controller.followScrollController,
                              child: ListView.builder(
                                itemCount: controller.followLiveUsers.length,
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                padding: const EdgeInsets.symmetric(horizontal: 15),
                                itemBuilder: (context, index) {
                                  final indexData = controller.followLiveUsers[index];
                                  return indexData.isFake == true
                                      ? GestureDetector(
                                          onTap: () => onClickFakeAudioRoom(
                                            indexData: indexData,
                                            callback: () => controller.onRefresh(delay: 0),
                                          ),
                                          child: FakePartyItemWidget(liveUser: indexData),
                                        )
                                      : GestureDetector(
                                          onTap: () => onClickAudioRoom(
                                            indexData: indexData,
                                            callback: () => controller.onRefresh(delay: 1000),
                                          ),
                                          child: PartyItemWidget(liveUser: indexData),
                                        );
                                },
                              ),
                            ),
                          ),
                        ),
                ),
        );
      },
    );
  }
}
