import 'dart:convert';
import 'package:flutter_nuvei_simply_connect_test/data/constants.dart';
import 'package:flutter_nuvei_simply_connect_test/data/enums.dart';
import 'package:flutter_nuvei_simply_connect_test/flutter_nuvei_sdk_platform_interface.dart';
import 'package:flutter_nuvei_simply_connect_test/models/nv_checkout_input.dart';
import 'package:flutter_nuvei_simply_connect_test/models/nv_output.dart';

class FlutterNuveiSdk {
  // Check SDK init success or fail
  static bool isReady = false;

  static Future<void> setup(NVEnvironmentEnum environment) async {
    isReady = await FlutterNuveiSdkPlatform.instance
            .setup(nvEnvironmentText[environment]) ??
        false;
  }

  static Future<NVOutput?> checkout(
    NVCheckoutInput input,
  ) async {
    final Map<String, dynamic> args = input.toJson();
    final String? output =
        await FlutterNuveiSdkPlatform.instance.checkout(args);

    if (output == null) {
      return null;
    }

    final Map<String, dynamic> outputToJson = jsonDecode(output);
    return NVOutput.fromJson(outputToJson);
  }

  static final FlutterNuveiSdk _instance = FlutterNuveiSdk._internal();
  factory FlutterNuveiSdk() {
    return _instance;
  }
  FlutterNuveiSdk._internal();
}
