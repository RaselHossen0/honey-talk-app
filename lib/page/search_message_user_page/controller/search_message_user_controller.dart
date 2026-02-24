import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tingle/firebase/authentication/firebase_access_token.dart';
import 'package:tingle/firebase/authentication/firebase_uid.dart';
import 'package:tingle/page/search_message_user_page/api/fetch_search_message_user_api.dart';
import 'package:tingle/page/search_message_user_page/model/fetch_search_message_user_model.dart';
import 'package:tingle/utils/constant.dart';

class SearchMessageUserController extends GetxController {
  ScrollController scrollController = ScrollController();

  TextEditingController searchController = TextEditingController();

  bool isLoading = false;
  FetchSearchMessageUserModel? fetchSearchMessageUserModel;
  List<Data> messageUsers = [];

  @override
  void onInit() {
    onFetchMessageUser();
    super.onInit();
  }

  Future<void> onFetchMessageUser() async {
    isLoading = true;
    update([AppConstant.onFetchMessageUser]);

    final uid = FirebaseUid.onGet() ?? "";
    final token = await FirebaseAccessToken.onGet() ?? "";

    fetchSearchMessageUserModel = await FetchSearchMessageUserApi.callApi(uid: uid, token: token, searchString: searchController.text.trim());
    messageUsers.clear();
    messageUsers.addAll(fetchSearchMessageUserModel?.data ?? []);

    isLoading = false;
    update([AppConstant.onFetchMessageUser]);
  }

  Future<void> onChangeSearch() async {
    onFetchMessageUser();
  }

  Future<void> onClearSearch() async {
    searchController.clear();
    onFetchMessageUser();
    update([AppConstant.onFetchMessageUser]);
  }
}
