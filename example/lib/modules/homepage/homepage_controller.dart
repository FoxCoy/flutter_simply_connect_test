import 'package:flutter/services.dart';
import 'package:flutter_nuvei_simply_connect_test/flutter_nuvei_sdk.dart';
import 'package:get/get.dart';

class HomePageController extends GetxController {
  @override
  void onInit() {
    initializer();
    super.onInit();
  }

  Future<void> initializer() async {
    try {
      await FlutterNuveiSdk.setup(NVEnvironmentEnum.staging);
    } on PlatformException {
      print("initializer error");
    }
  }

  Future<void> checkout() async {
    const String sessionToken = "";
    const String clientRequestId = "";
    const String merchantId = "";
    const String merchantSiteId = "";
    const String currency = 'USD';
    const String amount = "151";
    const String userTokenId = "1";
    const String firstName = "User";
    const String lastName = "Test";
    const String country = "US";
    const String email = "usertest123@gmail.com";
    const String googlePayMerchantId = "BCR2DN6TZ6DP7P3X";
    const String googlePayMerchantName = "Google Pay web SDK";
    const String googlePayGateway = "nuveidigital";
    const String googlePayGatewayMerchantId = "googletest"; // nuveidigital
    const String applePayMerchantId = "merchant.com.nuveidigital.test";

    try {
      final NVCheckoutInput input = NVCheckoutInput(
        sessionToken: sessionToken,
        merchantId: merchantId,
        merchantSiteId: merchantSiteId,
        currency: currency,
        amount: amount,
        userTokenId: userTokenId,
        clientRequestId: clientRequestId,
        firstName: firstName,
        lastName: lastName,
        country: country,
        email: email,
        googlePayMerchantId: googlePayMerchantId,
        googlePayMerchantName: googlePayMerchantName,
        googlePayGateway: googlePayGateway,
        googlePayGatewayMerchantId: googlePayGatewayMerchantId,
        applePayMerchantId: applePayMerchantId,
      );
      final NVOutput? resultCheckout = await FlutterNuveiSdk.checkout(input);
      print("=================");
      print(resultCheckout);
      print("=================");
    } on PlatformException {
      print("checkout error");
    }
  }
}

// ====> Session token get from this api <====
// curl --location 'https://ppp-test.safecharge.com/ppp/api/openOrder.do' \
// --header 'Content-Type: application/json' \
// --header 'Cookie: JSESSIONID=19f6bddec634aa371eb982a1438e' \
// --data '{
//     "merchantSiteId": "",
//     "merchantId": "",
//     "clientRequestId": "",
//     "timeStamp": "20240610170914",
//     "checksum": "",
//     "amount": "151",
//     "currency": "USD",
//     "userTokenId": 1
// }'