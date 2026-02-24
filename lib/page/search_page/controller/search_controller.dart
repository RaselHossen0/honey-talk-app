import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:tingle/firebase/authentication/firebase_access_token.dart';
import 'package:tingle/firebase/authentication/firebase_uid.dart';
import 'package:tingle/page/search_page/api/search_user_api.dart';
import 'package:tingle/page/search_page/model/search_user_model.dart';
import 'package:tingle/utils/constant.dart';
import 'package:tingle/utils/database.dart';
import 'package:tingle/utils/utils.dart';

class SearchController extends GetxController {
  TextEditingController searchController = TextEditingController();

  bool isShowSearchHistory = false;

  // >>>> >>>> >>>> Search User <<<< <<<< <<<<
  bool isLoadingUser = false;
  SearchUserModel? searchUserModel;
  List<SearchUserData> searchUsers = [];
  List searchUserHistory = [];

  @override
  void onInit() async {
    init();
    super.onInit();
  }

  Future<void> init() async {
    onGetSearchUser();
    await onGetSearchHistory();
    searchUserHistory.isEmpty ? onChangeSearchHistory(false) : onChangeSearchHistory(true);
  }

  Future<void> onGetSearchUser() async {
    isLoadingUser = true;
    update([AppConstant.onGetSearchUser]);

    final uid = FirebaseUid.onGet() ?? "";
    final token = await FirebaseAccessToken.onGet() ?? "";

    searchUserModel = await SearchUserApi.callApi(token: token, uid: uid, searchText: searchController.text.trim());
    searchUsers = searchUserModel?.searchData ?? [];
    isLoadingUser = false;
    update([AppConstant.onGetSearchUser]);
  }

  Future<void> onChangeSearch() async {
    onGetSearchUser();
  }

  Future<void> onClearSearch() async {
    searchController.clear();
    onGetSearchUser();
    update([AppConstant.onGetSearchUser]);
  }

  void onChangeSearchHistory(bool value) {
    isShowSearchHistory = value;
    update([AppConstant.onChangeSearchHistory]);
  }

  // SET SEARCH USER HISTORY IN LOCAL DATABASE...

  Future<void> onGetSearchHistory() async {
    searchUserHistory.clear();
    searchUserHistory.addAll(Database.searchUserHistory);
    update([AppConstant.onChangeSearchHistory]);
    Utils.showLog("Get Database Search History => ${searchUserHistory.length}");
  }

  void onCreateSearchHistory(String value) {
    if (value != "") {
      if (searchUserHistory.contains(value)) {
        searchUserHistory.remove(value);
        searchUserHistory.insert(0, value);
      } else {
        searchUserHistory.add(value);
      }
      Database.onSetSearchUserHistory(searchUserHistory); // Add In Database
    }
    Utils.showLog("Add Database Search History => $value");
  }

  void onVisitProfile(String userId) async {}

  void onClearSearchHistory() {
    searchUserHistory.clear();
    Database.onSetSearchUserHistory(searchUserHistory); // Reset Database
    update([AppConstant.onChangeSearchHistory]);
    Utils.showLog("Delete Database Search History");
  }

  Future<void> onClickSearchHistory(String value) async {
    isShowSearchHistory = false;
    searchController.text = value;

    onGetSearchUser();
    update([AppConstant.onChangeSearchHistory]);
  }
}
