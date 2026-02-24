import 'package:tingle/utils/utils.dart';

class CountryFlagIcon {
  static String onShow(String value) {
    return value == "" ? Utils.defaultCountryFlag : value;
  }
}
