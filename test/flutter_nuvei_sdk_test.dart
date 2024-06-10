// import 'package:flutter_nuvei_simply_connect_test/flutter_nuvei_sdk_main.dart';
// import 'package:flutter_nuvei_simply_connect_test/flutter_nuvei_sdk_method_channel.dart';
import 'package:flutter_nuvei_simply_connect_test/flutter_nuvei_sdk_platform_interface.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockFlutterNuveiSdkPlatform
    with MockPlatformInterfaceMixin
    implements FlutterNuveiSdkPlatform {
  @override
  Future<bool?> setup(String environment) {
    throw UnimplementedError();
  }

  @override
  Future<String?> checkout(Map<String, dynamic> args) {
    throw UnimplementedError();
  }
}

void main() {
  // final FlutterNuveiSdkPlatform initialPlatform =
  //     FlutterNuveiSdkPlatform.instance;

  // test('$MethodChannelFlutterNuveiSdk is the default instance', () {
  //   expect(initialPlatform, isInstanceOf<MethodChannelFlutterNuveiSdk>());
  // });

  // test('getPlatformVersion', () async {
  //   FlutterNuveiSdk flutterNuveiSdkPlugin = FlutterNuveiSdk();
  //   MockFlutterNuveiSdkPlatform fakePlatform = MockFlutterNuveiSdkPlatform();
  //   FlutterNuveiSdkPlatform.instance = fakePlatform;
  // });
}
