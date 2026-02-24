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

class PartyPartyTabWidget extends GetView<PartyController> {
  const PartyPartyTabWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, box) {
        return GetBuilder<PartyController>(
          id: AppConstant.onGetPartyLiveUser,
          builder: (controller) => controller.isLoadingParty
              ? PartyItemShimmerWidget()
              : RefreshIndicator(
                  color: AppColor.primary,
                  onRefresh: () async => await controller.onRefresh(delay: 0),
                  child: controller.partyLiveUsers.isEmpty
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
                              controller: controller.partyScrollController,
                              child: ListView.builder(
                                itemCount: controller.partyLiveUsers.length,
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                padding: const EdgeInsets.symmetric(horizontal: 15),
                                itemBuilder: (context, index) {
                                  final indexData = controller.partyLiveUsers[index];
                                  return indexData.isFake == true
                                      ? GestureDetector(
                                          onTap: () => onClickFakeAudioRoom(
                                                indexData: indexData,
                                                callback: () => controller.onRefresh(delay: 0),
                                              ),
                                          child: FakePartyItemWidget(
                                            liveUser: indexData,
                                          ))
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
