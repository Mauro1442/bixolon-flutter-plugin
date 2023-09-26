
package com.bixolon.bxlflutterbgatelib;
import android.app.Activity;
import androidx.annotation.NonNull;
import io.flutter.embedding.engine.plugins.FlutterPlugin;
import io.flutter.embedding.engine.plugins.activity.ActivityAware;
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding;
import io.flutter.plugin.common.EventChannel;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;

/** BxlflutterbgatelibPlugin */
public class BxlflutterbgatelibPlugin implements FlutterPlugin, MethodCallHandler, ActivityAware {

  private static Activity activity;

  @Override
  public void onAttachedToEngine(@NonNull FlutterPluginBinding flutterPluginBinding) {
    new BxlMPosLookupPlugin().onAttachedToEngine(flutterPluginBinding);
    new BxlMPosControllerConfigPlugin().onAttachedToEngine(flutterPluginBinding);
    new BxlMPosControllerLabelPrinterPlugin().onAttachedToEngine(flutterPluginBinding);
    new BxlMPosControllerPrinterPlugin().onAttachedToEngine(flutterPluginBinding);
  }
  @Override
  public void onMethodCall(@NonNull MethodCall call, @NonNull Result result) { }
  @Override
  public void onDetachedFromEngine(@NonNull FlutterPluginBinding binding) { }
  @Override
  public void onAttachedToActivity(@NonNull ActivityPluginBinding binding) {
    BxlflutterbgatelibPlugin.activity = binding.getActivity();
  }
  @Override
  public void onReattachedToActivityForConfigChanges(@NonNull ActivityPluginBinding binding) {
    BxlflutterbgatelibPlugin.activity = binding.getActivity();
  }
  @Override
  public void onDetachedFromActivity() {
    BxlflutterbgatelibPlugin.activity = null;
  }
  @Override
  public void onDetachedFromActivityForConfigChanges() {
    BxlflutterbgatelibPlugin.activity = null;
  }

  public static void runInUiThread(EventChannel.EventSink eventSink, Integer param){
    if(BxlflutterbgatelibPlugin.activity == null)
      return;
    if(eventSink == null)
      return;
    BxlflutterbgatelibPlugin.activity.runOnUiThread(() -> {
      try {
        eventSink.success(param);
      } catch (Exception e) {
        e.printStackTrace();
      }
    });
  }
}
