package com.bixolon.bxlflutterbgatelib;
import androidx.annotation.NonNull;
import io.flutter.embedding.engine.plugins.FlutterPlugin;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;
import com.bixolon.mpos.config.util.MPosControllerLookup;
import com.bixolon.BixolonConst;
import java.util.HashMap;
import java.util.Iterator;
import java.util.concurrent.Semaphore;
import android.content.Context;
import android.hardware.usb.UsbDevice;
import android.hardware.usb.UsbManager;
import android.os.Build;
import org.json.JSONArray;
import org.json.JSONObject;

/** BxlMPosLookupPlugin */
public class BxlMPosLookupPlugin implements FlutterPlugin, MethodCallHandler {
    /// The MethodChannel that will the communication between Flutter and native Android
    ///
    /// This local reference serves to register the plugin with the Flutter Engine and unregister it
    /// when the Flutter Engine is detached from the Activity
    private MethodChannel channel;
    private static String MethodChannel = "com.bixolon.mposlookup";
    private final Semaphore available = new Semaphore(1, true);
    private Context context;

    @Override
    public void onAttachedToEngine(@NonNull FlutterPluginBinding flutterPluginBinding) {
        context = flutterPluginBinding.getApplicationContext();
        channel = new MethodChannel(flutterPluginBinding.getBinaryMessenger(), MethodChannel);
        channel.setMethodCallHandler(this);
    }

    @Override
    public void onMethodCall(@NonNull MethodCall call, @NonNull Result result) {
        class NewRunnable implements Runnable {
            @Override
            public void run() {
                try {
                    available.acquire();
                    switch (call.method)
                    {
                        case "getBluetoothDevices": getBluetoothDevices(result);    break;
                        case "getNetworkDevices":   getNetworkDevices(result);      break;
                        case "getBLEDevices":       getBLEDevices(result);          break;
                        case "getUSBDevices":       getUSBDevices(result);          break;
                        default:                    result.notImplemented();        break;
                    }
                } catch (InterruptedException e) {
                    e.printStackTrace();
                }finally {
                    available.release();
                }
            }
        }
        NewRunnable nr = new NewRunnable() ;
        Thread t = new Thread(nr) ;
        t.start() ;
    }

    @Override
    public void onDetachedFromEngine(@NonNull FlutterPluginBinding binding) {
        channel.setMethodCallHandler(null);
    }

    public void getBluetoothDevices(@NonNull Result result) {
        JSONArray jsonArray = new JSONArray();
        try{
            MPosControllerLookup.MPosDeviceInfo[] deviceInfos = null;
            deviceInfos = MPosControllerLookup.getDeviceList(BixolonConst.MPOS_INTERFACE_BLUETOOTH);
            if(deviceInfos == null) {
                result.success(new JSONArray().toString());
                return;
            }
            for(MPosControllerLookup.MPosDeviceInfo devInfo : deviceInfos) {
                JSONObject jsonItem = new JSONObject();
                jsonItem.put("interface_type",BixolonConst.MPOS_INTERFACE_BLUETOOTH);
                jsonItem.put("address",devInfo.macAddress);
                jsonItem.put("device_name",devInfo.deviceName);
                jsonArray.put(jsonItem);
            }
            result.success(jsonArray.toString());
        }catch(Exception e){
            result.success(jsonArray.toString());
        }
    }

    public void getNetworkDevices(@NonNull Result result) {
        JSONArray jsonArray = new JSONArray();
        try{
            int interfaceType = BixolonConst.MPOS_INTERFACE_WIFI;
            if (BixolonConst.MPOS_SUCCESS != MPosControllerLookup.refreshDeviceList(interfaceType,3)){
                result.success(jsonArray.toString());
                return;
            }
            MPosControllerLookup.MPosDeviceInfo[] deviceInfos = null;
            deviceInfos = MPosControllerLookup.getDeviceList(interfaceType);
            if(deviceInfos == null) {
                result.success(jsonArray.toString());
                return;
            }
            for(MPosControllerLookup.MPosDeviceInfo devInfo : deviceInfos) {
                JSONObject jsonItem = new JSONObject();
                if(devInfo.deviceName.isEmpty()){
                    jsonItem.put("interface_type",(int)devInfo.interfaceType);
                    jsonItem.put("address",devInfo.ipAddress);
                    jsonItem.put("device_name","NETWORK DEVICE");
                }else{
                    jsonItem.put("interface_type",(int)devInfo.interfaceType);
                    jsonItem.put("address",devInfo.ipAddress);
                    jsonItem.put("device_name",devInfo.deviceName);
                }
                jsonArray.put(jsonItem);
            }
            result.success(jsonArray.toString());
        }catch(Exception e){
            result.success(jsonArray.toString());
        }
    }

    public void getUSBDevices(@NonNull Result result) {
        JSONArray jsonArray = new JSONArray();
        try{
            UsbManager manager = (UsbManager) context.getSystemService(context.USB_SERVICE);
            if(manager != null){
                HashMap<String, UsbDevice> deviceList = manager.getDeviceList();
                Iterator<UsbDevice> deviceIterator = deviceList.values().iterator();
                while(deviceIterator.hasNext()){
                    UsbDevice device = deviceIterator.next();
                    JSONObject jsonItem = new JSONObject();
                    jsonItem.put("interface_type", BixolonConst.MPOS_INTERFACE_USB);
                    jsonItem.put("device_name", device.getDeviceName());
                    jsonItem.put("address", "");
                    if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.LOLLIPOP) {
                        jsonItem.put("product_name", device.getProductName());
                    }else{

                        jsonItem.put("product_name", "");
                    }

                    jsonArray.put(jsonItem);
                }
                result.success(jsonArray.toString());
            }
        }catch(Exception e){
            result.success(jsonArray.toString());
        }
    }

    public void getBLEDevices(@NonNull Result result) {
        JSONArray jsonArray = new JSONArray();
        try{
            MPosControllerLookup.MPosDeviceInfo[] deviceInfos = null;
            deviceInfos = MPosControllerLookup.getDeviceList(BixolonConst.MPOS_INTERFACE_BLUETOOTH_LE);
            if(deviceInfos == null) {
                result.success(new JSONArray().toString());
                return;
            }
            for(MPosControllerLookup.MPosDeviceInfo devInfo : deviceInfos) {
                JSONObject jsonItem = new JSONObject();
                jsonItem.put("interface_type",BixolonConst.MPOS_INTERFACE_BLUETOOTH_LE);
                jsonItem.put("address",devInfo.macAddress);
                jsonItem.put("device_name",devInfo.deviceName);
                jsonArray.put(jsonItem);
            }
            result.success(jsonArray.toString());
        }catch(Exception e){
            result.success(jsonArray.toString());
        }
    }
}
