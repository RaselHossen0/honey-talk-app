import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:tingle/page/login_page/api/fetch_login_user_profile_api.dart';
import 'package:tingle/routes/app_routes.dart';
import 'package:tingle/utils/database.dart';
import 'package:tingle/utils/enums.dart';
import 'package:tingle/utils/utils.dart';

class MyProfileController extends GetxController {
  dynamic get _user => FetchLoginUserProfileApi.fetchLoginUserProfileModel?.user ?? Database.fetchLoginUserProfile()?.user;

  String get userId => _user?.uniqueId ?? "";
  String get nickname => _user?.name ?? "";
  String get gender => _formatGender(_user?.gender);
  String get age => (_user?.age ?? 0).toString();
  String get country => _user?.country ?? "India";
  String get countryFlag => _user?.countryFlagImage ?? "🇮🇳";
  String get image => _user?.image ?? "";
  bool get isProfilePicBanned => _user?.isProfilePicBanned ?? false;
  String get email => _user?.email ?? "";
  String get phone => _user?.mobileNumber ?? "";
  String get bio => _user?.bio ?? "";
  String get googleName => _user?.provider == "google" ? _user?.name ?? "" : "";

  String _formatGender(String? g) {
    if (g == null) return "";
    if (g.toLowerCase() == "male") return EnumLocal.txtMale.name.tr;
    if (g.toLowerCase() == "female") return EnumLocal.txtFemale.name.tr;
    return g;
  }

  String get maskedEmail {
    final e = email;
    if (e.isEmpty || !e.contains("@")) return "";
    final parts = e.split("@");
    final name = parts[0];
    if (name.length <= 2) return "$name****@${parts[1]}";
    return "${name.substring(0, 2)}****@${parts[1]}";
  }

  void onCopyId() {
    if (userId.isNotEmpty) {
      Clipboard.setData(ClipboardData(text: userId));
      Utils.showToast(text: EnumLocal.txtCopiedOnClipboard.name.tr);
    }
  }

  void onNavigateToEditProfile() {
    Get.toNamed(AppRoutes.editProfilePage);
  }

  void onResetPassword() {
    // TODO: Navigate to reset password flow when API ready
    Utils.showToast(text: "Reset password - Coming soon");
  }
}
