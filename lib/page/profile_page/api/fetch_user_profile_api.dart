import 'package:tingle/page/profile_page/model/fetch_user_profile_model.dart';

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
