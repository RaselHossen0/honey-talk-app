import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tingle/common/api/fetch_setting_api.dart';
import 'package:tingle/page/my_chat_price_page/api/fetch_my_chat_price_api.dart';
import 'package:tingle/page/my_chat_price_page/model/fetch_my_chat_price_model.dart';
import 'package:tingle/utils/constant.dart';
import 'package:tingle/utils/enums.dart';

class MyChatPriceController extends GetxController {
  bool isLoading = true;
  FetchMyChatPriceModel? fetchMyChatPriceModel;

  int get videoCallPricePerMin =>
      fetchMyChatPriceModel?.data?.videoCallPricePerMin ??
      FetchSettingApi.fetchSettingModel?.data?.privateCallRate ??
      300;

  List<LevelPriceTier> get highestCallPriceTiers =>
      fetchMyChatPriceModel?.data?.highestCallPriceTiers ?? [];

  @override
  void onInit() {
    init();
    super.onInit();
  }

  Future<void> init() async {
    isLoading = true;
    update([AppConstant.onGetFeed]);
    fetchMyChatPriceModel = await FetchMyChatPriceApi.callApi();
    isLoading = false;
    update([AppConstant.onGetFeed]);
  }

  List<int> get availablePriceOptions =>
      fetchMyChatPriceModel?.data?.availablePriceOptions ?? [1750, 2450, 2800, 3500, 3850, 4200, 5000];

  int get priceRaiseCountThisWeek => fetchMyChatPriceModel?.data?.priceRaiseCountThisWeek ?? 0;
  int get priceRaiseOpportunitiesPerWeek =>
      fetchMyChatPriceModel?.data?.priceRaiseOpportunitiesPerWeek ?? 2;

  bool get canRaisePrice => priceRaiseCountThisWeek < priceRaiseOpportunitiesPerWeek;

  Future<void> onUpdatePrice(int newPrice) async {
    final data = fetchMyChatPriceModel?.data;
    if (data == null) return;

    final isRaise = newPrice > videoCallPricePerMin;
    final newRaiseCount = isRaise ? priceRaiseCountThisWeek + 1 : priceRaiseCountThisWeek;

    fetchMyChatPriceModel = FetchMyChatPriceModel(
      status: true,
      message: "Updated",
      data: MyChatPriceData(
        videoCallPricePerMin: newPrice,
        userLevel: data.userLevel,
        highestCallPriceTiers: data.highestCallPriceTiers,
        availablePriceOptions: data.availablePriceOptions,
        defaultNewHostPrice: data.defaultNewHostPrice,
        freeCallEarning: data.freeCallEarning,
        priceRaiseCountThisWeek: newRaiseCount,
        priceRaiseOpportunitiesPerWeek: data.priceRaiseOpportunitiesPerWeek,
      ),
    );
    update([AppConstant.onGetFeed]);
  }

  void onEditPrice(BuildContext context) {
    Get.bottomSheet(
      _PricePickerBottomSheet(
        currentPrice: videoCallPricePerMin,
        options: availablePriceOptions,
        canRaise: canRaisePrice,
        onConfirm: (price) {
          onUpdatePrice(price);
          Get.back();
        },
        onCancel: () => Get.back(),
      ),
      isScrollControlled: true,
    );
  }
}

class _PricePickerBottomSheet extends StatefulWidget {
  final int currentPrice;
  final List<int> options;
  final bool canRaise;
  final ValueChanged<int> onConfirm;
  final VoidCallback onCancel;

  const _PricePickerBottomSheet({
    required this.currentPrice,
    required this.options,
    required this.canRaise,
    required this.onConfirm,
    required this.onCancel,
  });

  @override
  State<_PricePickerBottomSheet> createState() => _PricePickerBottomSheetState();
}

class _PricePickerBottomSheetState extends State<_PricePickerBottomSheet> {
  late int _selectedPrice;

  @override
  void initState() {
    super.initState();
    _selectedPrice = widget.currentPrice;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewPadding.bottom),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 8),
          Container(
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(height: 16),
          Text(
            EnumLocal.txtEditVideoCallPrice.name.tr,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 16),
          Flexible(
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: widget.options.length,
              itemBuilder: (context, i) {
                final price = widget.options[i];
                final isSelected = price == _selectedPrice;
                final isRaise = price > widget.currentPrice;
                final disabled = isRaise && !widget.canRaise;
                return ListTile(
                  title: Text(
                    "$price Bonus/min",
                    style: TextStyle(
                      fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                      color: disabled ? Colors.grey : null,
                    ),
                  ),
                  enabled: !disabled,
                  onTap: disabled
                      ? null
                      : () => setState(() => _selectedPrice = price),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Expanded(
                  child: TextButton(
                    onPressed: widget.onCancel,
                    child: Text(EnumLocal.txtCancel.name.tr),
                  ),
                ),
                Expanded(
                  child: TextButton(
                    onPressed: () => widget.onConfirm(_selectedPrice),
                    child: Text(EnumLocal.txtConfirm.name.tr),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
