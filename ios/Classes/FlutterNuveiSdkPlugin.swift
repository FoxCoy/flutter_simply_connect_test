import Flutter
import UIKit
import NuveiSimplyConnectSDK

public class FlutterNuveiSdkPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "flutter_nuvei_simply_connect_test", binaryMessenger: registrar.messenger())
    let instance = FlutterNuveiSdkPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    let viewController: UIViewController = (UIApplication.shared.delegate?.window??.rootViewController)!;

    // Method Channel       
    switch call.method {
      case "setup":
        guard let args = call.arguments as? [String : Any] else {return}
        self.setup(result: result, args: args)
        break
      case "checkout":
        guard let args = call.arguments as? [String : Any] else {return}
        self.checkout(result: result, args: args, controller: viewController)
        break
      default:
        result(FlutterMethodNotImplemented)
        break
    }
  }
    
    /* Set environment */
     private func setup(result: FlutterResult, args: [String : Any]) {
       let environment = args["environment"] as! String
       // Nuvei field UI Customization
       let customization = NuveiFieldCustomization (
         labelCustomization: .init(
             textFont: UIFont.systemFont(ofSize: 12),
             textColor: UIColor(hex: "#49516F"),
             headingTextFont: UIFont.systemFont(ofSize: 12),
             headingTextColor: .white
         ),
         textBoxCustomization: .init (
             backgroundColor: .white,
             textFont: UIFont.systemFont(ofSize: 14),
             textColor: .black,
             borderColor: .black,
             cornerRadius: 0,
             borderWidth: 1
         ),
         errorLabelCustomization: .init (
             textFont: UIFont.systemFont(ofSize: 12),
             textColor: UIColor(hex: "#E02D3C")
         ),
         placeholderCustomization: .init (
             textFont: UIFont.systemFont(ofSize: 14),
             textColor: .gray
         ),
         backgroundColor: .white,
         borderColor: .white,
         cornerRadius: 0,
         borderWidth: 1
       )
         
       switch environment {
        case PackageEnvironment.stating:
            NuveiSimplyConnect.setup(environment: NuveiSimplyConnect.Environment.integration)
            NuveiFields.setup(environment: NuveiSimplyConnect.Environment.integration, customization: customization)
            break
        default:
            NuveiSimplyConnect.setup(environment: NuveiSimplyConnect.Environment.production)
            NuveiFields.setup(environment: NuveiSimplyConnect.Environment.production, customization: customization)
            break
       }
         
      result(true)
     }
    
    /* checkout */
    private func checkout(result: @escaping FlutterResult, args: [String : Any], controller: UIViewController) {
      let sessionToken = args["sessionToken"] as! String
      let merchantId = args["merchantId"] as! String
      let merchantSiteId = args["merchantSiteId"] as! String
      let currency = args["currency"] as! String
      let amount = args["amount"] as! String
      let userTokenId = args["userTokenId"] as! String
      let clientRequestId = args["clientRequestId"] as! String
      let firstName = args["firstName"] as! String
      let lastName = args["lastName"] as! String
      let country = args["country"] as! String
      let email = args["email"] as! String
      let applePayMerchantId = args["applePayMerchantId"] as! String
        
            
      let input = NVInput(
        sessionToken: sessionToken,
        merchantId: merchantId,
        applePayMerchantId: applePayMerchantId,
        merchantSiteId: merchantSiteId,
        currency: currency,
        amount: amount,
        paymentOption:  try! NVPaymentOption(
            card: NVCardDetails()
        ),
        userTokenId: userTokenId,
        clientRequestId: clientRequestId,
        billingAddress: NVBillingAddress(
            firstName: firstName,
            lastName: lastName,
            country: country,
            email: email
        )
      );
        
      let inputToJson = self.convertToJson(data: input);
      
      NuveiSimplyConnect.checkout(
        uiOwner: controller,
        authenticate3dInput: input,
        forceWebChallenge: true
      ) { (output: NuveiSimplyConnectSDK.NVCreatePaymentOutput) in
          let checkoutResponse:CheckoutResponse = CheckoutResponse(
            result: output.result.rawValue.uppercased(),
            errCode: output.errorCode,
            errorDescription: output.errorDescription
          )
          let checkoutResponseToJson = self.convertToJson(data: checkoutResponse)
          result(checkoutResponseToJson)
      } declineFallbackDecision: { response, viewController, declineFallback in
          let checkoutResponse:CheckoutResponse = CheckoutResponse(
            result: response.result.rawValue.uppercased(),
            errCode: response.errorCode,
            errorDescription: response.errorDescription
          )
          let checkoutResponseToJson = self.convertToJson(data: checkoutResponse)
          result(checkoutResponseToJson)
          viewController.dismiss(animated: true)
      }
    }
           
    // utils function
    private func convertToJson<T: Encodable>(data: T) -> String {
      let encoder = JSONEncoder()
      encoder.outputFormatting = .prettyPrinted

      let data = try! encoder.encode(data)
      print("===================================")
      print(String(data: data, encoding: .utf8)!)
      
      return String(data: data, encoding: .utf8)!
    }  
}

enum PackageEnvironment {
  static let stating = "STAGING"
  static let production = "PRODUCTION"
}

struct CheckoutResponse: Codable {
  var result: String?
  var errCode: Int?
  var errorDescription: String?
}

extension UIColor {
    convenience init(hex: String) {
        var hexSanitized = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        hexSanitized = hexSanitized.replacingOccurrences(of: "#", with: "")
        
        var rgb: UInt64 = 0
        
        Scanner(string: hexSanitized).scanHexInt64(&rgb)
        
        let red = CGFloat((rgb & 0xFF0000) >> 16) / 255.0
        let green = CGFloat((rgb & 0x00FF00) >> 8) / 255.0
        let blue = CGFloat(rgb & 0x0000FF) / 255.0
        
        self.init(red: red, green: green, blue: blue, alpha: 1.0)
    }
}



