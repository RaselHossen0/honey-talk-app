import 'dart:async';
import 'dart:convert';
import 'dart:isolate';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:tingle/common/model/country_model.dart';
import 'package:tingle/utils/utils.dart';

class CountryService {
  static ScrollController scrollController = ScrollController();
  static RxBool isLoading = false.obs;
  static const _path = "assets/json/country_state_city.json";
  static RxList<CountryModel> countries = <CountryModel>[].obs;
  static RxList<CountryModel> jsonAllCountries = <CountryModel>[].obs;

  static const int itemsPerPage = 10;
  static int currentPage = 0;
  static bool hasMore = true;

  static ReceivePort? _receivePort;
  static Isolate? _isolate;

  static Future<void> init() async {
    try {
      scrollController = ScrollController();
      scrollController.addListener(onScroll);
    } catch (e) {
      Utils.showLog("Init County Failed !!");
    }
  }

  static void onScroll() async {
    if (scrollController.position.pixels == scrollController.position.maxScrollExtent) {
      onPagination();
    }
  }

  static Future<void> onGetCountries() async {
    try {
      isLoading.value = true;

      final jsonString = await rootBundle.loadString(_path);

      _receivePort = ReceivePort();
      _isolate = await Isolate.spawn(
        _parseCountriesInBackground,
        _IsolateData(_receivePort?.sendPort ?? ReceivePort().sendPort, jsonString),
      );

      _receivePort?.listen((message) {
        if (message is List<CountryModel>) {
          jsonAllCountries.value = message;
          Utils.showLog("Get Countries Success => ${jsonAllCountries.length}");
          initPagination();
        } else if (message is String) {
          Utils.showLog("Get Countries Failed => $message");
        }
        isLoading.value = false;
        _cleanUp();
      });
    } catch (e) {
      isLoading.value = false;
      Utils.showLog("Isolate setup failed => $e");
      _cleanUp();
    }
    init();
  }

  static void initPagination() {
    currentPage = 0;
    hasMore = true;
    countries.clear();
    onPagination();
  }

  static void onPagination() {
    if (!hasMore) return;

    final startIndex = currentPage * itemsPerPage;
    if (startIndex >= jsonAllCountries.length) {
      hasMore = false;
      return;
    }

    final endIndex = (startIndex + itemsPerPage).clamp(0, jsonAllCountries.length);
    final newCountries = jsonAllCountries.sublist(startIndex, endIndex);

    countries.addAll(newCountries);
    currentPage++;

    if (endIndex >= jsonAllCountries.length) {
      hasMore = false;
    }
  }

  @pragma('vm:entry-point')
  static void _parseCountriesInBackground(_IsolateData data) {
    try {
      final jsonData = json.decode(data.jsonString) as List;
      final countries = jsonData.map((e) => CountryModel.fromJson(e)).toList();
      data.sendPort.send(countries);
    } catch (e) {
      data.sendPort.send("Failed to parse countries: $e");
    }
  }

  static void _cleanUp() {
    _receivePort?.close();
    _isolate?.kill();
    _receivePort = null;
    _isolate = null;
  }
}

class _IsolateData {
  final SendPort sendPort;
  final String jsonString;

  _IsolateData(this.sendPort, this.jsonString);
}
