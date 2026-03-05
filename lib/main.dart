import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_branch_sdk/flutter_branch_sdk.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:tingle/notification/notification_services.dart';
import 'package:tingle/routes/app_pages.dart';
import 'package:tingle/routes/app_routes.dart';
import 'package:tingle/utils/assets.dart';
import 'package:tingle/utils/constant.dart';
import 'package:tingle/utils/database.dart';
import 'package:tingle/utils/platform_device_id.dart';
import 'package:tingle/utils/utils.dart';

import 'localization/locale_constant.dart';
import 'localization/localizations_delegate.dart';
import 'utils/internet_connection.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await 500.milliseconds.delay();

  InternetConnection.init();

  await Firebase.initializeApp();

  await GetStorage.init();

  NotificationServices.init();
  NotificationServices.firebaseInit();
  FirebaseMessaging.onBackgroundMessage(NotificationServices.onShowBackgroundNotification);

  final identity = await PlatformDeviceId.getDeviceId ?? "";
  String fcmToken = "";
  try {
    fcmToken = await FirebaseMessaging.instance.getToken() ?? "";
  } catch (e) {
    Utils.showLog("FCM token not available yet (e.g. APNS not set on iOS): $e");
  }

  Utils.showLog("Device Id => $identity");
  Utils.showLog("FCM Token => ${fcmToken.isEmpty ? '(empty)' : 'ok'}");

  if (identity.isNotEmpty) {
    await Database.init(identity, fcmToken);
  }

  await onSecureScreen();

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  // static final StreamController purchaseStreamController = StreamController<PurchaseDetails>.broadcast();

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  @override
  void initState() {
    Utils.isAppOpen.value = true;
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  void dispose() {
    Utils.isAppOpen.value = false;
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      Utils.isAppOpen.value = true;
      Utils.showLog("User Back To App...");
    }
    if (state == AppLifecycleState.inactive) {
      Utils.isAppOpen.value = false;
      Utils.showLog("User Try To Exit...");
    }
  }

  @override
  void didChangeDependencies() {
    getLocale().then((locale) {
      setState(() {
        Utils.showLog("Preference LanguageCode => ${locale.languageCode}");
        Utils.showLog("GetX locale LanguageCode => ${Get.locale?.languageCode ?? ""}");
        Get.updateLocale(locale);
      });
    });
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(
        textScaler: const TextScaler.linear(1.0),
        devicePixelRatio: 1.0,
      ),
      child: GetMaterialApp(
        title: "HoneyTalk",
        debugShowCheckedModeBanner: false,
        getPages: AppPages.list,
        initialRoute: AppRoutes.initial,
        translations: AppLanguages(),
        fallbackLocale: const Locale(AppConstant.languageEn, AppConstant.countryCodeEn),
        locale: const Locale(AppConstant.languageEn),
      ),
    );
  }
}

// ********************************************************************************************************************************************
Future<void> onPrecacheAllImage(BuildContext context) async {
  await Future.wait([
    precacheImage(AssetImage(AppAssets.imgDarkBg), context),
    precacheImage(AssetImage(AppAssets.imgLightBg), context),
    precacheImage(AssetImage(AppAssets.icSelectedStream), context),
    precacheImage(AssetImage(AppAssets.icSelectedParty), context),
    precacheImage(AssetImage(AppAssets.icSelectedFeed), context),
    precacheImage(AssetImage(AppAssets.icSelectedMessage), context),
    precacheImage(AssetImage(AppAssets.icSelectedProfile), context),
    precacheImage(AssetImage(AppAssets.icStream), context),
    precacheImage(AssetImage(AppAssets.icParty), context),
    precacheImage(AssetImage(AppAssets.icFeed), context),
    precacheImage(AssetImage(AppAssets.icMessage), context),
    precacheImage(AssetImage(AppAssets.icProfile), context),
    precacheImage(AssetImage(AppAssets.imgNoDataFoundPlaceHolder), context),
  ]);
}

Future<void> onInitializeBranchIo() async {
  try {
    await FlutterBranchSdk.init().then((value) {
      // FlutterBranchSdk.validateSDKIntegration();
    });
  } catch (e) {
    Utils.showLog("Initialize Branch Io Failed !! => $e");
  }
}

// 😘Good morning, Have a nice day!😘 ❤️
//   Best place of mountain adventure....

Future<void> onSecureScreen() async {
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
}
