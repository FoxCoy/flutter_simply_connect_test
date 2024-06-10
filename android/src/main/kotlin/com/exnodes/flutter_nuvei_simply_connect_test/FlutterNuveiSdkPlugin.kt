package com.exnodes.flutter_nuvei_simply_connect_test

import android.app.Activity
import android.content.Context
import com.google.gson.Gson
import android.util.Log
import com.nuvei.sdk.Callback

import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result

import com.nuvei.sdk.NuveiSimplyConnect
import com.nuvei.sdk.model.*
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding

/** FlutterNuveiSdkPlugin */
class FlutterNuveiSdkPlugin: FlutterPlugin, MethodCallHandler, ActivityAware {
  /// The MethodChannel that will the communication between Flutter and native Android
  ///
  /// This local reference serves to register the plugin with the Flutter Engine and unregister it
  /// when the Flutter Engine is detached from the Activity
  private lateinit var channel : MethodChannel
  private lateinit var context: Context
  private lateinit var activity: Activity
  private val gson = Gson()

  override fun onAttachedToEngine(flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
    channel = MethodChannel(flutterPluginBinding.binaryMessenger, "flutter_nuvei_simply_connect_test")
    channel.setMethodCallHandler(this)
    context = flutterPluginBinding.applicationContext
  }

  override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
    channel.setMethodCallHandler(null)
  }

  override fun onMethodCall(call: MethodCall, result: Result) {
    when (call.method) {
      "setup" -> {
        setup(result, call)
      }
      "checkout" -> {
        checkout(result, call)
      }
      else -> {
        result.notImplemented()
      }
    }
  }

  private fun setup(result: MethodChannel.Result, call: MethodCall) {
    // Set environment
    val environment: String = call.argument("environment")!!
    when (environment) {
      PackageEnvironment.stating -> {
        NuveiSimplyConnect.setup(
          environment = NuveiSimplyConnect.Environment.STAGING,
        );
      }
      else -> {
        NuveiSimplyConnect.setup(
          environment = NuveiSimplyConnect.Environment.PROD,
        );
      }
    }

    result.success(true)
  }

  private fun checkout(result: MethodChannel.Result, call: MethodCall) {
    val sessionToken: String = call.argument("sessionToken")!!
    val merchantId: String = call.argument("merchantId")!!
    val merchantSiteId: String = call.argument("merchantSiteId")!!
    val currency: String = call.argument("currency")!!
    val amount: String = call.argument("amount")!!
    val userTokenId: String = call.argument("userTokenId")!!
    val clientRequestId: String = call.argument("clientRequestId")!!
    val firstName: String = call.argument("firstName")!!
    val lastName: String = call.argument("lastName")!!
    val country: String = call.argument("country")!!
    val email: String = call.argument("email")!!
    val googlePayMerchantId: String = call.argument("googlePayMerchantId")!!
    val googlePayMerchantName: String = call.argument("googlePayMerchantName")!!
    val googlePayGateway: String = call.argument("googlePayGateway")!!
    val googlePayGatewayMerchantId: String = call.argument("googlePayGatewayMerchantId")!!

    val input = NVPayment(
      sessionToken,
      merchantId,
      merchantSiteId,
      googlePayMerchantId,
      googlePayMerchantName,
      googlePayGateway,
      googlePayGatewayMerchantId,
      currency,
      amount,
      PaymentOption(),
      userTokenId,
      clientRequestId,
      billingAddress = BillingAddress(
        firstName = firstName,
        lastName = lastName,
        country = country,
        email = email,
      ),
    )

    writeToLog(gson.toJson(input))
  
    NuveiSimplyConnect.checkout(
      activity = activity,
      input = input,
      forceWebChallenge = true,
      callback = object : Callback<NVOutput> {
        override fun onComplete(response: NVOutput) {
          writeToLog(gson.toJson(response))
          val checkoutResponse = CheckoutResponse(
            result = response.result.uppercase(),
            errCode = response.errorCode,
            errorDescription = response.errorDescription
          )
          val checkoutResponseToJson = gson.toJson(checkoutResponse)
          result.success(checkoutResponseToJson)
        }
      }
    ) { response, activity, declineFallback ->
      writeToLog(gson.toJson(response))
      val checkoutResponse = CheckoutResponse(
        result = response.result.uppercase(),
        errCode = response.errorCode,
        errorDescription = response.errorDescription
      )
      val checkoutResponseToJson = gson.toJson(checkoutResponse)
      result.success(checkoutResponseToJson)
      declineFallback(NuveiSimplyConnect.CheckoutCompletionAction.dismiss)
    }
  }

  private fun writeToLog(log: String) {
    Log.d("Data Print:", log)
  }

  override fun onAttachedToActivity(binding: ActivityPluginBinding) {
    activity = binding.activity
  }

  override fun onDetachedFromActivityForConfigChanges() {
    TODO("Not yet implemented")
  }

  override fun onReattachedToActivityForConfigChanges(binding: ActivityPluginBinding) {
    TODO("Not yet implemented")
  }

  override fun onDetachedFromActivity() {
    TODO("Not yet implemented")
  }
}

class PackageEnvironment {
  companion object {
    const val stating = "STAGING"
    const val production = "PRODUCTION"
  }
}

data class CheckoutResponse(
  val result: String?,
  val errCode: Int?,
  val errorDescription: String?,
)