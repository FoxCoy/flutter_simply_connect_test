class NVCheckoutInput {
  late final String sessionToken;
  late final String merchantId;
  late final String merchantSiteId;
  late final String currency;
  late final String amount;
  late final String userTokenId;
  late final String clientRequestId;
  late final String firstName;
  late final String lastName;
  late final String country;
  late final String email;
  late final String googlePayMerchantId;
  late final String googlePayMerchantName;
  late final String googlePayGateway;
  late final String googlePayGatewayMerchantId;
  late final String applePayMerchantId;

  NVCheckoutInput({
    required this.sessionToken,
    required this.merchantId,
    required this.merchantSiteId,
    required this.currency,
    required this.amount,
    required this.userTokenId,
    required this.clientRequestId,
    required this.firstName,
    required this.lastName,
    required this.country,
    required this.email,
    required this.googlePayMerchantId,
    required this.googlePayMerchantName,
    required this.googlePayGateway,
    required this.googlePayGatewayMerchantId,
    required this.applePayMerchantId,
  });

  NVCheckoutInput.fromJson(Map<String, dynamic> json) {
    sessionToken = json['sessionToken'];
    merchantId = json['merchantId'];
    merchantSiteId = json['merchantSiteId'];
    currency = json['currency'];
    amount = json['amount'];
    userTokenId = json['userTokenId'];
    clientRequestId = json['clientRequestId'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    country = json['country'];
    email = json['email'];
    googlePayMerchantId = json['googlePayMerchantId'];
    googlePayMerchantName = json['googlePayMerchantName'];
    googlePayGateway = json['googlePayGateway'];
    googlePayGatewayMerchantId = json['googlePayGatewayMerchantId'];
    applePayMerchantId = json['applePayMerchantId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['sessionToken'] = sessionToken;
    data['merchantId'] = merchantId;
    data['merchantSiteId'] = merchantSiteId;
    data['currency'] = currency;
    data['amount'] = amount;
    data['userTokenId'] = userTokenId;
    data['clientRequestId'] = clientRequestId;
    data['firstName'] = firstName;
    data['lastName'] = lastName;
    data['country'] = country;
    data['email'] = email;
    data['googlePayMerchantId'] = googlePayMerchantId;
    data['googlePayMerchantName'] = googlePayMerchantName;
    data['googlePayGateway'] = googlePayGateway;
    data['googlePayGatewayMerchantId'] = googlePayGatewayMerchantId;
    data['applePayMerchantId'] = applePayMerchantId;
    return data;
  }
}
