/* Copyright © 2024 Yesferal Cueva. All rights reserved. */

import 'dart:io';
import 'package:y_auth/domain/abstract/device_info_datasource.dart';
import 'package:device_info_plus/device_info_plus.dart';

class DeviceInfoPlusDatasource extends DeviceInfoDataSource {

  @override
  Future<String> getDeviceName() {
    DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();

    Future<String> deviceName = Platform.isAndroid
        ? _getAndroidDeviceName(deviceInfoPlugin)
        : _getIosDeviceName(deviceInfoPlugin);

    return deviceName;
  }

  Future<String> _getAndroidDeviceName(DeviceInfoPlugin deviceInfoPlugin ) async {
    AndroidDeviceInfo androidDeviceInfo = await deviceInfoPlugin.androidInfo;
    String brand = androidDeviceInfo.brand;
    String model = androidDeviceInfo.model;

    return brand + ": " + model;
  }

  Future<String> _getIosDeviceName(DeviceInfoPlugin deviceInfoPlugin ) async {
    IosDeviceInfo iosDeviceInfo = await deviceInfoPlugin.iosInfo;
    String machine = iosDeviceInfo.utsname.machine;

    return machine;
  }
}
