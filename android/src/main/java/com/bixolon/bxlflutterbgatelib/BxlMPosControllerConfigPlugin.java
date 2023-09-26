package com.bixolon.bxlflutterbgatelib;
import android.content.Context;
import androidx.annotation.NonNull;
import io.flutter.embedding.engine.plugins.FlutterPlugin;
import io.flutter.plugin.common.BinaryMessenger;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;
import com.bixolon.mpos.MPosControllerConfig;
import org.json.JSONArray;
import org.json.JSONObject;

import java.nio.charset.Charset;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.concurrent.Semaphore;

/** BxlMPosControllerConfigPlugin */
public class BxlMPosControllerConfigPlugin implements FlutterPlugin, MethodCallHandler {
    /// The MethodChannel that will the communication between Flutter and native Android
    ///
    /// This local reference serves to register the plugin with the Flutter Engine and unregister it
    /// when the Flutter Engine is detached from the Activity
    private MethodChannel channel;
    private MPosControllerConfig config = new MPosControllerConfig();
    private Context context;
    private final Semaphore available = new Semaphore(1, true);

    @Override
    public void onAttachedToEngine(@NonNull FlutterPluginBinding flutterPluginBinding) {
        final String METHOD_CHANNEL = "com.bixolon.mposcontroller/config";
        BinaryMessenger messenger = flutterPluginBinding.getBinaryMessenger();
        context = flutterPluginBinding.getApplicationContext();
        channel = new MethodChannel(messenger, METHOD_CHANNEL);
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
                        case "selectInterface":             selectInterface(call, result); break;
                        case "selectCommandMode":           selectCommandMode(call, result); break;
                        case "openService":                 openService(call, result); break;
                        case "closeService":                closeService(call, result); break;
                        case "isOpen":                      isOpen(call, result); break;
                        case "getDeviceId":                 getDeviceId(call, result); break;
                        case "directIO":                    directIO(call, result); break;
                        case "setReadMode":                 setReadMode(call, result); break;
                        case "setKeepNetworkConnection":    setKeepNetworkConnection(call, result); break;
                        case "setTransaction":              setTransaction(call, result); break;
                        case "searchDevices":               searchDevices(call, result); break;
                        case "getBgateSerialNumber":        getBgateSerialNumber(call, result); break;
                        case "getUSBDevice":                getUSBDevice(call, result); break;
                        case "getCustomDevices":            getCustomDevices(call, result); break;
                        case "getSerialConfig":             getSerialConfig(call, result); break;
                        case "getSerialConfiguration":      getSerialConfiguration(call, result); break;
                        case "setSerialConfig":             setSerialConfig(call, result); break;
                        case "setSerialConfiguration":      setSerialConfiguration(call, result); break;
                        case "addCustomDevice":             addCustomDevice(call, result); break;
                        case "deleteCustomDevice":          deleteCustomDevice(call, result); break;
                        case "reInitCustomDeviceType":      reInitCustomDeviceType(call, result); break;
                        default:
                            result.notImplemented();
                            break;
                    }
                } catch (InterruptedException e) {
                    e.printStackTrace();
                }finally {
                    available.release();
                }
            }
        }
        NewRunnable nr = new NewRunnable();
        Thread t = new Thread(nr);
        t.start();
    }

    @Override
    public void onDetachedFromEngine(@NonNull FlutterPluginBinding binding) {
        channel.setMethodCallHandler(null);
    }

    private Object getValue(@NonNull MethodCall call, @NonNull String key, @NonNull Object defaultValue) {
        return call.argument(key) == null ? defaultValue : call.argument(key);
    }

    public void selectInterface(@NonNull MethodCall call, @NonNull Result result) {
        Integer interfaceType = (Integer)getValue(call, "interface_type", -1);
        String address = (String)getValue(call, "address", "");
        try{
            result.success((int)config.selectInterface(interfaceType, address));
        }catch(Exception e){
            result.success(1000);
        }
    }

    public void selectCommandMode(@NonNull MethodCall call, @NonNull Result result) {
        Integer mode = (Integer)getValue(call, "command_mode", -1);
        try{
            result.success((int)config.selectCommandMode(mode));
        }catch(Exception e){
            result.success(1000);
        }
    }

    public void openService(@NonNull MethodCall call, @NonNull Result result) {
        Integer id = (Integer)getValue(call, "device_id", -1);
        Integer timeout = (Integer)getValue(call, "time_out", 3);
        try{
            config.setTimeout(timeout);
            result.success(config.openService(id, context));
        }catch(Exception e){
            result.success(1000);
        }
    }

    public void closeService(@NonNull MethodCall call, @NonNull Result result) {
        Integer timeout = (Integer)getValue(call, "time_out", 3);
        try{
            result.success((int)config.closeService(timeout));
        }catch(Exception e){
            result.success(1000);
        }
    }

    public void isOpen(@NonNull MethodCall call, @NonNull Result result) {
        try{
            result.success(config.isOpen() ? 1 : 0);
        }catch(Exception e){
            result.success(0);
        }
    }

    public void getDeviceId(@NonNull MethodCall call, @NonNull Result result) {
        try{
            result.success((int)config.getDeviceId());
        }catch(Exception e){
            result.success(-1);
        }
    }

    public void directIO(@NonNull MethodCall call, @NonNull Result result) {
        ArrayList<Integer> dataArray = call.argument("data_array") == null ? null : call.argument("data_array");
        if(dataArray == null){
            result.success(1000);
            return;
        }
        try{
            int index = 0;
            byte[] byteArray = new byte[dataArray.toArray().length];
            Iterator<Integer> iterator = dataArray.iterator();
            while(iterator.hasNext()){
                byteArray[index++] = iterator.next().byteValue();
            }
            result.success((int)config.directIO(byteArray));
        }catch(Exception e){
            result.success(1000);
        }
    }

    public void setReadMode(@NonNull MethodCall call, @NonNull Result result) {
        Integer mode = (Integer)getValue(call, "read_mode", -1);
        try{
            result.success((int)config.setReadMode(mode));
        }catch(Exception e){
            result.success(1000);
        }
    }

    public void setKeepNetworkConnection(@NonNull MethodCall call, @NonNull Result result) {
        Integer keep_connection = (Integer)getValue(call, "keep_connection", 0);
        result.success(1000);
    }

    public void setTransaction(@NonNull MethodCall call, @NonNull Result result) {
        Integer transaction = (Integer)getValue(call, "transaction", -1);
        try{
            result.success((int)config.setTransaction(transaction));
        }catch(Exception e){
            result.success(1000);
        }
    }

    public void searchDevices(@NonNull MethodCall call, @NonNull Result result) {
        JSONArray jsonArray = new JSONArray();
        try{
            int[] devices = config.searchDevices();
            if(devices == null){
                result.success(jsonArray.toString());
                return;
            }
            for(int index = 0; index < devices.length; index++){
                JSONObject jsonItem = new JSONObject();
                jsonItem.put("device_id", (int)devices[index]);
                if(devices[index] > 0 && devices[index] < 10)           jsonItem.put("device_type", "LABEL PRINTER");
                else if(devices[index] >= 10 && devices[index] < 20)    jsonItem.put("device_type", "POS PRINTER");
                else if(devices[index] >= 20 && devices[index] < 30)    jsonItem.put("device_type", "Unregistered HID INPUT DEVICE");
                else if(devices[index] >= 30 && devices[index] < 40)    jsonItem.put("device_type", "MSR");
                else if(devices[index] >= 40 && devices[index] < 50)    jsonItem.put("device_type", "BARCODE SCANNER");
                else if(devices[index] >= 60 && devices[index] < 70)    jsonItem.put("device_type", "RFID");
                else if(devices[index] >= 70 && devices[index] < 80)    jsonItem.put("device_type", "DALLAS READER");
                else if(devices[index] >= 80 && devices[index] < 90)    jsonItem.put("device_type", "NFC");
                else if(devices[index] >= 100 && devices[index] < 110)  jsonItem.put("device_type", "Unregistered USB-SERIAL");
                else if(devices[index] >= 110 && devices[index] < 120)  jsonItem.put("device_type", "CUSTOMER DISPLAY");
                else if(devices[index] >= 120 && devices[index] < 130)  jsonItem.put("device_type", "USB-SERIAL");
                else if(devices[index] >= 130 && devices[index] < 140)  jsonItem.put("device_type", "SCALE");
                else                                                    jsonItem.put("device_type", "UNKNOWN");
                // add json string
                jsonArray.put(jsonItem);
            }
            result.success(jsonArray.toString());
        }catch(Exception e){
            result.success(jsonArray.toString());
        }

    }

    public void getBgateSerialNumber(@NonNull MethodCall call, @NonNull Result result) {
        try{
            byte[] bytes = config.getBGateSerialNumber();
            if(bytes != null){
                result.success(new String(bytes, Charset.forName("UTF-8")));
            }else{
                result.success("");
            }
        }catch(Exception e){
            result.success("");
        }
    }

    public void getUSBDevice(@NonNull MethodCall call, @NonNull Result result) {
        Integer device_id = (Integer)getValue(call, "device_id", -1);
        try{
            String resultString = config.getUSBDevice(device_id);
            //byte[] test = resultString.getBytes(Charset.forName("UTF-8"));
            result.success(resultString);
        }catch(Exception e){
            result.success("");
        }
    }

    public void getCustomDevices(@NonNull MethodCall call, @NonNull Result result) {
        Integer device_type = (Integer)getValue(call, "device_type", -1);
        try{
            String resultString = config.getCustomDeviceList(device_type);
            result.success(resultString);
        }catch(Exception e){
            result.success(new ArrayList<String>());
        }
    }

    public void getSerialConfig(@NonNull MethodCall call, @NonNull Result result) {
        Integer device_id = (Integer)getValue(call, "device_id", -1);
        try{
            byte[] configs = config.getSerialConfiguration(device_id);
            if(configs == null){
                result.success(new ArrayList<Integer>());
                return;
            }
            ArrayList<Integer> list = new ArrayList<Integer>();
            for(int index = 0; index < configs.length; index++){
                list.add((int) configs[index]);
            }
            result.success(list);
        }catch(Exception e){
            result.success(new ArrayList<Integer>());
        }
    }

    public void getSerialConfiguration(@NonNull MethodCall call, @NonNull Result result) {
        Integer device_id = (Integer)getValue(call, "device_id", -1);
        try{
            byte[] configs = config.getSerialConfiguration(device_id);
            if(configs == null){
                result.success(new ArrayList<Integer>());
                return;
            }
            ArrayList<Integer> list = new ArrayList<Integer>();
            for(int index = 0; index < configs.length; index++){
                list.add((int) configs[index]);
            }
            result.success(list);
        }catch(Exception e){
            result.success(new ArrayList<Integer>());
        }
    }

    public void setSerialConfig(@NonNull MethodCall call, @NonNull Result result) {
        Integer device_id = (Integer)getValue(call, "device_id", -1);
        Integer baud_rate = (Integer)getValue(call, "baud_rate", 2);
        Integer data_bit = (Integer)getValue(call, "data_bit", 1);
        Integer stop_bit = (Integer)getValue(call, "stop_bit", 0);
        Integer parity_bit = (Integer)getValue(call, "parity_bit", 0);
        Integer flow_control = (Integer)getValue(call, "flow_control", 1);
        try{
            long res = config.setSerialConfiguration(device_id,
                    baud_rate.byteValue(),
                    data_bit.byteValue(),
                    stop_bit.byteValue(),
                    parity_bit.byteValue(),
                    flow_control.byteValue());
            result.success(res);
        }catch (Exception e){
            result.success(1000);
        }
    }

    public void setSerialConfiguration(@NonNull MethodCall call, @NonNull Result result) {
        Integer device_id = (Integer)getValue(call, "device_id", -1);
        Integer baud_rate = (Integer)getValue(call, "baud_rate", 2);
        Integer data_bit = (Integer)getValue(call, "data_bit", 1);
        Integer stop_bit = (Integer)getValue(call, "stop_bit", 0);
        Integer parity_bit = (Integer)getValue(call, "parity_bit", 0);
        Integer flow_control = (Integer)getValue(call, "flow_control", 1);
        try{
            long res = config.setSerialConfiguration(device_id,
                    baud_rate.byteValue(),
                    data_bit.byteValue(),
                    stop_bit.byteValue(),
                    parity_bit.byteValue(),
                    flow_control.byteValue());
            result.success(res);
        }catch (Exception e){
            result.success(1000);
        }
    }

    public void addCustomDevice(@NonNull MethodCall call, @NonNull Result result) {
        Integer device_type = (Integer)getValue(call, "device_type", -1);
        String vid = (String) getValue(call, "vid", "");
        String pid = (String) getValue(call, "pid", "");
        try{
            result.success(config.addCustomDevice(device_type, vid, pid));
        }catch(Exception e){
            result.success("");
        }
    }

    public void deleteCustomDevice(@NonNull MethodCall call, @NonNull Result result) {
        Integer device_type = (Integer)getValue(call, "device_type", -1);
        String vid = (String) getValue(call, "vid", "");
        String pid = (String) getValue(call, "pid", "");
        try{
            result.success(config.deleteCustomDevice(device_type, vid, pid));
        }catch(Exception e){
            result.success("");
        }
    }

    public void reInitCustomDeviceType(@NonNull MethodCall call, @NonNull Result result) {
        Integer device_type = (Integer)getValue(call, "device_type", -1);
        try{
            result.success(config.resetCustomDeviceList(device_type));
        }catch(Exception e){
            result.success("");
        }
    }
}


