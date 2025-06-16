package com.example.comment1;

import android.util.Log;
import androidx.annotation.NonNull;

import flutter.overlay.window.flutter_overlay_window.OverlayService;
import io.flutter.embedding.engine.FlutterEngine;
import io.flutter.plugin.common.MethodChannel;

public class OverlayServiceEntry extends OverlayService {
    private static final String CHANNEL = "com.example.overlay_message";

    // 不要加 @Override
    public void configureFlutterEngine(@NonNull FlutterEngine flutterEngine) {
        Log.d("OverlayServiceEntry", "Overlay Service FlutterEngine configured");

        new MethodChannel(flutterEngine.getDartExecutor().getBinaryMessenger(), CHANNEL)
                .setMethodCallHandler((call, result) -> {
                    if ("printFromOverlay".equals(call.method)) {
                        String msg = call.argument("msg");
                        Log.d("OverlayServiceEntry", "收到Overlay消息: " + msg);
                        result.success("收到：" + msg);
                    } else {
                        result.notImplemented();
                    }
                });
    }
}
