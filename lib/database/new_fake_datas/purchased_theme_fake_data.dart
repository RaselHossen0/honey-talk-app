import 'dart:math';

import 'package:tingle/page/backpack_page/model/fetch_purchased_model.dart';
import 'package:tingle/utils/assets.dart';

FetchPurchasedFrameModel fetchPurchasedFrameData() {
  final random = Random();
  final now = DateTime.now();

  // Helper function to generate a list of Active items
  List<Active> generateActiveItems(int count, String prefix, int type) {
    return List.generate(count, (index) {
      final daysToAdd = random.nextInt(365); // Random days up to 1 year
      final purchaseDate = now.subtract(Duration(days: random.nextInt(30))); // Purchased in last 30 days
      final expiryDate = purchaseDate.add(Duration(days: daysToAdd));

      return Active(
        expiryDate: expiryDate,
        purchaseDate: purchaseDate,
        isExpired: expiryDate.isBefore(now),
        isSelected: index == 2,
        itemId: '${prefix}_id_${index + 1}',
        type: type,
        // image: 'https://example.com/images/${prefix}_${index + 1}.png',
        image: Random().nextBool()
            ? AppAssets.icFrameMegicBook
            : Random().nextBool()
                ? AppAssets.icFrameTwin
                : AppAssets.icFrameMermaid,
        svgaImage: avtarFrame.take(1).toString(),
        name: '${prefix.replaceFirst(prefix[0], prefix[0].toUpperCase())} ${index + 1}',
      );
    });
  }

  // Generate 10 active items for each category
  final themes = AvatarFrames(
    active: generateActiveItems(10, 'theme', 1),
    expired: [], // Empty for dummy data
  );

  final avatarFrames = AvatarFrames(
    active: generateActiveItems(10, 'frame', 2),
    expired: [], // Empty for dummy data
  );

  final rides = AvatarFrames(
    active: generateActiveItems(10, 'ride', 3),
    expired: [], // Empty for dummy data
  );

  return FetchPurchasedFrameModel(
    status: true,
    message: 'Data fetched successfully',
    data: Data(
      themes: themes,
      avatarFrames: avatarFrames,
      rides: rides,
    ),
  );
}

List<String> avtarFrame = [AppAssets.icFrameMermaid, "", AppAssets.icFrameMegicBook, "", AppAssets.icFrameTwin];
List<String> partyTheme = [AppAssets.icFlowerTheme, "", AppAssets.icRoadTheme, "", AppAssets.icWatherTheme];
List<String> rideTheme = [AppAssets.icRideone, "", AppAssets.icRidesec, "", AppAssets.icRidethird];
