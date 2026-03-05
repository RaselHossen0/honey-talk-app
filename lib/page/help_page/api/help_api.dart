import 'package:tingle/core/network/api_client.dart';
import 'package:tingle/page/help_page/model/help_model.dart';
import 'package:tingle/utils/utils.dart';

class HelpApi {
  static Future<HelpModel?> callApi({
    required String complaint,
    required String contact,
    String? image,
  }) async {
    try {
      final res = await ApiClient.instance.post(
        '/help',
        body: {
          'complaint': complaint,
          'contact': contact,
          if (image != null && image.isNotEmpty) 'image': image,
        },
      );
      final d = res['data'] as Map<String, dynamic>?;
      return HelpModel(
        status: res['status'] as bool? ?? true,
        message: res['message'] as String? ?? 'Submitted',
        data: d != null
            ? Data(
                userId: d['userId'] as String?,
                complaint: d['complaint'] as String? ?? complaint,
                contact: d['contact'] as String? ?? contact,
                image: d['image'] as String? ?? image,
                date: d['createdAt'] as String? ?? DateTime.now().toIso8601String(),
                status: 1,
                id: d['id'] as String?,
                createdAt: d['createdAt'] as String?,
                updatedAt: d['updatedAt'] as String?,
              )
            : null,
      );
    } catch (e) {
      Utils.showLog("Help API Error: $e");
      return HelpModel(status: false, message: e.toString(), data: null);
    }
  }
}
