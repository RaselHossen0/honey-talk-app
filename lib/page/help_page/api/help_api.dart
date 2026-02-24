import 'dart:async';
import 'package:tingle/page/help_page/model/help_model.dart';

class HelpApi {
  static Future<HelpModel?> callApi({
    required String complaint,
    required String contact,
    String? image,
  }) async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 100));

    // Dummy Data
    return HelpModel(
      status: true,
      message: "Help submitted successfully!",
      data: Data(
        userId: "USER_id",
        complaint: complaint,
        contact: contact,
        image: image ?? "https://example.com/uploads/help_dummy_image.jpg",
        date: DateTime.now().toIso8601String(),
        status: 1, // 1 = Active / Submitted
        id: "dummy_help_id_123456",
        createdAt: DateTime.now().toIso8601String(),
        updatedAt: DateTime.now().toIso8601String(),
      ),
    );
  }
}
