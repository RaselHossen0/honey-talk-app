import 'package:tingle/utils/assets.dart';

class GenderIcon {
  static String onShow(String value) {
    return value.toLowerCase() == "male" ? AppAssets.icMale : AppAssets.icFemale;
  }
}
