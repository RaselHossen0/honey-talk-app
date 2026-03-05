/// Arguments passed when navigating to Live End Screen after a live session ends.
class LiveEndArgs {
  final String hostImage;
  final String hostName;
  final String countryFlag;
  final int age;
  final int likesCount;
  final int liveDurationMinutes;
  final int audienceCount;

  LiveEndArgs({
    required this.hostImage,
    required this.hostName,
    this.countryFlag = '🇮🇳',
    this.age = 18,
    this.likesCount = 0,
    this.liveDurationMinutes = 0,
    this.audienceCount = 0,
  });
}
