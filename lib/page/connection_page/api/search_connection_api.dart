import 'package:tingle/page/connection_page/model/search_connection_model.dart';
import 'dart:math';

class SearchConnectionApi {
  static Future<SearchConnectionModel?> callApi({
    required String searchString,
    required String type,
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

    // Generate search results (5-15 items)
    final searchData = List.generate(5 + random.nextInt(11), (index) {
      final country = countries[random.nextInt(countries.length)];
      final name = _generateRandomName(random);
      final userName = '${name.toLowerCase().replaceAll(' ', '')}${random.nextInt(100)}';
      final joinDate = now.subtract(Duration(days: random.nextInt(365)));

      return SearchData(
        id: 'user_${searchString}_${index + 1}',
        name: name,
        userName: userName,
        image: 'https://randomuser.me/api/portraits/${random.nextBool() ? 'men' : 'women'}/${random.nextInt(100)}.jpg',
        isProfilePicBanned: random.nextDouble() < 0.1,
        age: 18 + random.nextInt(50),
        isVerified: random.nextDouble() < 0.3,
        country: country['name'],
        countryFlagImage: country['flag'],
        coin: 100 + random.nextInt(9900),
        uniqueId: '${country['code']}${random.nextInt(999999)}',
        isOnline: random.nextBool(),
        date: joinDate,
        wealthLevelImage: 'wealth_${random.nextInt(5) + 1}.png',
        isFollow: random.nextBool(),
      );
    });

    // Filter results based on search string (simulate real search)
    final filteredResults = searchData.where((user) {
      return user.name!.toLowerCase().contains(searchString.toLowerCase()) || user.userName!.toLowerCase().contains(searchString.toLowerCase());
    }).toList();

    return SearchConnectionModel(
      status: true,
      message: 'Search results for "$searchString"',
      searchData: filteredResults,
    );
  }

  static String _generateRandomName(Random random) {
    final firstNames = ['Alex', 'Taylor', 'Jordan', 'Casey', 'Morgan', 'Jamie'];
    final lastNames = ['Smith', 'Johnson', 'Williams', 'Brown', 'Jones', 'Garcia'];
    return '${firstNames[random.nextInt(firstNames.length)]} ${lastNames[random.nextInt(lastNames.length)]}';
  }
}
