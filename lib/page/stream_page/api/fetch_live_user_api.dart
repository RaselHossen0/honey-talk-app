import 'dart:async';
import 'dart:math';
import 'package:tingle/database/fake_data/user_fake_data.dart';
import 'package:tingle/page/stream_page/model/fetch_live_user_model.dart'; // make sure path is correct
import 'package:tingle/utils/utils.dart';

class FetchLiveUserApi {
  static Future<FetchLiveUserModel?> callApi({
    required String token,
    required String uid,
    required String liveType,
    required int startPage,
    String? country,
  }) async {
    Utils.showLog("Mock Fetch Live User API Called");

    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 100));
    FakeProfilesSet.sampleNames.shuffle();
    FakeProfilesSet.sampleImages.shuffle();
    // Return dummy data
    return FetchLiveUserModel(
      status: true,
      message: "Live users fetched successfully",
      liveUserList: List.generate(
          5,
          (index) => LiveUserList(
                id: "live_id_$index",
                userId: "user_id_$index",
                streamSource: index % 2 == 0 ? "" : "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerJoyrides.mp4",
                pkStreamSources: [
                  "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerJoyrides.mp4",
                  "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerJoyrides.mp4",
                ],
                name: FakeProfilesSet.liveNames[index],
                pkThumbnails: [FakeProfilesSet.womensSampleImages[Random.secure().nextInt(10)], FakeProfilesSet.womensSampleImages[Random.secure().nextInt(10)]],
                userName: FakeProfilesSet.sampleNames[index],
                image: FakeProfilesSet.womensSampleImages[index],
                isProfilePicBanned: false,
                countryFlagImage: "https://example.com/flags/flag_$index.png",
                country: "Country $index",
                isVerified: index % 2 == 0,
                view: 100 + index * 20,
                hostIsMuted: 0,
                channel: "channel_$index",
                token: "token_$index",
                liveType: Random().nextBool()
                    ? 1
                    : Random().nextBool()
                        ? 2
                        : 3,
                isPkMode: index % 2 == 0,
                videoUrl: "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerJoyrides.mp4",
                isFake: true,
                audioLiveType: 0,
                privateCode: 1111 + index,
                agoraUid: 5000 + index,
                roomName: "Room $index",
                roomWelcome: "Welcome to Room $index",
                roomImage: FakeProfilesSet.womensSampleImages[index],
                isAudio: false,
                liveHistoryId: "history_$index",
                uniqueId: "unique_host_$index",
                coin: 500 + index * 50,
                wealthLevelImage: "https://example.com/wealth/wealth_$index.png",
                themeId: "theme_$index",
                theme: "Theme $index",
                seat: [],
                requested: [],
                blockedUsers: [],
                host2Id: "host_$index",
                host2IsProfilePicBanned: false,
                host2Channel: "dfkml",
                host2Coin: Random().nextInt(1000),
                host2Image: FakeProfilesSet.womensSampleImages[index],
                host2IsFollow: false,
                host2LiveId: "nfv",
                host2Name: FakeProfilesSet.sampleNames[index + 3],
                host2Token: "afmdf",
                host2UniqueId: "11234",
                host2userName: FakeProfilesSet.sampleNames[index + 3],
                isFollow: false,
                viewers: [],
              )),
    );
  }
}
