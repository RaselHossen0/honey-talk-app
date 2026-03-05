import 'package:tingle/core/network/api_client.dart';
import 'package:tingle/page/profile_page/model/fetch_user_profile_model.dart';
import 'package:tingle/utils/utils.dart';

/// Map backend user response to FetchUserProfileModel.
FetchUserProfileModel _mapResponseToModel(Map<String, dynamic> res) {
  final u = Map<String, dynamic>.from(res);
  u['_id'] = u['id'];
  if (u['wealthLevelObj'] != null) {
    u['wealthLevel'] = Map<String, dynamic>.from(u['wealthLevelObj'] as Map);
    (u['wealthLevel'] as Map)['_id'] = (u['wealthLevel'] as Map)['id'];
  }
  if (u['activeAvtarFrame'] != null) {
    final f = Map<String, dynamic>.from(u['activeAvtarFrame'] as Map);
    f['_id'] = f['id'];
    u['activeAvtarFrame'] = f;
  }
  return FetchUserProfileModel(
    status: true,
    message: 'Success',
    user: User.fromJson(u),
  );
}

/// Fetch current user profile from GET /users/me and map to FetchUserProfileModel.
Future<FetchUserProfileModel?> fetchMyProfile() async {
  try {
    final res = await ApiClient.instance.get('/users/me');
    if (res['id'] == null) return null;
    return _mapResponseToModel(res);
  } catch (e) {
    Utils.showLog("Fetch My Profile API Error: $e");
    return null;
  }
}

/// Fetch any user profile (own or other) from API.
/// Uses GET /users/me for own profile, GET /users/:id for others.
Future<FetchUserProfileModel?> fetchUserProfile({
  required String userId,
  required String loginUserId,
}) async {
  if (userId.isEmpty) return null;
  try {
    final path = userId == loginUserId ? '/users/me' : '/users/$userId';
    final res = await ApiClient.instance.get(path);
    if (res['id'] == null) return null;
    return _mapResponseToModel(res);
  } catch (e) {
    Utils.showLog("Fetch User Profile API Error: $e");
    return null;
  }
}

@Deprecated('Use fetchMyProfile() for real API data')
FetchUserProfileModel getDummyFetchUserProfile() {
  return FetchUserProfileModel(
    status: true,
    message: "Profile fetched successfully",
    user: User(
      id: "user_101",
      name: "Alex Johnson",
      userName: "alexjohnson",
      gender: "Male",
      age: 28,
      image: "https://randomuser.me/api/portraits/men/32.jpg",
      isProfilePicBanned: false,
      countryFlagImage: "🇺🇸",
      country: "United States",
      uniqueId: "unique_101",
      coin: 7800,
      incomeCoin: 1250,
      receivedGifts: 150,
      wealthLevel: WealthLevel(
        id: "wealth_2",
        levelImage: "https://dummyimage.com/wealth_level_2.png",
      ),
      activeAvtarFrame: ActiveAvtarFrame(
        id: "frame_5",
        type: 2, // Assume type 2 = VIP frame
        image: "https://dummyimage.com/avatar_frame_5.png",
      ),
      isVerified: true,
      totalFollowers: 1200,
      totalFollowing: 350,
      totalFriends: 580,
      totalVisitors: 980,
    ),
  );
}
