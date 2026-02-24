import 'dart:math';
import 'package:tingle/page/connection_page/model/fetch_visitor_model.dart';

class FetchVisitorApi {
  static Future<VisitorModel?> callApi({
    required String userId,
    required String token,
  }) async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 100));

    // Generate realistic dummy data
    final random = Random();
    final now = DateTime.now();

    // Country data with flags
    final countries = [
      {'name': 'United States', 'flag': '🇺🇸', 'code': 'US'},
      {'name': 'India', 'flag': '🇮🇳', 'code': 'IN'},
      {'name': 'Brazil', 'flag': '🇧🇷', 'code': 'BR'},
      {'name': 'Germany', 'flag': '🇩🇪', 'code': 'DE'},
      {'name': 'Japan', 'flag': '🇯🇵', 'code': 'JP'},
    ];

    // Common first names for more realistic data
    final firstNames = ['Alex', 'Taylor', 'Jordan', 'Casey', 'Morgan', 'Jamie'];
    final lastNames = ['Smith', 'Johnson', 'Williams', 'Brown', 'Jones', 'Garcia'];

    // Generate profile visitors (5-10)
    final profileVisitors = List.generate(5 + random.nextInt(6), (index) {
      final country = countries[random.nextInt(countries.length)];
      final firstName = firstNames[random.nextInt(firstNames.length)];
      final lastName = lastNames[random.nextInt(lastNames.length)];
      final visitDate = now.subtract(Duration(days: random.nextInt(30)));

      return ProfileVisitor(
        isFollow: random.nextBool(),
        id: 'visitor_${userId}_${index + 1}',
        name: '$firstName $lastName',
        userName: '${firstName.toLowerCase()}${random.nextInt(100)}',
        image: 'https://randomuser.me/api/portraits/${random.nextBool() ? 'men' : 'women'}/${random.nextInt(50)}.jpg',
        isProfilePicBanned: random.nextDouble() < 0.1,
        age: 18 + random.nextInt(50),
        isVerified: random.nextDouble() < 0.3,
        country: country['name'],
        countryFlagImage: country['flag'],
        coin: 100 + random.nextInt(9900),
        uniqueId: '${country['code']}${random.nextInt(999999)}',
        isOnline: random.nextBool(),
        wealthLevelImage: 'wealth_${random.nextInt(5) + 1}.png',
        date: visitDate,
      );
    });

    // Generate visited profiles (3-8)
    final visitedProfiles = List.generate(3 + random.nextInt(6), (index) {
      final country = countries[random.nextInt(countries.length)];
      final firstName = firstNames[random.nextInt(firstNames.length)];
      final lastName = lastNames[random.nextInt(lastNames.length)];
      final visitDate = now.subtract(Duration(days: random.nextInt(30)));

      return ProfileVisitor(
        isFollow: random.nextBool(),
        id: 'visited_${userId}_${index + 1}',
        name: '$firstName $lastName',
        userName: '${firstName.toLowerCase()}${random.nextInt(100)}',
        image: 'https://randomuser.me/api/portraits/${random.nextBool() ? 'men' : 'women'}/${random.nextInt(50)}.jpg',
        isProfilePicBanned: random.nextDouble() < 0.1,
        age: 18 + random.nextInt(50),
        isVerified: random.nextDouble() < 0.3,
        country: country['name'],
        countryFlagImage: country['flag'],
        coin: 100 + random.nextInt(9900),
        uniqueId: '${country['code']}${random.nextInt(999999)}',
        isOnline: random.nextBool(),
        wealthLevelImage: 'wealth_${random.nextInt(5) + 1}.png',
        date: visitDate,
      );
    });

    // Sort by most recent date
    profileVisitors.sort((a, b) => b.date!.compareTo(a.date!));
    visitedProfiles.sort((a, b) => b.date!.compareTo(a.date!));

    return VisitorModel(
      status: true,
      message: 'Visitor data fetched successfully',
      profileVisitors: profileVisitors,
      visitedProfiles: visitedProfiles,
    );
  }
}
