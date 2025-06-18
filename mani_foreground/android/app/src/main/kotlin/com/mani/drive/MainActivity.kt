package com.mani.drive

import android.content.Intent
import androidx.annotation.NonNull
import io.flutter.embedding.android.FlutterFragmentActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodCodec 
import io.flutter.plugin.common.StandardMethodCodec 

class MainActivity : FlutterFragmentActivity() {

    private val channel: MethodChannel by lazy {
        MethodChannel(flutterEngine!!.dartExecutor.binaryMessenger, "com.example.app/channel", StandardMethodCodec.INSTANCE)
    }

    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        channel.setMethodCallHandler { call: MethodCall, result: MethodChannel.Result ->
            if (call.method == "startMainActivity") {
                startMainActivity()
                result.success(null)
            } else {
                result.notImplemented()
            }
        }
    }

    private fun startMainActivity() {
        val intent = Intent(this, MainActivity::class.java)
        intent.flags = Intent.FLAG_ACTIVITY_REORDER_TO_FRONT or Intent.FLAG_ACTIVITY_NEW_TASK or Intent.FLAG_ACTIVITY_CLEAR_TASK
        startActivity(intent)
    }
}