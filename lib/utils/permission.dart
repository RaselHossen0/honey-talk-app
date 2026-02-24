import 'dart:io';

import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:tingle/utils/enums.dart';
import 'package:tingle/utils/utils.dart';

class AppPermission {
  static Future<void> onGetCameraPermission({
    required Callback onGranted,
    Callback? onDenied,
  }) async {
    try {
      PermissionStatus status = await Permission.camera.request();

      if (status == PermissionStatus.denied) {
        Utils.showToast(text: EnumLocal.txtPleaseAllowCameraPermission.name.tr);
        onDenied?.call();
      } else if (status == PermissionStatus.permanentlyDenied) {
        Utils.showToast(text: EnumLocal.txtPleaseAllowCameraPermission.name.tr);
        if (Platform.isAndroid) await openAppSettings();
        onDenied?.call();
      } else {
        Utils.showLog("Camera Permission Granted");
        onGranted.call();
      }
    } catch (e) {
      onDenied?.call();
      Utils.showLog("Camera Permission Failed => $e");
    }
  }

  static Future<void> onGetMicrophonePermission({
    required Callback onGranted,
    Callback? onDenied,
  }) async {
    try {
      PermissionStatus status = await Permission.microphone.request();

      if (status == PermissionStatus.denied) {
        Utils.showToast(text: EnumLocal.txtPleaseAllowMicrophonePermission.name.tr);
        onDenied?.call();
      } else if (status == PermissionStatus.permanentlyDenied) {
        Utils.showToast(text: EnumLocal.txtPleaseAllowMicrophonePermission.name.tr);
        if (Platform.isAndroid) await openAppSettings();
        onDenied?.call();
      } else {
        Utils.showLog("Microphone Permission Granted");
        onGranted.call();
      }
    } catch (e) {
      onDenied?.call();
      Utils.showLog("Microphone Permission Failed => $e");
    }
  }
}
