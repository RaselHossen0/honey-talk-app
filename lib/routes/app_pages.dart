import 'package:get/get.dart';
import 'package:tingle/page/audio_room_page/binding/audio_room_binding.dart';
import 'package:tingle/page/audio_room_page/view/audio_room_view.dart';
import 'package:tingle/page/audio_wise_videos_page/binding/audio_wise_videos_binding.dart';
import 'package:tingle/page/audio_wise_videos_page/view/audio_wise_videos_view.dart';
import 'package:tingle/page/backpack_page/binding/backpack_binding.dart';
import 'package:tingle/page/backpack_page/view/backpack_page.dart';
import 'package:tingle/page/bottom_bar_page/binding/bottom_bar_binding.dart';
import 'package:tingle/page/bottom_bar_page/view/bottom_bar_view.dart';
import 'package:tingle/page/chat_page/binding/chat_binding.dart';
import 'package:tingle/page/chat_page/view/chat_view.dart';
import 'package:tingle/page/coin_history_page/binding/coin_history_binding.dart';
import 'package:tingle/page/coin_history_page/view/coin_history_view.dart';
import 'package:tingle/page/connection_page/binding/Search_connection_binding.dart';
import 'package:tingle/page/connection_page/binding/connection_binding.dart';
import 'package:tingle/page/connection_page/view/connection_search_view.dart';
import 'package:tingle/page/connection_page/view/connection_view.dart';
import 'package:tingle/page/create_audio_room_page/binding/create_audio_room_binding.dart';
import 'package:tingle/page/create_audio_room_page/view/create_audio_room_view.dart';
import 'package:tingle/page/create_reels_page/binding/create_reels_binding.dart';
import 'package:tingle/page/create_reels_page/view/create_reels_view.dart';
import 'package:tingle/page/edit_feed_page/binding/edit_feed_binding.dart';
import 'package:tingle/page/edit_feed_page/view/edit_feed_view.dart';
import 'package:tingle/page/edit_profile_page/binding/edit_profile_binding.dart';
import 'package:tingle/page/edit_profile_page/view/edit_profile_view.dart';
import 'package:tingle/page/edit_video_page/binding/edit_video_binding.dart';
import 'package:tingle/page/edit_video_page/view/edit_video_view.dart';
import 'package:tingle/page/fake_audio_room_page/binding/fake_audio_room_binding.dart';
import 'package:tingle/page/fake_audio_room_page/view/fake_audio_room_view.dart';
import 'package:tingle/page/fake_chat_page/binding/fake_chat_binding.dart';
import 'package:tingle/page/fake_chat_page/view/fake_chat_view.dart';
import 'package:tingle/page/fake_live_page/binding/fake_live_binding.dart';
import 'package:tingle/page/fake_live_page/view/fake_live_view.dart';
import 'package:tingle/page/live_end_page/binding/live_end_binding.dart';
import 'package:tingle/page/live_end_page/view/live_end_view.dart';
import 'package:tingle/page/fans_ranking_page/binding/fans_ranking_binding.dart';
import 'package:tingle/page/fans_ranking_page/view/fans_ranking_view.dart';
import 'package:tingle/page/feed_page/binding/feed_binding.dart';
import 'package:tingle/page/feed_page/view/feed_view.dart';
import 'package:tingle/page/fill_profile_page/binding/fill_profile_binding.dart';
import 'package:tingle/page/fill_profile_page/view/fill_profile_view.dart';
import 'package:tingle/page/go_live_page/binding/go_live_binding.dart';
import 'package:tingle/page/go_live_page/view/go_live_view.dart';
import 'package:tingle/page/help_page/binding/help_binding.dart';
import 'package:tingle/page/help_page/view/help_view.dart';
import 'package:tingle/page/my_chat_price_page/binding/my_chat_price_binding.dart';
import 'package:tingle/page/my_chat_price_page/view/my_chat_price_view.dart';
import 'package:tingle/page/my_profile_page/binding/my_profile_binding.dart';
import 'package:tingle/page/my_profile_page/view/my_profile_view.dart';
import 'package:tingle/page/my_income_page/binding/my_income_binding.dart';
import 'package:tingle/page/my_income_page/view/my_income_view.dart';
import 'package:tingle/page/task_page/binding/task_binding.dart';
import 'package:tingle/page/task_page/view/task_view.dart';
import 'package:tingle/page/my_live_pictures_page/binding/my_live_pictures_binding.dart';
import 'package:tingle/page/my_live_pictures_page/view/my_live_pictures_view.dart';
import 'package:tingle/page/recent_calls_page/binding/recent_calls_binding.dart';
import 'package:tingle/page/recent_calls_page/view/recent_calls_view.dart';
import 'package:tingle/page/income_details_page/binding/income_details_binding.dart';
import 'package:tingle/page/income_details_page/view/income_details_view.dart';
import 'package:tingle/page/report_page/binding/report_binding.dart';
import 'package:tingle/page/report_page/view/report_view.dart';
import 'package:tingle/page/charming_level_page/binding/charming_level_binding.dart';
import 'package:tingle/page/charming_level_page/view/charming_level_view.dart';
import 'package:tingle/page/wealth_level_page/binding/wealth_level_binding.dart';
import 'package:tingle/page/wealth_level_page/view/wealth_level_view.dart';
import 'package:tingle/page/incoming_video_call_page/binding/incoming_video_call_binding.dart';
import 'package:tingle/page/incoming_video_call_page/view/incoming_video_call_view.dart';
import 'package:tingle/page/live_page/binding/live_binding.dart';
import 'package:tingle/page/live_page/view/live_view.dart';
import 'package:tingle/page/login_page/binding/login_binding.dart';
import 'package:tingle/page/login_page/view/login_view.dart';
import 'package:tingle/page/message_page/binding/message_binding.dart';
import 'package:tingle/page/message_page/view/message_view.dart';
import 'package:tingle/page/on_boarding_page/binding/on_boarding_binding.dart';
import 'package:tingle/page/on_boarding_page/view/on_boarding_view.dart';
import 'package:tingle/page/other_user_connection_page/binding/other_user_connection_binding.dart';
import 'package:tingle/page/other_user_connection_page/view/other_user_connection_view.dart';
import 'package:tingle/page/party_page/binding/party_binding.dart';
import 'package:tingle/page/party_page/view/party_view.dart';
import 'package:tingle/page/preview_created_reels_page/binding/preview_created_reels_binding.dart';
import 'package:tingle/page/preview_created_reels_page/view/preview_created_reels_view.dart';
import 'package:tingle/page/preview_shorts_video_page/binding/preview_shorts_video_binding.dart';
import 'package:tingle/page/preview_shorts_video_page/view/preview_shorts_video_view.dart';
import 'package:tingle/page/preview_upload_video_page/binding/preview_upload_video_binding.dart';
import 'package:tingle/page/preview_upload_video_page/view/preview_upload_video_view.dart';
import 'package:tingle/page/preview_user_profile_page/binding/preview_user_profile_binding.dart';
import 'package:tingle/page/preview_user_profile_page/view/preview_user_profile_view.dart';
import 'package:tingle/page/profile_feed_moment_page/binding/profile_moment_binding.dart';
import 'package:tingle/page/profile_feed_moment_page/view/profile_moment_view.dart';
import 'package:tingle/page/profile_page/binding/profile_binding.dart';
import 'package:tingle/page/profile_page/view/profile_view.dart';
import 'package:tingle/page/ranking_page/binding/ranking_binding.dart';
import 'package:tingle/page/ranking_page/view/ranking_view.dart';
import 'package:tingle/page/recharge_coin_page/binding/recharge_coin_binding.dart';
import 'package:tingle/page/recharge_coin_page/view/recharge_coin_view.dart';
import 'package:tingle/page/search_message_user_page/binding/search_message_user_binding.dart';
import 'package:tingle/page/search_message_user_page/view/search_message_user_view.dart';
import 'package:tingle/page/search_page/binding/search_binding.dart';
import 'package:tingle/page/search_page/view/search_view.dart';
import 'package:tingle/page/setting_page/binding/setting_binding.dart';
import 'package:tingle/page/setting_page/view/setting_view.dart';
import 'package:tingle/page/splash_screen_page/binding/splash_screen_binding.dart';
import 'package:tingle/page/splash_screen_page/view/splash_screen_view.dart';
import 'package:tingle/page/store_page/binding/store_binding.dart';
import 'package:tingle/page/store_page/view/store_view.dart';
import 'package:tingle/page/stream_page/binding/stream_binding.dart';
import 'package:tingle/page/stream_page/view/stream_view.dart';
import 'package:tingle/page/theme_outfit_page/binding/theme_outfit_binding.dart';
import 'package:tingle/page/theme_outfit_page/view/theme_outfit_view.dart';
import 'package:tingle/page/theme_page/binding/theme_binding.dart';
import 'package:tingle/page/theme_page/view/avtar_fame_view.dart';
import 'package:tingle/page/theme_page/view/car_theme_view.dart';
import 'package:tingle/page/theme_page/view/party_theme_view.dart';
import 'package:tingle/page/upload_feed_page/binding/upload_feed_binding.dart';
import 'package:tingle/page/upload_feed_page/view/upload_feed_view.dart';
import 'package:tingle/page/upload_video_page/binding/upload_video_binding.dart';
import 'package:tingle/page/upload_video_page/view/upload_video_view.dart';
import 'package:tingle/page/video_call_page/binding/video_call_binding.dart';
import 'package:tingle/page/video_call_page/view/video_call_view.dart';
import 'package:tingle/page/video_call_ringing_page/binding/video_call_ringing_binding.dart';
import 'package:tingle/page/video_call_ringing_page/view/video_call_ringing_view.dart';
import 'app_routes.dart';

class AppPages {
  static var list = [
    GetPage(
      name: AppRoutes.splashScreenPage,
      page: () => const SplashScreenView(),
      binding: SplashScreenBinding(),
    ),
    GetPage(
      name: AppRoutes.onBoardingPage,
      page: () => const OnBoardingView(),
      binding: OnBoardingBinding(),
    ),
    GetPage(
      name: AppRoutes.loginPage,
      page: () => const LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: AppRoutes.fillProfilePage,
      page: () => const FillProfileView(),
      binding: FillProfileBinding(),
    ),
    GetPage(
      name: AppRoutes.editProfilePage,
      page: () => const EditProfileView(),
      binding: EditProfileBinding(),
    ),
    GetPage(
      name: AppRoutes.bottomBarPage,
      page: () => const BottomBarView(),
      binding: BottomBarBinding(),
    ),
    GetPage(
      name: AppRoutes.reelsPage,
      page: () => const PartyView(),
      binding: PartyBinding(),
    ),
    GetPage(
      name: AppRoutes.streamPage,
      page: () => const StreamView(),
      binding: StreamBinding(),
    ),
    GetPage(
      name: AppRoutes.feedPage,
      page: () => const FeedView(),
      binding: FeedBinding(),
    ),
    GetPage(
      name: AppRoutes.messagePage,
      page: () => const MessageView(),
      binding: MessageBinding(),
    ),
    GetPage(
      name: AppRoutes.profilePage,
      page: () => const ProfileView(),
      binding: ProfileBinding(),
    ),
    GetPage(
      name: AppRoutes.uploadFeedPage,
      page: () => const UploadFeedView(),
      binding: UploadFeedBinding(),
    ),
    GetPage(
      name: AppRoutes.uploadVideoPage,
      page: () => const UploadVideoView(),
      binding: UploadVideoBinding(),
    ),
    GetPage(
      name: AppRoutes.previewUploadVideoPage,
      page: () => const PreviewUploadVideoView(),
      binding: PreviewUploadVideoBinding(),
    ),
    GetPage(
      name: AppRoutes.chatPage,
      page: () => const ChatView(),
      binding: ChatBinding(),
    ),
    GetPage(
      name: AppRoutes.audioRoomPage,
      page: () => const AudioRoomView(),
      binding: AudioRoomBinding(),
    ),
    GetPage(
      name: AppRoutes.fakeAudioRoomPage,
      page: () => const FakeAudioRoomView(),
      binding: FakeAudioRoomBinding(),
    ),
    GetPage(
      name: AppRoutes.searchPage,
      page: () => const SearchView(),
      binding: SearchBinding(),
    ),
    GetPage(
      name: AppRoutes.searchMessageUserPage,
      page: () => const SearchMessageUserView(),
      binding: SearchMessageUserBinding(),
    ),
    GetPage(
      name: AppRoutes.incomingVideoCallPage,
      page: () => const IncomingVideoCallView(),
      binding: IncomingVideoCallBinding(),
    ),
    GetPage(
      name: AppRoutes.videoCallPage,
      page: () => const VideoCallView(),
      binding: VideoCallBinding(),
    ),
    GetPage(
      name: AppRoutes.videoCallRingingPage,
      page: () => const VideoCallRingingView(),
      binding: VideoCallRingingBinding(),
    ),
    GetPage(
      name: AppRoutes.editFeedPage,
      page: () => const EditFeedView(),
      binding: EditFeedBinding(),
    ),
    GetPage(
      name: AppRoutes.editVideoPage,
      page: () => const EditVideoView(),
      binding: EditVideoBinding(),
    ),
    GetPage(
      name: AppRoutes.previewUserProfilePage,
      page: () => const PreviewUserProfileView(),
      binding: PreviewUserProfileBinding(),
    ),
    GetPage(
      name: AppRoutes.previewShortsVideoPage,
      page: () => const PreviewShortsVideoView(),
      binding: PreviewShortsVideoBinding(),
    ),
    GetPage(
      name: AppRoutes.connectionPage,
      page: () => const ConnectionView(),
      binding: ConnectionBinding(),
    ),
    GetPage(
      name: AppRoutes.searchConnectionPage,
      page: () => const SearchConnectionView(),
      binding: SearchConnectionBinding(),
    ),
    GetPage(
      name: AppRoutes.rechargeCoinPage,
      page: () => const RechargeCoinView(),
      binding: RechargeCoinBinding(),
    ),
    GetPage(
      name: AppRoutes.createReelsPage,
      page: () => const CreateReelsView(),
      binding: CreateReelsBinding(),
    ),
    GetPage(
      name: AppRoutes.previewCreatedReelsPage,
      page: () => const PreviewCreatedReelsView(),
      binding: PreviewCreatedReelsBinding(),
    ),
    GetPage(
      name: AppRoutes.audioWiseVideosPage,
      page: () => const AudioWiseVideosView(),
      binding: AudioWiseVideosBinding(),
    ),
    GetPage(
      name: AppRoutes.coinHistoryPage,
      page: () => const CoinHistoryView(),
      binding: CoinHistoryBinding(),
    ),
    GetPage(
      name: AppRoutes.livePage,
      page: () => const LiveView(),
      binding: LiveBinding(),
    ),
    GetPage(
      name: AppRoutes.fakeLivePage,
      page: () => const FakeLiveView(),
      binding: FakeLiveBinding(),
    ),
    GetPage(
      name: AppRoutes.liveEndPage,
      page: () => const LiveEndView(),
      binding: LiveEndBinding(),
    ),
    GetPage(
      name: AppRoutes.fakeChatPage,
      page: () => const FakeChatView(),
      binding: FakeChatBinding(),
    ),
    GetPage(
      name: AppRoutes.chatPage,
      page: () => const ChatView(),
      binding: ChatBinding(),
    ),
    GetPage(
      name: AppRoutes.goLivePage,
      page: () => const GoLiveView(),
      binding: GoLiveBinding(),
    ),
    GetPage(
      name: AppRoutes.storePage,
      page: () => const StoreView(),
      binding: StoreBinding(),
    ),
    GetPage(
      name: AppRoutes.rideFramePage,
      page: () => RideThemeView(),
      binding: ThemeBinding(),
    ),
    GetPage(
      name: AppRoutes.avtarFramePage,
      page: () => AvtarThemeView(),
      binding: ThemeBinding(),
    ),
    GetPage(
      name: AppRoutes.partyFramePage,
      page: () => PartyThemeView(),
      binding: ThemeBinding(),
    ),
    GetPage(
      name: AppRoutes.backpackPage,
      page: () => BackpackPage(),
      binding: BackpackBinding(),
    ),
    GetPage(
      name: AppRoutes.themeOutfitPage,
      page: () => ThemeOutfitView(),
      binding: ThemeOutfitBinding(),
    ),
    GetPage(
      name: AppRoutes.createAudioRoomPage,
      page: () => CreateAudioRoomView(),
      binding: CreateAudioRoomBinding(),
    ),
    GetPage(
      name: AppRoutes.myChatPricePage,
      page: () => const MyChatPriceView(),
      binding: MyChatPriceBinding(),
    ),
    GetPage(
      name: AppRoutes.myProfilePage,
      page: () => const MyProfileView(),
      binding: MyProfileBinding(),
    ),
    GetPage(
      name: AppRoutes.myIncomePage,
      page: () => const MyIncomeView(),
      binding: MyIncomeBinding(),
    ),
    GetPage(
      name: AppRoutes.taskPage,
      page: () => const TaskView(),
      binding: TaskBinding(),
    ),
    GetPage(
      name: AppRoutes.incomeDetailsPage,
      page: () => const IncomeDetailsView(),
      binding: IncomeDetailsBinding(),
    ),
    GetPage(
      name: AppRoutes.reportPage,
      page: () => const ReportView(),
      binding: ReportBinding(),
    ),
    GetPage(
      name: AppRoutes.charmingLevelPage,
      page: () => const CharmingLevelView(),
      binding: CharmingLevelBinding(),
    ),
    GetPage(
      name: AppRoutes.wealthLevelPage,
      page: () => const WealthLevelView(),
      binding: WealthLevelBinding(),
    ),
    GetPage(
      name: AppRoutes.rankingPage,
      page: () => RankingView(),
      binding: RankingBinding(),
    ),
    GetPage(
      name: AppRoutes.helpPage,
      page: () => const HelpView(),
      binding: HelpBinding(),
    ),
    GetPage(
      name: AppRoutes.fansRankingPage,
      page: () => const FansRankingView(),
      binding: FansRankingBinding(),
    ),
    GetPage(
      name: AppRoutes.profileMomentPage,
      page: () => const ProfileMomentView(),
      binding: ProfileMomentBinding(),
    ),
    GetPage(
      name: AppRoutes.otherUserConnectionPage,
      page: () => const OtherUserConnectionView(),
      binding: OtherUserConnectionBinding(),
    ),
    GetPage(
      name: AppRoutes.settingPage,
      page: () => const SettingView(),
      binding: SettingBinding(),
    ),
    GetPage(
      name: AppRoutes.myLivePicturesPage,
      page: () => const MyLivePicturesView(),
      binding: MyLivePicturesBinding(),
    ),
    GetPage(
      name: AppRoutes.recentCallsPage,
      page: () => const RecentCallsView(),
      binding: RecentCallsBinding(),
    ),
  ];
}
