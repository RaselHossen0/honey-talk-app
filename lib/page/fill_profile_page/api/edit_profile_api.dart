import 'package:tingle/core/network/api_client.dart';
import 'package:tingle/page/fill_profile_page/model/edit_profile_model.dart';
import 'package:tingle/utils/utils.dart';

/// PATCH /users/me - Update logged-in user profile.
/// Image: pass URL string if available; local file paths need upload first.
class EditProfileApi {
  static Future<EditProfileModel?> callApi({
    required String token,
    required String uid,
    required String name,
    required String userName,
    required String gender,
    required String age,
    String? bio,
    String? country,
    String? countryFlagImage,
    String? image,
  }) async {
    Utils.showLog("Edit Profile API Calling...");
    try {
      final ageInt = int.tryParse(age.trim());
      final body = <String, dynamic>{
        'name': name.trim(),
        'userName': userName.trim(),
        'gender': gender,
        'age': ageInt ?? 0,
        'bio': bio?.trim(),
        'country': country?.trim(),
        'countryFlagImage': countryFlagImage?.trim(),
        if (image != null && image.isNotEmpty) 'image': image,
      };

      final res = await ApiClient.instance.patch('/users/me', body: body, token: token);

      if (res['id'] != null) {
        final u = Map<String, dynamic>.from(res);
        u['_id'] = u['id'];
        return EditProfileModel(
          status: true,
          message: 'Success',
          user: User.fromJson(u),
        );
      }

      return EditProfileModel(
        status: res['status'] ?? false,
        message: res['message'] ?? 'Failed',
        user: null,
      );
    } catch (e) {
      Utils.showLog("Edit Profile API Error: $e");
      return EditProfileModel(status: false, message: e.toString(), user: null);
    }
  }
}
