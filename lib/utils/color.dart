import 'package:flutter/material.dart';

abstract class AppColor {
  static const white = Color(0xFFFFFFFF);
  static const black = Color(0xFF000000);
  static const transparent = Color(0x00000000);
  static const colorScaffold = Color(0xffFBFCFF);

  static const primary = Color(0xFF9848FF);
  static const secondary = Color(0xFF9D9AC4);

  static final baseColor = Color(0xffCBDBFF).withValues(alpha: 0.6);
  static final highlightColor = Color(0xffe3e7f6);

  static const backgroundColor = Color(0xffF7F7F7);

  static const red = Color(0xFFFC1010);
  static const pink = Color(0xFFFF1E8B);
  static const purple = Color(0xFFC53CFF);
  static final shimmer1 = Color(0xFFC1C7E4);
  static final shimmer = Color(0xFF9D9AC4).withValues(alpha: 0.4);
  static final lightGrey = Color(0xFFA3A0C6);
  static final orange = Color(0xFFF6740A);

  static const colorLightBlue = Color(0xff6E71A9);
  static const colorBorder = Color(0xFFE5EAFF);

  static const green = Color(0xFF05B21F);
  static const lightGreen = Color(0xFF25FF96);

  static const lightestYellow = Color(0xFFFFF5D2);
  static const lighterYellow = Color(0xFFF8FFA9);
  static const lightYellow = Color(0xFFFEC64A);
  static final mediumYellow = Color(0xFFFFBA42);
  static final darkYellow = Color(0xFFFF9D00);
  static const lightYellowGreen = Color(0xFFCDFF39);

  static const blue = Color(0xFF6A8AFF);
  static const lightBlue = Color(0xFF22D6FF);
  static const darkBlue = Color(0xFF5956E1);
  static const bluePurple = Color(0xFF6D53CD);
  static const mediumBlue = Color(0xFF435794);

  static const darkGrey = Color(0xFF181A24);
  static const greyBlue = Color(0xFF3F3B5E);
  static const lightGreyPurple = Color(0xFF6F5B97);
  static const lightPurple = Color(0xFFF3F3FF);
  static const darkPurple = Color(0xFF260523);

  static const grey = Color(0xFF4B4B4B);
  static const lightGray_1 = Color(0xFFF0EDFF);
  static const brown = Color(0xFF987049);
  // audio room seat bg
  static const seatColorOne = Color(0x268A8A8A);
  static const seatColorSec = Color(0x24FFFFFF);

  static const lightGrayBg = Color(0xFFF1F1FF);
  static const lightGray = Color(0xFFF1EEF4);
  static const darkGray = Color(0xFF757575);
  static const extraLightGray = Color(0xFFFAFAFA);
  static const deepLightGray = Color(0xFFBABABA);
  static const grayText = Color(0xFF8175BB);
  static const deepViolet = Color(0xFF250523);
  static const purpleGray = Color(0xFFB7B5C6);
  static const daiLogAppbar = Color(0xFFF8F8FC);

  static const color_1 = Color(0xFFFFDDFF);
  static const color_2 = Color(0xFFF5FFDB);
  static const color_3 = Color(0xFFFFD7FF);
  static const color_4 = Color(0xFFFFE9DD);
  static const color_5 = Color(0xFFDDFFD5);
  static const color_6 = Color(0xFFC8FFF5);
  static const color_7 = Color(0xFFFFEED7);
  static const color_8 = Color(0xFFFFD7D7);
  static const color_9 = Color(0xFFF6D7FF);
  static const color_10 = Color(0xFFD7EEFF);
  static const color_11 = Color(0xFFECD7FF);
  static const color_12 = Color(0xFFFFD7FE);

  static const primaryGradient = LinearGradient(colors: [Color(0xFF9E53FF), Color(0xFF6A3CCF)]);

  static const pinkPurpleGradient = LinearGradient(colors: [Color(0xFFF108F5), Color(0xFF9718FF)]);
  static const lightDarkPinkGradient = LinearGradient(colors: [Color(0xFFFF0073), Color(0xFFFF0A37)], begin: Alignment.centerLeft, end: Alignment.centerRight);
  static const orangeYellowGradient = LinearGradient(colors: [Color(0xFFFF611D), Color(0xFFF79132)]);
  static const lightYellowOrangeGradient = LinearGradient(colors: [Color(0xFFFED74C), Color(0xFFFE7E3F)]);
  static const lightOrangeYellowGradient = LinearGradient(colors: [Color(0xFFFF8317), Color(0xFFFF9A03)]);
  static const bluePurpleGradient = LinearGradient(colors: [Color(0xFF0C85FF), Color(0xFF4D33FA)]);
  static const coinPinkGradient = LinearGradient(colors: [Color(0xFFFF5F5D), Color(0xFFFF349A), Color(0xFFFF6B5A)]);

  static const announcementGradient = LinearGradient(colors: [Color(0xFF9447FF), Color(0xFF8B0FE9)]);
  static const securityGradient = LinearGradient(colors: [Color(0xFFFF5B3E), Color(0xFFFF2528)]);
  static const giftTimeGradient = LinearGradient(colors: [Color(0xFFFE0032), Color(0xFFFF2A22), Color(0xFFFF7E00)]);

  static const rewardGradient = LinearGradient(colors: [Color(0xFFFFEEEE), Color(0xFFFFDDE8)]);
  static const rankingGradient = LinearGradient(colors: [Color(0xFFFFF2E8), Color(0xFFFFEDD2)]);
  static const storeGradient = LinearGradient(colors: [Color(0xFFFFE9DC), Color(0xFFFFDBD4)]);
  static const inviteGradient = LinearGradient(colors: [Color(0xFFFFE7EA), Color(0xFFFFE1E6)]);
  static const fansClubGradient = LinearGradient(colors: [Color(0xFFFFE4F3), Color(0xFFFFE6F4)]);
  static const authoriseGradient = LinearGradient(colors: [Color(0xFFEAEBFF), Color(0xFFD0E2FF)]);
  static const audioRoomGradient = LinearGradient(colors: [Color(0xFF310059), Color(0xFF4F0628)]);
  static const inUseGradient = LinearGradient(colors: [Color(0xFFF108F5), Color(0xFF9718FF)]);

  static const monthHottestGradient = LinearGradient(
    colors: [Color(0xFFFF00C8), Color(0xFF3665FF)],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  static const monthHottestGradientBg = LinearGradient(
    colors: [
      Color(0xFFD160E6),
      Color(0xFF676AEF),
    ],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );
}
