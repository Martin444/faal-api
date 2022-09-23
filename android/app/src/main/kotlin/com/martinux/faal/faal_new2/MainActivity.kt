package com.martinux.faal.faal_new2

import android.os.Bundle
import android.content.Intent
import android.content.Context
import android.app.Activity
import android.telephony.ims.RegistrationManager
import android.util.Log
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.EventChannel
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.common.MethodChannel.Result
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.embedding.engine.FlutterEngineCache
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import com.mercadopago.android.px.core.MercadoPagoCheckout
import com.mercadopago.android.px.model.Payment
import com.mercadopago.android.px.model.exceptions.MercadoPagoError
import com.google.gson.Gson
import androidx.annotation.NonNull

class MainActivity: FlutterActivity(), EventChannel.StreamHandler {
    private val TAG = "eventchannelsample"; 
    private val REQUEST_CODE = 1;
    private var applicationContext: Context? = null
    private var activityPluginBinding: ActivityPluginBinding? = null
    private var eventResponseSink: EventChannel.EventSink? = null
    private var result: Result? = null
    private var requestCode = 1

    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine ) {
    super.configureFlutterEngine(flutterEngine)
    val channel = MethodChannel(flutterEngine.dartExecutor.binaryMessenger, "faal.martinfarel.com/faal")
        channel.setMethodCallHandler { methodCall, result ->
            val args = methodCall.arguments as HashMap<*, *>;
            val publicKey = args["publicKey"] as String;
            val preferenceId = args["preferenceId"] as String;
            when (methodCall.method) {
                "mercadoPago" -> mercadoPago(publicKey, preferenceId, result)
                else -> result.notImplemented()
            }
        }
        Log.e(TAG, "===============Channel adding listener=============");
        val channelResponse = EventChannel(flutterEngine.dartExecutor.binaryMessenger, "faal.martinfarel.com/response")
        channelResponse.setStreamHandler(this)
    }

    private fun mercadoPago(publicKey: String, preferenceId: String, result: MethodChannel.Result) {
        this.result = result
        Log.w(TAG, "==============Start Checkout=============");
         val checkout = MercadoPagoCheckout.Builder(publicKey, preferenceId).build();
         checkout.startPayment(this@MainActivity, REQUEST_CODE);
    }

    override fun onActivityResult(requestCode: Int, resultCode: Int, data: Intent?) {
        Log.w(TAG, "==============Result MP=============>" + requestCode + " " + resultCode + " " + data);
        if (requestCode == this.requestCode) {
          onMercadoPagoResult(resultCode, data)
        }
    }

    private fun onMercadoPagoResult(resultCode: Int, data: Intent?) {
        val response = HashMap<String, Any>()
        response["resultCode"] = "$resultCode"
        when {
          isSuccessResult(resultCode) -> {
            response["payment"] = getPaymentFromData(data)
          }
          isErrorResult(resultCode, data) -> {
            response["error"] = getErrorFromData(data).message
          }
          else -> {
            response["error"] = "Canceled"
          }
        }

        eventResponseSink!!.success(Gson().toJson(response))
    }

    private fun isErrorResult(resultCode: Int, data: Intent?) =
    resultCode == Activity.RESULT_CANCELED && data != null && data.extras != null

    private fun isSuccessResult(resultCode: Int) =
    resultCode == MercadoPagoCheckout.PAYMENT_RESULT_CODE

    private fun getPaymentFromData(data: Intent?): Payment {
        return data!!.getSerializableExtra(MercadoPagoCheckout.EXTRA_PAYMENT_RESULT) as Payment
    }

    private fun getErrorFromData(data: Intent?): MercadoPagoError {
        return data!!.getSerializableExtra(MercadoPagoCheckout.EXTRA_ERROR) as MercadoPagoError
    }

    override fun onListen(arguments: Any?, events: EventChannel.EventSink?) {
        eventResponseSink = events
    }

    override fun onCancel(arguments: Any?) {
        eventResponseSink = null
    }
}
