
package com.bixolon.bxlflutterbgatelib;
import androidx.annotation.NonNull;
import android.app.Activity;
import android.content.Context;
import android.net.Uri;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.concurrent.Semaphore;
import io.flutter.embedding.engine.plugins.FlutterPlugin;
import io.flutter.plugin.common.BinaryMessenger;
import io.flutter.plugin.common.EventChannel;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;
import com.bixolon.BixolonConst;
import com.bixolon.mpos.MPosControllerPrinter;
import com.bixolon.mpos.print.FontAttribute;
import com.bixolon.mpos.event.StatusUpdateEvent;
import com.bixolon.mpos.event.StatusUpdateListener;

/** BxlMPosControllerPrinterPlugin */
public class BxlMPosControllerPrinterPlugin implements FlutterPlugin, MethodCallHandler, StatusUpdateListener{
    /// The MethodChannel that will the communication between Flutter and native Android
    ///
    /// This local reference serves to register the plugin with the Flutter Engine and unregister it
    /// when the Flutter Engine is detached from the Activity
    private MethodChannel channel;
    private MPosControllerPrinter printer = new MPosControllerPrinter();
    private Context context;
    private EventChannel.EventSink outputCompletedEventSink;
    private EventChannel.EventSink printerStatusEventSink;
    private final Semaphore available = new Semaphore(1, true);
    private Integer commandMode = 0; /*BY-PASS*/
    private Activity activity;

    @Override
    public void onAttachedToEngine(@NonNull FlutterPluginBinding flutterPluginBinding) {
        final String METHOD_CHANNEL = "com.bixolon.mposcontroller/printer";
        final String EVENT_CHANNEL_1 = "com.bixolon.mposcontroller/printer/outputcompleted";
        final String EVENT_CHANNEL_2 = "com.bixolon.mposcontroller/printer/status";

        BinaryMessenger messenger = flutterPluginBinding.getBinaryMessenger();
        printer.addStatusUpdateListener(this);
        context = flutterPluginBinding.getApplicationContext();
        channel = new MethodChannel(messenger, METHOD_CHANNEL);
        channel.setMethodCallHandler(this);
        EventChannel outputCompletedChannel = new EventChannel(messenger, EVENT_CHANNEL_1);
        EventChannel printerStatusChannel = new EventChannel(messenger, EVENT_CHANNEL_2);

        // https://github.com/testfairy-blog/FlutterEventChannels/blob/master/android/app/src/main/java/com/example/flutter_plugin_playground/MainActivity.java
        outputCompletedChannel.setStreamHandler(new EventChannel.StreamHandler(){
            @Override
            public void onListen(Object listener, EventChannel.EventSink eventSink) { outputCompletedEventSink = eventSink; }
            @Override
            public void onCancel(Object listener) { outputCompletedEventSink = null; }
        });

        printerStatusChannel.setStreamHandler(new EventChannel.StreamHandler(){
            @Override
            public void onListen(Object listener, EventChannel.EventSink eventSink) {
                printerStatusEventSink = eventSink;
            }
            @Override
            public void onCancel(Object listener) {
                printerStatusEventSink = null;
            }
        });
    }

    @Override
    public void statusUpdateOccurred(StatusUpdateEvent statusUpdateEvent) {
        if(printerStatusEventSink == null)
            return;
        int status = statusUpdateEvent.getStatus();
        switch (status){
            case (int)BixolonConst.MPOS_STATUS_NORMAL:
            case (int)BixolonConst.MPOS_STATUS_PRINTER_COVEROPEN:
            case (int)BixolonConst.MPOS_STATUS_PRINTER_PAPEREMPTY:
            case (int)BixolonConst.MPOS_STATUS_PRINTER_PAPER_NEAREND:
            case (int)BixolonConst.MPOS_STATUS_PRINTER_ERROR:
            case (int)BixolonConst.MPOS_STATUS_BATT_LOW:
            case (int)BixolonConst.MPOS_STATUS_DRAWER_LOW:
            case (int)BixolonConst.MPOS_STATUS_DRAWER_HIGH:
                // 메인 쓰레드 (UI)쓰레드에서 이벤트 발생하도록 수정
                BxlflutterbgatelibPlugin.runInUiThread(printerStatusEventSink, status);
                break;
            default:
                break;
        }
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
                        // COMMON
                        case "selectInterface":                 selectInterface(call, result); break;
                        case "selectCommandMode":               selectCommandMode(call, result); break;
                        case "openService":                     openService(call, result); break;
                        case "closeService":                    closeService(call, result); break;
                        case "isOpen":                          isOpen(call, result); break;
                        case "getDeviceId":                     getDeviceId(call, result); break;
                        case "directIO":                        directIO(call, result); break;
                        case "setReadMode":                     setReadMode(call, result); break;
                        case "setKeepNetworkConnection":        setKeepNetworkConnection(call, result); break;
                        case "setTransaction":                  setTransaction(call, result); break;
                        // ASB
                        case "asbEnable":                       asbEnable(call, result); break;
                        // CHARACTER SET
                        case "setCharacterset":                 setCharacterset(call, result); break;
                        case "setInternationalCharacterset":    setInternationalCharacterset(call, result); break;
                        // PAGE MODE
                        case "setPagemode":                     setPagemode(call, result); break;
                        case "setPagemodePrintArea":            setPagemodePrintArea(call, result); break;
                        case "setPagemodeDirection":            setPagemodeDirection(call, result); break;
                        case "setPagemodePosition":             setPagemodePosition(call, result); break;
                        // PRINT
                        case "printText":                       printText(call, result); break;
                        case "printImageFile":                  printImageFile(call, result); break;
                        case "printBase64Image":                printBase64Image(call, result); break;
                        case "printPDFFile":                    printPDFFile(call, result); break;
                        case "print1DBarcode":                  print1DBarcode(call, result); break;
                        case "printQRCode":                     printQRCode(call, result); break;
                        case "printPDF417":                     printPDF417(call, result); break;
                        case "printDataMatrix":                 printDataMatrix(call, result); break;
                        case "printGS1Databar":                 printGS1Databar(call, result); break;
                        case "printGS1DatabarMobile":           printGS1DatabarMobile(call, result); break;
                        case "printCompositeSymbology":         printCompositeSymbology(call, result); break;
                        case "printMaxicode":                   printMaxicode(call, result); break;
                        case "printAztec":                      printAztec(call, result); break;
                        case "printLine":                       printLine(call, result); break;
                        case "printBox":                        printBox(call, result); break;
                        case "cutPaper":                        cutPaper(call, result); break;
                        case "openDrawer":                      openDrawer(call, result); break;
                        case "checkPrinterStatus":              checkPrinterStatus(call, result); break;
                        case "checkBattStatus":                 checkBattStatus(call, result); break;
                        case "getModelName":                    getModelName(call, result); break;
                        case "getFirmwareVersion":              getFirmwareVersion(call, result); break;
                        case "getStatisticsData":               getStatisticsData(call, result); break;
                        // MSR
                        case "msrReady":                        msrReady(call, result); break;
                        case "getTrack1Data":                   getTrack1Data(call, result); break;
                        case "getTrack2Data":                   getTrack2Data(call, result); break;
                        case "getTrack3Data":                   getTrack3Data(call, result); break;
                        // SCR
                        case "powerUpSCR":                      powerUpSCR(call, result); break;
                        case "powerDownSCR":                    powerDownSCR(call, result); break;
                        case "setSCROperationMode":             setSCROperationMode(call, result); break;
                        case "exchangeSCRData":                 exchangeSCRData(call, result); break;
                        case "getSCRCardStatus":                getSCRCardStatus(call, result); break;
                        // BCD
                        case "displayString":                   displayString(call, result); break;
                        case "clearScreen":                     clearScreen(call, result); break;
                        case "storeImageFile":                  storeImageFile(call, result); break;
                        case "storeBase64Image":                storeBase64Image(call, result); break;
                        case "displayImage":                    displayImage(call, result); break;
                        case "clearImage":                      clearImage(call, result); break;
                        case "showCursor":                      showCursor(call, result); break;
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
            result.success((int)printer.selectInterface(interfaceType, address));
        }catch(Exception e){
            result.success(1000);
        }
    }

    public void selectCommandMode(@NonNull MethodCall call, @NonNull Result result) {
        Integer mode = (Integer)getValue(call, "command_mode", -1);
        commandMode = (mode == 0 || mode == 1) ? mode : commandMode;
        try{
            result.success((int)printer.selectCommandMode(mode));
        }catch(Exception e){
            result.success(1000);
        }
    }

    public void openService(@NonNull MethodCall call, @NonNull Result result) {
        Integer id = (Integer)getValue(call, "device_id", -1);
        Integer timeout = (Integer)getValue(call, "time_out", 3);
        try{
            printer.setTimeout(timeout);
            // 바이패스 경우에도, id 값을 -1로 설정할 경우 프린터 상태 이벤트 통지가 안되는 문제가 아래와 같이 코딩
            int apiResult = (int)printer.openService(commandMode == 1 ? 10 : id, context);
            result.success(apiResult);
        }catch(Exception e){
            result.success(1000);
        }
    }

    public void closeService(@NonNull MethodCall call, @NonNull Result result) {
        Integer timeout = (Integer)getValue(call, "time_out", 3);
        try{
            printer.setTimeout(timeout);
            result.success((int)printer.closeService(timeout));
        }catch(Exception e){
            result.success(1000);
        }
    }

    public void isOpen(@NonNull MethodCall call, @NonNull Result result) {
        try{
            result.success(printer.isOpen() ? 1 : 0);
        }catch(Exception e){
            result.success(0);
        }
    }

    public void getDeviceId(@NonNull MethodCall call, @NonNull Result result) {
        try{
            result.success((int)printer.getDeviceId());
        }catch(Exception e){
            result.success(-1);
        }
    }

    public void directIO(@NonNull MethodCall call, @NonNull Result result) {
        ArrayList<Integer> dataArray = call.argument("data_array") == null ? null : call.argument("data_array");
        if(dataArray == null){
            result.success(1004);
            return;
        }
        try{
            int index = 0;
            byte[] byteArray = new byte[dataArray.toArray().length];
            Iterator<Integer> iterator = dataArray.iterator();
            while(iterator.hasNext()){
                byteArray[index++] = iterator.next().byteValue();
            }
            result.success((int)printer.directIO(byteArray));
        }catch(Exception e){
            result.success(1000);
        }
    }

    public void setReadMode(@NonNull MethodCall call, @NonNull Result result) {
        Integer mode = (Integer)getValue(call, "read_mode", 0);
        try{
            result.success((int)printer.setReadMode(mode));
        }catch(Exception e){
            result.success(1000);
        }
    }

    public void setKeepNetworkConnection(@NonNull MethodCall call, @NonNull Result result) {
        Integer keep_connection = (Integer)getValue(call, "keep_connection", 0);
        result.success(1000);
    }

    public void setTransaction(@NonNull MethodCall call, @NonNull Result result) {
        Integer transaction = (Integer)getValue(call, "transaction", 0);
        try{
            result.success((int)printer.setTransaction(transaction));
        }catch(Exception e){
            result.success(1000);
        }
    }

    public void asbEnable(@NonNull MethodCall call, @NonNull Result result) {
        Integer enable = (Integer)getValue(call, "enable", 1);
        try{
            result.success((int)printer.asbEnable(enable > 0));
        }catch(Exception e){
            result.success(1000);
        }
    }

    public void printText(@NonNull MethodCall call, @NonNull Result result) {
        String data = (String) getValue(call, "data", "");
        Integer fontType = (Integer)getValue(call, "font_type", 0);
        Integer fontWidth = (Integer)getValue(call, "font_width", 0);
        Integer fontHeight = (Integer)getValue(call, "font_height", 0);
        Integer bold = (Integer)getValue(call, "bold", 0);
        Integer underline = (Integer)getValue(call, "underline", 0);
        Integer reverse = (Integer)getValue(call, "reverse", 0);
        Integer alignment = (Integer)getValue(call, "alignment", 0);
        // Font Attribute Object
        FontAttribute attribute = new FontAttribute();
        attribute.setFontType(fontType);
        attribute.setBold(bold == 1);
        attribute.setUnderline(underline);
        attribute.setReverse(reverse == 1);
        attribute.setAlignment(alignment);
        String size = "0x" + fontHeight.toString() + fontWidth.toString();
        attribute.setFontSize(Integer.decode(size));

        try{
            result.success((int)printer.printText(data, attribute));
        }catch(Exception e){
            result.success(1000);
        }
    }

    public void setCharacterset(@NonNull MethodCall call, @NonNull Result result) {
        Integer characterset = (Integer)getValue(call, "character_set", 0);
        try{
            result.success(printer.setCharacterset(characterset));
        }catch(Exception e){
            result.success(1000);
        }
    }

    public void setInternationalCharacterset(@NonNull MethodCall call, @NonNull Result result) {
        Integer characterset = (Integer)getValue(call, "character_set", 0);
        try{
            result.success(printer.setInternationalCharacterset(characterset));
        }catch(Exception e){
            result.success(1000);
        }
    }

    public void setPagemode(@NonNull MethodCall call, @NonNull Result result) {
        Integer mode = (Integer)getValue(call, "mode", -1);
        try{
            result.success(printer.setPageMode(mode));
        }catch(Exception e){
            result.success(1000);
        }
    }

    public void setPagemodePrintArea(@NonNull MethodCall call, @NonNull Result result) {
        Integer x = (Integer)getValue(call, "x", 0);
        Integer y = (Integer)getValue(call, "y", 0);
        Integer width = (Integer)getValue(call, "width", 0);
        Integer height = (Integer)getValue(call, "height", 0);
        try{
            result.success(printer.setPagemodePrintArea(x, y, width, height));
        }catch(Exception e){
            result.success(1000);
        }
    }

    public void setPagemodeDirection(@NonNull MethodCall call, @NonNull Result result) {
        Integer direction = (Integer)getValue(call, "direction", -1);
        try{
            result.success(printer.setPagemodeDirection(direction));
        }catch(Exception e){
            result.success(1000);
        }
    }

    public void setPagemodePosition(@NonNull MethodCall call, @NonNull Result result) {
        Integer x = (Integer)getValue(call, "x", 0);
        Integer y = (Integer)getValue(call, "y", 0);
        try{
            result.success(printer.setPagemodePosition(x, y));
        }catch(Exception e){
            result.success(1000);
        }
    }

    public void printImageFile(@NonNull MethodCall call, @NonNull Result result) {
        String fileName = (String) getValue(call, "file_name", "");
        Integer width = (Integer)getValue(call, "width", 0);
        Integer alignment = (Integer)getValue(call, "alignment", 0);
        Integer threshold = (Integer)getValue(call, "threshold", 128);
        Integer ditheringType = (Integer)getValue(call, "dithering_type", 1);
        Integer compressType = (Integer)getValue(call, "compress_type", 1);
        try{
            result.success((int)printer.printImageFile(fileName, width, alignment, threshold, ditheringType, compressType));
        }catch(Exception e){
            result.success(1000);
        }
    }

    public void printBase64Image(@NonNull MethodCall call, @NonNull Result result) {
        String data = (String) getValue(call, "data", "");
        Integer width = (Integer)getValue(call, "width", 0);
        Integer alignment = (Integer)getValue(call, "alignment", 0);
        Integer threshold = (Integer)getValue(call, "threshold", 128);
        Integer ditheringType = (Integer)getValue(call, "dithering_type", 1);
        Integer compressType = (Integer)getValue(call, "compress_type", 1);
        try{
            result.success((int)printer.printBase64Image(data, width, alignment, threshold, ditheringType, compressType, true));
        }catch(Exception e){
            result.success(1000);
        }
    }

    public void printPDFFile(@NonNull MethodCall call, @NonNull Result result) {
        String fileName = (String) getValue(call, "file_name", "");
        //String licenseKey = (String) getValue(call, "license_key", "");
        Integer width = (Integer)getValue(call, "width", 0);
        Integer alignment = (Integer)getValue(call, "alignment", 0);
        Integer startPage = (Integer)getValue(call, "start_page", 0);
        Integer endPage = (Integer)getValue(call, "end_page", 0);
        Integer threshold = (Integer)getValue(call, "threshold", 128);
        Integer ditheringType = (Integer)getValue(call, "dithering_type", 0);
        Integer compressType = (Integer)getValue(call, "compress_type", 1);
        try{
            //printer.setPDFLicenseKey(licenseKey);
            int callResult = (int)printer.printPDFFile(Uri.parse("file://" + fileName), width, alignment, startPage, endPage, threshold, ditheringType, compressType);
            result.success(callResult);
        }catch(Exception e){
            result.success(1000);
        }
    }

    public void print1DBarcode(@NonNull MethodCall call, @NonNull Result result) {
        String data = (String) getValue(call, "data", "");
        Integer symbol = (Integer)getValue(call, "symbol", 0);
        Integer width = (Integer)getValue(call, "width", 0);
        Integer height = (Integer)getValue(call, "height", 0);
        Integer alignment = (Integer)getValue(call, "alignment", 0);
        Integer textPosition = (Integer)getValue(call, "text_position", 0);
        try{
            result.success((int)printer.print1dBarcode(data,symbol, width, height, alignment,textPosition));
        }catch(Exception e){
            result.success(1000);
        }
    }

    public void printQRCode(@NonNull MethodCall call, @NonNull Result result) {
        String data = (String) getValue(call, "data", "");
        Integer model = (Integer)getValue(call, "model", 205);
        Integer alignment = (Integer)getValue(call, "alignment", 0);
        Integer moduleSize = (Integer)getValue(call, "module_size", 4);
        Integer eccLevel = (Integer)getValue(call, "ecc_level", 51);
        try{
            result.success((int)printer.printQrCode(data, model, alignment, moduleSize,eccLevel));
        }catch(Exception e){
            result.success(1000);
        }
    }

    public void printPDF417(@NonNull MethodCall call, @NonNull Result result) {
        String data = (String) getValue(call, "data", "");
        Integer symbol = (Integer)getValue(call, "symbol", 201);
        Integer alignment = (Integer)getValue(call, "alignment", 0);
        Integer columnNumber = (Integer)getValue(call, "column_number", 0);
        Integer rowNumber = (Integer)getValue(call, "row_number", 0);
        Integer moduleWidth = (Integer)getValue(call, "module_width", 2);
        Integer moduleHeight = (Integer)getValue(call, "module_height", 4);
        Integer eccLevel = (Integer)getValue(call, "ecc_level", 0);
        // 표준화 문서와 호환성 유지를 위해 아래 코드 추가
        if(eccLevel >= 0 && eccLevel <= 8)
            eccLevel += 48;

        try{
            result.success((int)printer.printPDF417(data,symbol,alignment,columnNumber,rowNumber,moduleWidth,moduleHeight,eccLevel));
        }catch(Exception e){
            result.success(1000);
        }
    }

    public void printDataMatrix(@NonNull MethodCall call, @NonNull Result result) {
        String data = (String) getValue(call, "data", "");
        Integer moduleSize = (Integer)getValue(call, "module_size", 2);
        Integer alignment = (Integer)getValue(call, "alignment", 0);
        try{
            result.success((int)printer.printDataMatrix(data, alignment, moduleSize));
        }catch(Exception e){
            result.success(1000);
        }
    }

    public void printGS1Databar(@NonNull MethodCall call, @NonNull Result result) {
        String data = (String) getValue(call, "data", "");
        Integer symbol = (Integer)getValue(call, "symbol", 0);
        Integer alignment = (Integer)getValue(call, "alignment", 0);
        Integer size = (Integer)getValue(call, "size", 0);
        try{
            result.success((int)printer.printGS1Databar(data,symbol,alignment,size));
        }catch(Exception e){
            result.success(1000);
        }
    }

    public void printGS1DatabarMobile(@NonNull MethodCall call, @NonNull Result result) {
        String data = (String) getValue(call, "data", "");
        String cData = (String) getValue(call, "c_data", "");
        Integer symbol = (Integer) getValue(call, "symbol", 0);
        Integer moduleWidth = (Integer) getValue(call, "module_width", 0);
        Integer moduleHeight = (Integer) getValue(call, "module_height", 0);
        Integer segmentHeight = (Integer) getValue(call, "segment_height", 0);
        Integer separatorHeight = (Integer) getValue(call, "separator_height", 0);
        Integer alignment = (Integer) getValue(call, "alignment", 0);

        try{
            result.success((int)printer.printGS1DatabarMobile(data,cData,symbol, moduleWidth, moduleHeight, segmentHeight, separatorHeight, alignment));
        }catch(Exception e){
            result.success(1000);
        }
    }

    public void printCompositeSymbology(@NonNull MethodCall call, @NonNull Result result) {
        String data = (String) getValue(call, "data", "");
        String cData = (String) getValue(call, "c_data", "");
        Integer symbol = (Integer) getValue(call, "symbol", 0);
        Integer cSymbol = (Integer) getValue(call, "c_symbol", 0);
        Integer size = (Integer) getValue(call, "size", 0);
        Integer alignment = (Integer) getValue(call, "alignment", 0);

        try{
            result.success((int)printer.printCompositeSymbology(data,cData,symbol, cSymbol, size, alignment));
        }catch(Exception e){
            result.success(1000);
        }
    }

    public void printMaxicode(@NonNull MethodCall call, @NonNull Result result) {
        String data = (String) getValue(call, "data", "");
        Integer mode = (Integer) getValue(call, "mode", 0);
        Integer alignment = (Integer) getValue(call, "alignment", 0);

        try{
            result.success((int)printer.printMaxicode(data, mode, alignment));
        }catch(Exception e){
            result.success(1000);
        }
    }

    public void printAztec(@NonNull MethodCall call, @NonNull Result result) {
        String data = (String) getValue(call, "data", "");
        Integer moduleSize = (Integer) getValue(call, "module_size", 0);
        Integer eccLevel = (Integer) getValue(call, "ecc_level", 0);
        Integer mode = (Integer) getValue(call, "mode", 0);
        Integer alignment = (Integer) getValue(call, "alignment", 0);

        try{
            result.success((int)printer.printAztec(data, moduleSize, eccLevel, mode, alignment));
        }catch(Exception e){
            result.success(1000);
        }
    }

    public void printLine(@NonNull MethodCall call, @NonNull Result result) {
        Integer x1 = (Integer)getValue(call, "x1", 0);
        Integer y1 = (Integer)getValue(call, "y1", 0);
        Integer x2 = (Integer)getValue(call, "x2", 0);
        Integer y2 = (Integer)getValue(call, "y2", 0);
        Integer thickness = (Integer)getValue(call, "thickness", 0);
        try{
            result.success(printer.printLine(x1, y1, x2, y2, thickness));
        }catch(Exception e){
            result.success(1000);
        }
    }

    public void printBox(@NonNull MethodCall call, @NonNull Result result) {
        Integer x1 = (Integer)getValue(call, "left", 0);
        Integer y1 = (Integer)getValue(call, "top", 0);
        Integer x2 = (Integer)getValue(call, "right", 0);
        Integer y2 = (Integer)getValue(call, "bottom", 0);
        Integer thickness = (Integer)getValue(call, "thickness", 0);
        try{
            result.success(printer.printBox(x1, y1, x2, y2, thickness));
        }catch(Exception e){
            result.success(1000);
        }
    }

    public void cutPaper(@NonNull MethodCall call, @NonNull Result result) {
        Integer cutType = (Integer)getValue(call, "cut_type", 65);
        try{
            // cutType : 1 또는 65
            result.success(printer.cutPaper(cutType));
        }catch(Exception e){
            result.success(1000);
        }
    }

    public void openDrawer(@NonNull MethodCall call, @NonNull Result result) {
        Integer pinNumber = (Integer)getValue(call, "pin_number", 0);
        Integer onTime = (Integer)getValue(call, "on_time", 0);
        Integer offTime = (Integer)getValue(call, "off_time", 0);
        try{
            result.success(printer.openDrawer(pinNumber));
        }catch(Exception e){
            result.success(1000);
        }
    }

    public void checkPrinterStatus(@NonNull MethodCall call, @NonNull Result result) {
        try{
            result.success(printer.checkPrinterStatus());
        }catch(Exception e){
            result.success(-1);
        }
    }

    public void checkBattStatus(@NonNull MethodCall call, @NonNull Result result) {
        try{
            result.success(printer.checkBattStatus());
        }catch(Exception e){
            result.success(-1);
        }
    }

    public void getStatisticsData(@NonNull MethodCall call, @NonNull Result result) {
        //Integer info = (Integer)getValue(call, "request_info", -1);
        result.success("");
    }

    public void getModelName(@NonNull MethodCall call, @NonNull Result result) {
        try{
            result.success(printer.getModelName());
        }catch(Exception e){
            result.success("");
        }
    }

    public void getFirmwareVersion(@NonNull MethodCall call, @NonNull Result result) {
        try{
            result.success(printer.getFirmwareVersion());
        }catch(Exception e){
            result.success("");
        }
    }

    public void msrReady(@NonNull MethodCall call, @NonNull Result result) {
        result.success(1003);
    }

    public void getTrack1Data(@NonNull MethodCall call, @NonNull Result result) {
        result.success(1003);
    }

    public void getTrack2Data(@NonNull MethodCall call, @NonNull Result result) {
        result.success(1003);
    }

    public void getTrack3Data(@NonNull MethodCall call, @NonNull Result result) {
        result.success(1003);
    }

    public void powerUpSCR(@NonNull MethodCall call, @NonNull Result result) {
        result.success(1003);
    }

    public void powerDownSCR(@NonNull MethodCall call, @NonNull Result result) {
        result.success(1003);
    }

    public void setSCROperationMode(@NonNull MethodCall call, @NonNull Result result) {
        result.success(1003);
    }

    public void exchangeSCRData(@NonNull MethodCall call, @NonNull Result result) {
        result.success(1003);
    }

    public void getSCRCardStatus(@NonNull MethodCall call, @NonNull Result result) {
        result.success(1003);
    }

    public void displayString(@NonNull MethodCall call, @NonNull Result result) {
        String data = (String) getValue(call, "file_name", "");
        Integer characterSet = (Integer)getValue(call, "character_set", 0);
        Integer internationalCharacterSet = (Integer)getValue(call, "international_character_set", 0);
        Integer line = (Integer)getValue(call, "line", 0);

        try{
            result.success(printer.displayString(data, characterSet, internationalCharacterSet, line));
        }catch(Exception e){
            result.success("");
        }
    }

    public void clearScreen(@NonNull MethodCall call, @NonNull Result result) {
        try{
            result.success(printer.clearScreen());
        }catch(Exception e){
            result.success("");
        }
    }

    public void storeImageFile(@NonNull MethodCall call, @NonNull Result result) {
        String data = (String) getValue(call, "file_name", "");
        Integer width = (Integer)getValue(call, "width", 0);
        Integer imageNumber = (Integer)getValue(call, "image_number", 0);

        try{
            result.success(printer.storeImageFile(data, width, imageNumber));
        }catch(Exception e){
            result.success("");
        }
    }

    public void storeBase64Image(@NonNull MethodCall call, @NonNull Result result) {
        String data = (String) getValue(call, "file_name", "");
        Integer width = (Integer)getValue(call, "width", 0);
        Integer imageNumber = (Integer)getValue(call, "image_number", 0);

        try{
            result.success(printer.storeBase64Image(data, width, imageNumber));
        }catch(Exception e){
            result.success("");
        }
    }

    public void displayImage(@NonNull MethodCall call, @NonNull Result result) {
        Integer xPos = (Integer)getValue(call, "x_pos", 0);
        Integer yPos = (Integer)getValue(call, "y_pos", 0);
        Integer imageNumber = (Integer)getValue(call, "image_number", 0);

        try{
            result.success(printer.displayImage(xPos, yPos, imageNumber));
        }catch(Exception e){
            result.success("");
        }
    }

    public void clearImage(@NonNull MethodCall call, @NonNull Result result) {
        Integer imageNumber = (Integer)getValue(call, "image_number", 0);

        try{
            result.success(printer.clearImage(imageNumber));
        }catch(Exception e){
            result.success("");
        }
    }

    public void showCursor(@NonNull MethodCall call, @NonNull Result result) {
        Integer showCursor = (Integer)getValue(call, "show_cursor", 0);

        try{
            result.success(printer.showCursor(showCursor));
        }catch(Exception e){
            result.success("");
        }
    }

}
