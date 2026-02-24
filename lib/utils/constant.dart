import 'dart:io';

abstract class AppConstant {
  static const String languageEn = "en";
  static const String countryCodeEn = "US";

  static const String appFontLight = "InterLight";
  static const String appFontRegular = "InterRegular";
  static const String appFontMedium = "InterMedium";
  static const String appFontSemiBold = "InterSemiBold";
  static const String appFontBold = "InterBold";
  static const String appFontExtraBold = "InterExtraBold";

  static int bottomBarSize = Platform.isAndroid ? 65 : 80;

  // >>>>> >>>>> >>>>> BOTTOM BAR PAGE <<<<< <<<<< <<<<<
  static const String onChangeBottomBar = "onChangeBottomBar";

  // >>>>> >>>>> >>>>> FILL PROFILE PAGE <<<<< <<<<< <<<<<
  static const String onChangeGender = "onChangeGender";
  static const String onPickImage = "onPickImage";

  // >>>>> >>>>> >>>>> STEAM PAGE <<<<< <<<<< <<<<<
  static const String onChangePkType = "onChangePkType";
  static const String onChangeStreamTabs = "onChangeStreamTabs";

  // >>>>> >>>>> >>>>> PARTY PAGE <<<<< <<<<< <<<<<
  static const String onChangePartyType = "onChangePartyType";

  // >>>>> >>>>> >>>>> FEED PAGE <<<<< <<<<< <<<<<
  static const String onChangeTab = "onChangeTab";
  static const String onChangeFeedType = "onChangeFeedType";

  // >>>>> >>>>> >>>>> FEED PAGE <<<<< <<<<< <<<<<
  static const String onPagination = "onPagination";
  static const String onGetMoment = "onGetAllPost";
  static const String onChangeMessageType = "onChangeMessageType";
  static const String onChangeCountry = "onChangeCountry";
  static const String onToggleUploadButton = "onToggleUploadButton";
  static const String onChangeHashtag = "onChangeHashtag";
  static const String onGetTopics = "onGetTopics";
  static const String onGetFollowPost = "onGetFollowPost";
  static const String onMomentPagination = "onMomentPagination";
  static const String onGetFriend = "onGetFriend";
  static const String onGetPopularHashtag = "onGetPopularHashtag";

  // >>>>> >>>>> >>>>> PROFILE PAGE <<<<< <<<<< <<<<<
  static const String onGetProfile = "onGetProfile";

  // >>>>> >>>>> >>>>> Upload Feed PAGE <<<<< <<<<< <<<<<
  static const String onChangeImages = "onChangeImages";
  static const String onToggleHashtag = "onToggleHashtag";
  static const String onFriendPagination = "onFriendPagination";

  // >>>>> >>>>> >>>>> SEARCH PAGE <<<<< <<<<< <<<<<
  static const String onGetSearchUser = "onGetSearchUser";

  // >>>>> >>>>> >>>>> AUDIO ROOM PAGE <<<<< <<<<< <<<<<
  static const String onChangeCommentTab = "onChangeCommentTab";
  static const String onChangeTextField = "onChangeTextField";

  // >>>>> >>>>> >>>>> VIDEO PAGE <<<<< <<<<< <<<<<
  static const String onShowPlayPauseIcon = "onShowPlayPauseIcon";
  static const String onChangePlayPauseIcon = "onChangePlayPauseIcon";
  static const String onChangeLoading = "onChangeLoading";
  static const String onChangePage = "onChangePage";
  static const String onGetVideo = "onGetVideo";

  // >>>>> >>>>> >>>>> UPLOAD VIDEO PAGE <<<<< <<<<< <<<<<
  static const String onChangeThumbnail = "onChangeThumbnail";

  // >>>>> >>>>> >>>>> CHAT PAGE <<<<< <<<<< <<<<<
  static const String onPaginationMessageUser = "onPaginationMessageUser";
  static const String onFetchMessageUser = "onFetchMessageUser";
  static const String onFetchUserChat = "onFetchUserChat";
  static const String onPaginationUserChat = "onPaginationUserChat";

  // >>>>> >>>>> >>>>> CHAT PAGE <<<<< <<<<< <<<<<
  static const String onEventHandler = "onEventHandler";
  static const String onClickVideo = "onClickVideo";
  static const String onClickMic = "onClickMic";
  static const String onClickCamera = "onClickCamera";
  static const String onInitializeCamera = "onInitializeCamera";
  static const String onChangeTime = "onChangeTime";
  static const String onChangeLiveTime = "onChangeLiveTime";
  static const String onChangePkTime = "onChangePkTime";

  static const String onChangeSearchHistory = "onChangeSearchHistory";
  static const String onToggleAppBar = "onToggleAppBar";

  static const String onGetFeed = "onGetFeed";
  static const String onFetchPost = "onFetchPost";
  static const String onFetchVideo = "onFetchVideo";
  static const String onGetCoinPlan = "onGetCoinPlan";
  static const String onChangePayment = "onChangePayment";
  static const String onToggleAgreement = "onToggleAgreement";
  static const String onGetCoinHistory = "onGetCoinHistory";
  static const String onChangeDate = "onChangeDate";
  static const String onUpdateCoin = "onUpdateCoin";

  static const String onSwitchMic = "onSwitchMic";
  static const String onChangeViewCount = "onChangeViewCount";
  static const String onSwitchFlash = "onSwitchFlash";
  static const String onChangeLiveType = "onChangeLiveType";
  static const String onGetLiveUser = "onGetLiveUser";
  static const String onChangeComment = "onChangeComment";
  static const String onChanged = "onChanged";
  static const String onSeatUpdate = "onSeatUpdate";
  static const String onUpdateParticularSeat = "onUpdateParticularSeat";
  static const String onChangeUserBlockList = "onChangeUserBlockList";
  static const String onSeatUserUpdate = "onSeatUserUpdate";
  static const String onToggleComment = "onToggleComment";
  static const String onClickFollow = "onClickFollow";
  static const String onChangeRank = "onChangeRank";
  static const String onGetExploreLiveUser = "onGetExploreLiveUser";
  static const String onGetPartyLiveUser = "onGetPartyLiveUser";

  static const String onTabBarTap = "onTabBarTap";
  static const String onSearchConnection = "onSearchConnection";
  static const String onSelectTheme = "onSelectTheme";
  static const String onChangeRoomType = "onChangeRoomType";
  static const String onChangeRichTabBar = "onChangeRichTabBar";
  static const String onChangeFollowUpdate = "onChangeFollowUpdate";
  static const String onChangeGiftTabBar = "onChangeGiftTabBar";
  static const String onGiftFilter = "onGiftFilter";
  static const String onChangeTabBar = "onChangeTabBar";
  static const String postId = "postId";
  static const String onChangeTheme = "onChangeTheme";
  static const String onGetNewLiveUser = "onGetNewLiveUser";
  static const String onGetPkLiveUser = "onGetPkLiveUser";
  static const String onGetFollowLiveUser = "onGetFollowLiveUser";
  static const String onUpdateTopGiftUser = "onUpdateTopGiftUser";
}
