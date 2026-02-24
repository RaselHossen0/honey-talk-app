import 'dart:isolate';
import 'package:tingle/common/model/fetch_gift_category_model.dart';
import 'package:tingle/utils/utils.dart';
import 'dart:async';

class FetchGiftCategoryApi {
  static List<GiftData> giftCategory = [];

  static Future<void> onGetGiftCategory() async {
    var receivePort = ReceivePort();

    receivePort.listen(
      (message) {
        List<GiftData> receivedCategory = (message as List).map((e) => GiftData.fromJson(e)).toList();
        giftCategory = receivedCategory;
        Utils.showLog("Gift Category Length => ${giftCategory.length}");
      },
    );

    // Simulate values
    String uid = "dummyUid123";
    String token = "dummyToken123";

    Map<String, dynamic> parameterMap = {
      "sendPort": receivePort.sendPort,
      "token": token,
      "uid": uid,
    };

    await Future.delayed(Duration(milliseconds: 500));
    await onFetchGiftCategoryIsolate(parameterMap);
  }

  @pragma('vm:entry-point')
  static Future<void> onFetchGiftCategoryIsolate(Map<String, dynamic> parameterMap) async {
    FetchGiftCategoryModel fetchGiftCategoryModel = await callApi(
          token: parameterMap["token"],
          uid: parameterMap["uid"],
        ) ??
        FetchGiftCategoryModel(status: true, message: "Success", data: []);

    List<GiftData> category = fetchGiftCategoryModel.data ?? [];

    SendPort sendPort = parameterMap["sendPort"];
    sendPort.send(category.map((e) => e.toJson()).toList());
  }

  static Future<FetchGiftCategoryModel?> callApi({
    required String token,
    required String uid,
  }) async {
    Utils.showLog("Mock Fetch Gift Category API Called...");

    await Future.delayed(const Duration(milliseconds: 100)); // Simulate API delay

    List<GiftData> dummyGiftCategories = [
      GiftData(id: "1", name: "Popular Gifts"),
      GiftData(id: "2", name: "Love Gifts"),
      GiftData(id: "3", name: "Fun Gifts"),
      GiftData(id: "4", name: "Premium Gifts"),
      GiftData(id: "5", name: "Birthday Gifts"),
    ];

    return FetchGiftCategoryModel(
      status: true,
      message: "Gift Categories fetched successfully",
      data: dummyGiftCategories,
    );
  }
}

// TODO => FETCH CATEGORY IN BACKGROUND CODE
//
// import 'dart:convert';
// import 'dart:isolate';
// import 'package:flutter_isolate/flutter_isolate.dart';
// import 'package:http/http.dart' as http;
// import 'package:tingle/common/model/fetch_gift_category_model.dart';
// import 'package:tingle/firebase/authentication/firebase_access_token.dart';
// import 'package:tingle/firebase/authentication/firebase_uid.dart';
// import 'package:tingle/utils/api.dart';
// import 'package:tingle/utils/api_params.dart';
// import 'package:tingle/utils/utils.dart';
//
// class FetchGiftCategoryApi {
//   static FetchGiftCategoryModel? fetchGiftCategoryModel;
//   static List<Data> giftCategory = [];
//
//   static Future<void> onGetGiftCategory() async {
//     var receivePort = ReceivePort();
//
//     receivePort.listen(
//           (message) {
//         List<Data> receivedCategory = (message as List).map((e) => Data.fromJson(e)).toList();
//         giftCategory = receivedCategory;
//         Utils.showLog("Gift Category Length => ${giftCategory.length}");
//       },
//     );
//
//     final uid = FirebaseUid.onGet() ?? "";
//     final token = await FirebaseAccessToken.onGet() ?? "";
//
//     Map<String, dynamic> parameterMap = {
//       ApiParams.sendPort: receivePort.sendPort,
//       ApiParams.token: token,
//       ApiParams.uid: uid,
//     };
//
//     await FlutterIsolate.spawn(onFetchGiftCategoryIsolate, parameterMap);
//   }
//
//   @pragma('vm:entry-point')
//   static Future<void> onFetchGiftCategoryIsolate(Map<String, dynamic> parameterMap) async {
//     fetchGiftCategoryModel = await callApi(token: parameterMap[ApiParams.token], uid: parameterMap[ApiParams.uid]);
//
//     List<Data> category = fetchGiftCategoryModel?.data ?? [];
//
//     SendPort sendPort = parameterMap[ApiParams.sendPort];
//
//     sendPort.send(category.map((e) => e.toJson()).toList());
//   }
//
//   static Future<FetchGiftCategoryModel?> callApi({
//     required String token,
//     required String uid,
//   }) async {
//     Utils.showLog("Fetch Gift Category Api Calling...");
//
//     final uri = Uri.parse(Api.fetchGiftCategories);
//
//     Utils.showLog("Fetch Gift Category Api Url => $uri");
//
//     final headers = {ApiParams.key: Api.secretKey, ApiParams.tokenKey: ApiParams.tokenStartPoint + token, ApiParams.uidKey: uid};
//
//     try {
//       final response = await http.get(uri, headers: headers);
//
//       Utils.showLog("Fetch Gift Category Api Response => ${response.body}");
//
//       if (response.statusCode == 200) {
//         final jsonResponse = json.decode(response.body);
//
//         return FetchGiftCategoryModel.fromJson(jsonResponse);
//       } else {
//         Utils.showLog("Fetch Gift Category Api StateCode Error");
//       }
//     } catch (error) {
//       Utils.showLog("Fetch Gift Category Api Error => $error");
//     }
//     return null;
//   }
// }
