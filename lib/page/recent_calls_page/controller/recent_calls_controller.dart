import 'package:get/get.dart';
import 'package:tingle/routes/app_routes.dart';
import 'package:tingle/utils/api_params.dart';

class RecentCallModel {
  RecentCallModel({
    required this.avatarUrl,
    required this.name,
    required this.userId,
    required this.countryFlag,
    required this.callCount,
    required this.dateTime,
    this.isRich1 = false,
    this.isRich2 = false,
  });

  final String avatarUrl;
  final String name;
  final String userId;
  final String countryFlag;
  final int callCount;
  final String dateTime;
  final bool isRich1;
  final bool isRich2;
}

class RecentCallsController extends GetxController {
  late List<RecentCallModel> calls;

  @override
  void onInit() {
    super.onInit();
    _loadCalls();
  }

  void _loadCalls() {
    calls = [
      RecentCallModel(
        avatarUrl: 'https://i.pravatar.cc/100?img=1',
        name: 'Gracy',
        userId: 'ID: 654321',
        countryFlag: '🇮🇳',
        callCount: 3,
        dateTime: '11:34 PM',
        isRich1: true,
      ),
      RecentCallModel(
        avatarUrl: 'https://i.pravatar.cc/100?img=2',
        name: 'Emma',
        userId: 'ID: 789012',
        countryFlag: '🇺🇸',
        callCount: 2,
        dateTime: '10:15 AM',
        isRich2: true,
      ),
      RecentCallModel(
        avatarUrl: 'https://i.pravatar.cc/100?img=3',
        name: 'Lily',
        userId: 'ID: 345678',
        countryFlag: '🇯🇵',
        callCount: 1,
        dateTime: 'Yesterday',
      ),
    ];
  }

  void onMessageTap(RecentCallModel call) {
    Get.toNamed(AppRoutes.chatPage, arguments: {
      ApiParams.roomId: "",
      ApiParams.receiverUserId: call.userId,
      ApiParams.name: call.name,
      ApiParams.image: call.avatarUrl,
      ApiParams.isBanned: false,
      ApiParams.isVerify: false,
    });
  }

  void onCallIconTap() {
    Get.back();
  }
}
