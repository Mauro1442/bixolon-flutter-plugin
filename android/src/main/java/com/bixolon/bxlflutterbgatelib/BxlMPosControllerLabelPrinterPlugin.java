package com.bixolon.bxlflutterbgatelib;
import android.content.Context;
import android.net.Uri;
import androidx.annotation.NonNull;
import io.flutter.embedding.engine.plugins.FlutterPlugin;
import io.flutter.plugin.common.BinaryMessenger;
import io.flutter.plugin.common.EventChannel;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;
import com.bixolon.mpos.MPosControllerLabelPrinter;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.concurrent.Semaphore;

/** BxlMPosControllerLabelPrinterPlugin */
public class BxlMPosControllerLabelPrinterPlugin implements FlutterPlugin, MethodCallHandler {
    /// The MethodChannel that will the communication between Flutter and native Android
    ///
    /// This local reference serves to register the plugin with the Flutter Engine and unregister it
    /// when the Flutter Engine is detached from the Activity
    private MethodChannel channel;
    private MPosControllerLabelPrinter printer = new MPosControllerLabelPrinter();
    private Context context;
    private EventChannel.EventSink outputCompletedEventSink;
    private final Semaphore available = new Semaphore(1, true);
    private Integer commandMode = 0; /*BY-PASS*/

    @Override
    public void onAttachedToEngine(@NonNull FlutterPluginBinding flutterPluginBinding) {
        final String METHOD_CHANNEL = "com.bixolon.mposcontroller/labelprinter";
        final String EVENT_CHANNEL = "com.bixolon.mposcontroller/labelprinter/outputcompleted";

        BinaryMessenger messenger = flutterPluginBinding.getBinaryMessenger();
        context = flutterPluginBinding.getApplicationContext();
        channel = new MethodChannel(messenger, METHOD_CHANNEL);
        channel.setMethodCallHandler(this);
        EventChannel outputCompletedChannel = new EventChannel(messenger, EVENT_CHANNEL);
        outputCompletedChannel.setStreamHandler(new EventChannel.StreamHandler(){
            @Override
            public void onListen(Object listener, EventChannel.EventSink eventSink) { outputCompletedEventSink = eventSink; }
            @Override
            public void onCancel(Object listener) { outputCompletedEventSink = null; }
        });
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
                        // ETC
                        case "checkPrinterStatus":          checkPrinterStatus(call, result); break;
                        case "printBuffer":                 printBuffer(call, result); break;
                        // GETTER
                        case "getModelName":                getModelName(call, result); break;
                        case "getFirmwareVersion":          getFirmwareVersion(call, result); break;
                        case "getStatisticsData":           getStatisticsData(call, result); break;
                        case "getPrinterDPI":               getPrinterDPI(call, result); break;
                        case "getMaxWidth":                 getMaxWidth(call, result); break;
                        case "getSupportedSpeeds":          getSupportedSpeeds(call, result); break;
                        // SETTER
                        case "setCharacterset":             setCharacterset(call, result); break;
                        case "setPrintingType":             setPrintingType(call, result); break;
                        case "setMargin":                   setMargin(call, result); break;
                        case "setLength":                   setLength(call, result); break;
                        case "setWidth":                    setWidth(call, result); break;
                        case "setSpeed":                    setSpeed(call, result); break;
                        case "setDensity":                  setDensity(call, result); break;
                        case "setOrientation":              setOrientation(call, result); break;
                        case "setOffset":                   setOffset(call, result); break;
                        case "setCuttingPosition":          setCuttingPosition(call, result); break;
                        case "setAutoCutter":               setAutoCutter(call, result); break;
                        case "setRewinder":                 setRewinder(call, result); break;
                        // RFID
                        case "setupRFID":                   setupRFID(call, result); break;
                        case "calibrateRFID":               calibrateRFID(call, result); break;
                        case "setRFIDPosition":             setRFIDPosition(call, result); break;
                        case "setRFIDPassword":             setRFIDPassword(call, result); break;
                        case "setEPCDataStructure":         setEPCDataStructure(call, result); break;
                        case "writeRFID":                   writeRFID(call, result); break;
                        case "lockRFID":                    lockRFID(call, result); break;
                        // PRINT
                        case "drawTextDeviceFont":          drawTextDeviceFont(call, result); break;
                        case "drawTextVectorFont":          drawTextVectorFont(call, result); break;
                        case "drawBarcode1D":               drawBarcode1D(call, result); break;
                        case "drawBarcodeMaxiCode":         drawBarcodeMaxiCode(call, result); break;
                        case "drawBarcodePDF417":           drawBarcodePDF417(call, result); break;
                        case "drawBarcodeQRCode":           drawBarcodeQRCode(call, result); break;
                        case "drawBarcodeDataMatrix":       drawBarcodeDataMatrix(call, result); break;
                        case "drawBarcodeAztec":            drawBarcodeAztec(call, result); break;
                        case "drawBarcodeCode49":           drawBarcodeCode49(call, result); break;
                        case "drawBarcodeCodaBlock":        drawBarcodeCodaBlock(call, result); break;
                        case "drawBarcodeMicroPDF":         drawBarcodeMicroPDF(call, result); break;
                        case "drawBarcodeIMB":              drawBarcodeIMB(call, result); break;
                        case "drawBarcodeMSI":              drawBarcodeMSI(call, result); break;
                        case "drawBarcodePlessey":          drawBarcodePlessey(call, result); break;
                        case "drawBarcodeTLC39":            drawBarcodeTLC39(call, result); break;
                        case "drawBarcodeRSS":              drawBarcodeRSS(call, result); break;
                        case "drawBlock":                   drawBlock(call, result); break;
                        case "drawCircle":                  drawCircle(call, result); break;
                        case "drawBase64Image":             drawBase64Image(call, result); break;
                        case "drawImageFile":               drawImageFile(call, result); break;
                        case "drawPDFFile":                 drawPDFFile(call, result); break;
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
            result.success(printer.openService(commandMode == 1 ? 1 : id, context));
        }catch(Exception e){
            result.success(1000);
        }
    }

    public void closeService(@NonNull MethodCall call, @NonNull Result result) {
        Integer timeout = (Integer)getValue(call, "time_out", 3);
        try{
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
        Integer mode = (Integer)getValue(call, "read_mode", -1);
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
        Integer transaction = (Integer)getValue(call, "transaction", -1);
        try{
            result.success((int)printer.setTransaction(transaction));
        }catch(Exception e){
            result.success(1000);
        }
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

    public void getStatisticsData(@NonNull MethodCall call, @NonNull Result result) {
        Integer info = (Integer)getValue(call, "request_info", "");
        result.notImplemented();
    }

    public void getPrinterDPI(@NonNull MethodCall call, @NonNull Result result) {
        result.notImplemented();
    }

    public void getMaxWidth(@NonNull MethodCall call, @NonNull Result result) {
        result.notImplemented();
    }

    public void getSupportedSpeeds(@NonNull MethodCall call, @NonNull Result result) {
        result.notImplemented();
    }

    public void checkPrinterStatus(@NonNull MethodCall call, @NonNull Result result) {
        try{
            int status = (int)printer.checkPrinterStatus();
            // 표준화 매뉴얼 정의에 맞게 아래와 같이 상태 값 변경
            if(status < 0 || status > 10){
                result.success(-1);
                return;
            }
            switch (status)
            {
                case 1: /*do nothing*/      break; // paper empty
                case 2: /*do nothing*/      break; // cover open
                case 3:     status = 4;     break; // cutter jam
                case 4:     status = 8;     break; // tph over heat
                case 5:     status = 16;    break; // gap sensor error
                case 6:     status = 32;    break; // ribbon end
                case 7:     status = 64;    break; // building label
                case 8:     status = 128;   break; // printing label
                case 9:     status = 256;   break; // issued label paused
                case 10:    status = 4096;  break; // rfid writing error
                default:    status = 0;     break;
            }
            result.success(status);
        }catch(Exception e){
            result.success(-1);
        }
    }

    public void printBuffer(@NonNull MethodCall call, @NonNull Result result) {
        Integer copies = (Integer)getValue(call, "copies", 1);
        try{
            result.success(printer.printBuffer(copies));
        }catch(Exception e){
            result.success(1000);
        }
    }

    public void setCharacterset(@NonNull MethodCall call, @NonNull Result result) {
        Integer characterset = (Integer)getValue(call, "character_set", 0);
        Integer internationalCharacter_set = (Integer)getValue(call, "international_character_set", 0);
        try{
            result.success(printer.setCharacterset(characterset, internationalCharacter_set));
        }catch(Exception e){
            result.success(1000);
        }
    }

    public void setPrintingType(@NonNull MethodCall call, @NonNull Result result) {
        String printingType = (String) getValue(call, "printing_type", "d");
        try{
            result.success(printer.setPrintingType(printingType.charAt(0)));
        }catch(Exception e){
            result.success(1000);
        }
    }

    public void setMargin(@NonNull MethodCall call, @NonNull Result result) {
        Integer horizontalMargin = (Integer)getValue(call, "horizontal_margin", 0);
        Integer verticalMargin = (Integer)getValue(call, "vertical_margin", 0);
        try{
            result.success(printer.setMargin(horizontalMargin, verticalMargin));
        }catch(Exception e){
            result.success(1000);
        }
    }

    public void setLength(@NonNull MethodCall call, @NonNull Result result) {
        Integer labelLength = (Integer)getValue(call, "label_length", 0);
        Integer gapLength = (Integer)getValue(call, "gap_length", 0);
        String mediaType = (String) getValue(call, "media_type", "G");
        Integer offsetLength = (Integer)getValue(call, "offset_length", 0);
        try{
            result.success(printer.setLength(labelLength, gapLength, mediaType, offsetLength));
        }catch(Exception e){
            result.success(1000);
        }
    }

    public void setWidth(@NonNull MethodCall call, @NonNull Result result) {
        Integer labelWidth = (Integer)getValue(call, "label_width", 0);
        try{
            result.success(printer.setWidth(labelWidth));
        }catch(Exception e){
            result.success(1000);
        }
    }

    public void setSpeed(@NonNull MethodCall call, @NonNull Result result) {
        Integer speed = (Integer)getValue(call, "speed", 0);
        try{
            result.success(printer.setSpeed(speed));
        }catch(Exception e){
            result.success(1000);
        }
    }

    public void setDensity(@NonNull MethodCall call, @NonNull Result result) {
        Integer density = (Integer)getValue(call, "density", 10);
        try{
            result.success(printer.setDensity(density));
        }catch(Exception e){
            result.success(1000);
        }
    }

    public void setOrientation(@NonNull MethodCall call, @NonNull Result result) {
        String orientation = (String) getValue(call, "orientation", "T");
        try{
            result.success(printer.setOrientation(orientation.charAt(0)));
        }catch(Exception e){
            result.success(1000);
        }
    }

    public void setOffset(@NonNull MethodCall call, @NonNull Result result) {
        Integer length = (Integer)getValue(call, "length", 0);
        try{
            result.success(printer.setOffset(length));
        }catch(Exception e){
            result.success(1000);
        }
    }

    public void setCuttingPosition(@NonNull MethodCall call, @NonNull Result result) {
        Integer length = (Integer)getValue(call, "length", 0);
        try{
            result.success(printer.setCuttingPosition(length));
        }catch(Exception e){
            result.success(1000);
        }
    }

    public void setAutoCutter(@NonNull MethodCall call, @NonNull Result result) {
        Integer enableAutoCutter = (Integer)getValue(call, "enable_autocutter", 0);
        Integer cutPeriod = (Integer)getValue(call, "cut_period", 1);
        try{
            result.success(printer.setAutoCutter(enableAutoCutter > 0, cutPeriod));
        }catch(Exception e){
            result.success(1000);
        }
    }

    public void setRewinder(@NonNull MethodCall call, @NonNull Result result) {
        Integer enableRewinder = (Integer)getValue(call, "enable_rewinder", 0);
        try{
            result.success(printer.setRewinder(enableRewinder > 0));
        }catch(Exception e){
            result.success(1000);
        }
    }

    public void setupRFID(@NonNull MethodCall call, @NonNull Result result) {
        Integer rfidType = (Integer)getValue(call, "rfid_type", 0);
        Integer numberOfRetries = (Integer)getValue(call, "number_of_retries", 0);
        Integer numberOfLabels = (Integer)getValue(call, "number_of_labels", 0);
        Integer radioPower = (Integer)getValue(call, "radio_power", 0);
        try{
            result.success(printer.setupRFID(rfidType, numberOfRetries, numberOfLabels, radioPower));
        }catch(Exception e){
            result.success(1000);
        }
    }

    public void calibrateRFID(@NonNull MethodCall call, @NonNull Result result) {
        try{
            result.success(printer.calibrateRFID());
        }catch(Exception e){
            result.success(1000);
        }
    }

    public void setRFIDPosition(@NonNull MethodCall call, @NonNull Result result) {
        Integer trans_position = (Integer)getValue(call, "trans_position", 0);
        try{
            result.success(printer.setRFIDPosition(trans_position));
        }catch(Exception e){
            result.success(1000);
        }
    }

    public void setRFIDPassword(@NonNull MethodCall call, @NonNull Result result) {
        String old_access_pwd = (String) getValue(call, "old_access_pwd", "");
        String old_kill_pwd = (String) getValue(call, "old_kill_pwd", "");
        String new_access_pwd = (String) getValue(call, "new_access_pwd", "");
        String new_kill_pwd = (String) getValue(call, "new_kill_pwd", "");
        try{
            result.success(printer.setRFIDPassword(old_access_pwd, old_kill_pwd, new_access_pwd, new_kill_pwd));
        }catch(Exception e){
            result.success(1000);
        }
    }

    public void setEPCDataStructure(@NonNull MethodCall call, @NonNull Result result) {
        Integer total_size = (Integer)getValue(call, "total_size", 0);
        String field_sizes = (String) getValue(call, "field_sizes", "");
        try{
            result.success(printer.setEPCDataStructure(total_size, field_sizes));
        }catch(Exception e){
            result.success(1000);
        }
    }

    public void writeRFID(@NonNull MethodCall call, @NonNull Result result) {
        String data = (String) getValue(call, "data", "");
        Integer data_type = (Integer)getValue(call, "data_type", 0);
        Integer start_block_number = (Integer)getValue(call, "start_block_number", 0);
        Integer data_length = (Integer)getValue(call, "data_length", 0);
        try{
            result.success(printer.writeRFID(data_type, start_block_number,data_length,data));
        }catch(Exception e){
            result.success(1000);
        }
    }

    public void lockRFID(@NonNull MethodCall call, @NonNull Result result) {
        try{
            result.success(printer.lockRFID());
        }catch(Exception e){
            result.success(1000);
        }
    }

    public void drawTextDeviceFont(@NonNull MethodCall call, @NonNull Result result) {
        String data = (String) getValue(call, "data", "");
        Integer xPos = (Integer)getValue(call, "x_pos", 0);
        Integer yPos = (Integer)getValue(call, "y_pos", 0);
        String font = (String) getValue(call, "font_type", "");
        Integer font_width = (Integer)getValue(call, "font_width", 0);
        Integer font_height = (Integer)getValue(call, "font_height", 0);
        Integer right_space = (Integer)getValue(call, "right_space", 0);
        Integer rotation = (Integer)getValue(call, "right_space", 0);
        Integer reverse = (Integer)getValue(call, "reverse", 0);
        Integer bold = (Integer)getValue(call, "bold", 0);
        Integer right_to_left = (Integer)getValue(call, "right_to_left", 0);
        Integer alignment = (Integer)getValue(call, "alignment", 0);
        try{
            result.success(printer.drawTextDeviceFont(data,
                    xPos,
                    yPos,
                    font.charAt(0),
                    font_width,
                    font_height,
                    right_space,
                    rotation,
                    reverse > 0,
                    bold > 0,
                    right_to_left > 0,
                    alignment));
        }catch(Exception e){
            result.success(1000);
        }
    }

    public void drawTextVectorFont(@NonNull MethodCall call, @NonNull Result result) {
        String data = (String) getValue(call, "data", "");
        Integer xPos = (Integer)getValue(call, "x_pos", 0);
        Integer yPos = (Integer)getValue(call, "y_pos", 0);
        String font = (String) getValue(call, "font_type", "");
        Integer font_width = (Integer)getValue(call, "font_width", 24);
        Integer font_height = (Integer)getValue(call, "font_height", 24);
        Integer right_space = (Integer)getValue(call, "right_space", 0);
        Integer rotation = (Integer)getValue(call, "right_space", 0);
        Integer reverse = (Integer)getValue(call, "reverse", 0);
        Integer bold = (Integer)getValue(call, "bold", 0);
        Integer italic = (Integer)getValue(call, "italic", 0);
        Integer right_to_left = (Integer)getValue(call, "right_to_left", 0);
        Integer alignment = (Integer)getValue(call, "alignment", 0);
        try{
            result.success(printer.drawTextVectorFont(data,
                    xPos,
                    yPos,
                    font.charAt(0),
                    font_width,
                    font_height,
                    right_space,
                    rotation,
                    reverse > 0,
                    bold > 0,
                    italic > 0,
                    right_to_left > 0,
                    alignment));
        }catch(Exception e){
            result.success(1000);
        }
    }

    public void drawBarcode1D(@NonNull MethodCall call, @NonNull Result result) {
        String data = (String) getValue(call, "data", "");
        Integer xPos = (Integer)getValue(call, "x_pos", 0);
        Integer yPos = (Integer)getValue(call, "y_pos", 0);
        Integer barcode_type = (Integer)getValue(call, "barcode_type", 0);
        Integer width_narrow = (Integer)getValue(call, "width_narrow", 0);
        Integer width_wide = (Integer)getValue(call, "width_wide", 0);
        Integer height = (Integer)getValue(call, "height", 0);
        Integer hri = (Integer)getValue(call, "hri", 0);
        Integer rotation = (Integer)getValue(call, "rotation", 0);
        Integer quiet_zone_width = (Integer)getValue(call, "quiet_zone_width", 0);
        try{
            result.success(printer.drawBarcode1D(data,
                    xPos,
                    yPos,
                    barcode_type,
                    width_narrow,
                    width_wide,
                    height,
                    hri,
                    quiet_zone_width,
                    rotation));
        }catch(Exception e){
            result.success(1000);
        }
    }

    public void drawBarcodeMaxiCode(@NonNull MethodCall call, @NonNull Result result) {
        String data = (String) getValue(call, "data", "");
        Integer xPos = (Integer)getValue(call, "x_pos", 0);
        Integer yPos = (Integer)getValue(call, "y_pos", 0);
        Integer mode = (Integer)getValue(call, "mode", 0);
        try{
            result.success(printer.drawBarcodeMaxiCode(data, xPos, yPos, mode));
        }catch(Exception e){
            result.success(1000);
        }
    }

    public void drawBarcodePDF417(@NonNull MethodCall call, @NonNull Result result) {
        String data = (String) getValue(call, "data", "");
        Integer xPos = (Integer)getValue(call, "x_pos", 0);
        Integer yPos = (Integer)getValue(call, "y_pos", 0);
        Integer maximum_row_count = (Integer)getValue(call, "maximum_row_count", 0);
        Integer maximum_column_count = (Integer)getValue(call, "maximum_column_count", 0);
        Integer ecc_level = (Integer)getValue(call, "ecc_level", 0);
        Integer data_compression_method = (Integer)getValue(call, "data_compression_method", 0);
        Integer hri = (Integer)getValue(call, "hri", 0);
        Integer origin_point = (Integer)getValue(call, "origin_point", 0);
        Integer module_width = (Integer)getValue(call, "module_width", 0);
        Integer bar_height = (Integer)getValue(call, "bar_height", 0);
        Integer rotation = (Integer)getValue(call, "rotation", 0);
        try{
            result.success(printer.drawBarcodePDF417(data,
                    xPos,
                    yPos,
                    maximum_row_count,
                    maximum_column_count,
                    ecc_level,
                    data_compression_method,
                    hri > 0,
                    origin_point,
                    module_width,
                    bar_height,
                    rotation));
        }catch(Exception e){
            result.success(1000);
        }
    }

    public void drawBarcodeQRCode(@NonNull MethodCall call, @NonNull Result result) {
        String data = (String) getValue(call, "data", "");
        Integer xPos = (Integer)getValue(call, "x_pos", 0);
        Integer yPos = (Integer)getValue(call, "y_pos", 0);
        Integer size = (Integer)getValue(call, "size", 4);
        Integer model = (Integer)getValue(call, "model", 2);
        Integer ecc_level = (Integer)getValue(call, "ecc_level", 0);
        Integer rotation = (Integer)getValue(call, "rotation", 0);
        try{
            result.success(printer.drawBarcodeQRCode(data,
                    xPos,
                    yPos,
                    size,
                    model,
                    ecc_level,
                    rotation));
        }catch(Exception e){
            result.success(1000);
        }
    }

    public void drawBarcodeDataMatrix(@NonNull MethodCall call, @NonNull Result result) {
        String data = (String) getValue(call, "data", "");
        Integer xPos = (Integer)getValue(call, "x_pos", 0);
        Integer yPos = (Integer)getValue(call, "y_pos", 0);
        Integer size = (Integer)getValue(call, "size", 4);
        Integer reverse = (Integer)getValue(call, "reverse", 2);
        Integer rotation = (Integer)getValue(call, "rotation", 0);
        try{
            result.success(printer.drawBarcodeDataMatrix(data,
                    xPos,
                    yPos,
                    size,
                    reverse > 0,
                    rotation));
        }catch(Exception e){
            result.success(1000);
        }
    }

    public void drawBarcodeAztec(@NonNull MethodCall call, @NonNull Result result) {
        String data = (String) getValue(call, "data", "");
        Integer xPos = (Integer)getValue(call, "x_pos", 0);
        Integer yPos = (Integer)getValue(call, "y_pos", 0);
        Integer size = (Integer)getValue(call, "size", 0);
        Integer extended_channel = (Integer)getValue(call, "extended_channel", 0);
        Integer eccLevel = (Integer)getValue(call, "eccLevel", 0);
        Integer menu_symbol = (Integer)getValue(call, "menu_symbol", 0);
        Integer number_of_symbols = (Integer)getValue(call, "number_of_symbols", 0);
        String optional_id = (String)getValue(call, "optional_id", "");
        Integer rotation = (Integer)getValue(call, "rotation", 0);
        try{
            result.success(printer.drawBarcodeAztec(data,
                    xPos,
                    yPos,
                    size,
                    extended_channel > 0,
                    eccLevel,
                    menu_symbol > 0,
                    number_of_symbols,
                    optional_id,
                    rotation));
        }catch(Exception e){
            result.success(1000);
        }
    }

    public void drawBarcodeCode49(@NonNull MethodCall call, @NonNull Result result) {
        String data = (String) getValue(call, "data", "");
        Integer xPos = (Integer)getValue(call, "x_pos", 0);
        Integer yPos = (Integer)getValue(call, "y_pos", 0);
        Integer width_narrow = (Integer)getValue(call, "width_narrow", 0);
        Integer width_wide = (Integer)getValue(call, "width_wide", 0);
        Integer height = (Integer)getValue(call, "height", 0);
        Integer hri = (Integer)getValue(call, "hri", 0);
        Integer starting_mode = (Integer)getValue(call, "starting_mode", 0);
        Integer rotation = (Integer)getValue(call, "rotation", 0);
        try{
            result.success(printer.drawBarcodeCode49(data,
                    xPos,
                    yPos,
                    width_narrow,
                    width_wide,
                    height,
                    hri,
                    starting_mode,
                    rotation));
        }catch(Exception e){
            result.success(1000);
        }
    }

    public void drawBarcodeCodaBlock(@NonNull MethodCall call, @NonNull Result result) {
        String data = (String) getValue(call, "data", "");
        Integer xPos = (Integer)getValue(call, "x_pos", 0);
        Integer yPos = (Integer)getValue(call, "y_pos", 0);
        Integer width_narrow = (Integer)getValue(call, "width_narrow", 0);
        Integer width_wide = (Integer)getValue(call, "width_wide", 0);
        Integer height = (Integer)getValue(call, "height", 0);
        Integer security_level = (Integer)getValue(call, "security_level", 0);
        Integer data_columns = (Integer)getValue(call, "data_columns", 2);
        String mode = (String) getValue(call, "mode", "F");
        Integer rows_to_encode = (Integer)getValue(call, "rows_to_encode", 2);
        try{
            result.success(printer.drawBarcodeCodaBlock(data,
                    xPos,
                    yPos,
                    width_narrow,
                    width_wide,
                    height,
                    security_level > 0,
                    data_columns,
                    mode.charAt(0),
                    rows_to_encode));
        }catch(Exception e){
            result.success(1000);
        }
    }

    public void drawBarcodeMicroPDF(@NonNull MethodCall call, @NonNull Result result) {
        String data = (String) getValue(call, "data", "");
        Integer xPos = (Integer)getValue(call, "x_pos", 0);
        Integer yPos = (Integer)getValue(call, "y_pos", 0);
        Integer module_width = (Integer)getValue(call, "module_width", 0);
        Integer mode = (Integer)getValue(call, "mode", 0);
        Integer height = (Integer)getValue(call, "height", 0);
        Integer rotation = (Integer)getValue(call, "rotation", 0);
        try{
            result.success(printer.drawBarcodeMicroPDF(data,
                    xPos,
                    yPos,
                    module_width,
                    height,
                    mode,
                    rotation));
        }catch(Exception e){
            result.success(1000);
        }
    }

    public void drawBarcodeIMB(@NonNull MethodCall call, @NonNull Result result) {
        String data = (String) getValue(call, "data", "");
        Integer xPos = (Integer)getValue(call, "x_pos", 0);
        Integer yPos = (Integer)getValue(call, "y_pos", 0);
        Integer hri = (Integer)getValue(call, "hri", 0);
        Integer rotation = (Integer)getValue(call, "rotation", 0);
        try{
            result.success(printer.drawBarcodeIMB(data, xPos, yPos, hri > 0, rotation));
        }catch(Exception e){
            result.success(1000);
        }
    }

    public void drawBarcodeMSI(@NonNull MethodCall call, @NonNull Result result) {
        String data = (String) getValue(call, "data", "");
        Integer xPos = (Integer)getValue(call, "x_pos", 0);
        Integer yPos = (Integer)getValue(call, "y_pos", 0);
        Integer width_narrow = (Integer)getValue(call, "width_narrow", 0);
        Integer width_wide = (Integer)getValue(call, "width_wide", 0);
        Integer height = (Integer)getValue(call, "height", 0);
        Integer check_digit = (Integer)getValue(call, "check_digit", 0);
        Integer print_check_digit = (Integer)getValue(call, "print_check_digit", 0);
        Integer hri = (Integer)getValue(call, "hri", 0);
        Integer rotation = (Integer)getValue(call, "rotation", 0);
        try{
            result.success(printer.drawBarcodeMSI(data,
                    xPos,
                    yPos,
                    width_narrow,
                    width_wide,
                    height,
                    check_digit,
                    print_check_digit > 0,
                    hri,
                    rotation));
        }catch(Exception e){
            result.success(1000);
        }
    }

    public void drawBarcodePlessey(@NonNull MethodCall call, @NonNull Result result) {
        String data = (String) getValue(call, "data", "");
        Integer xPos = (Integer)getValue(call, "x_pos", 0);
        Integer yPos = (Integer)getValue(call, "y_pos", 0);
        Integer width_narrow = (Integer)getValue(call, "width_narrow", 0);
        Integer width_wide = (Integer)getValue(call, "width_wide", 0);
        Integer height = (Integer)getValue(call, "height", 0);
        Integer print_check_digit = (Integer)getValue(call, "print_check_digit", 0);
        Integer hri = (Integer)getValue(call, "hri", 0);
        Integer rotation = (Integer)getValue(call, "rotation", 0);
        try{
            result.success(printer.drawBarcodePlessey(data,
                    xPos,
                    yPos,
                    width_narrow,
                    width_wide,
                    height,
                    print_check_digit > 0,
                    hri,
                    rotation));
        }catch(Exception e){
            result.success(1000);
        }
    }

    public void drawBarcodeTLC39(@NonNull MethodCall call, @NonNull Result result) {
        String data = (String) getValue(call, "data", "");
        Integer xPos = (Integer)getValue(call, "x_pos", 0);
        Integer yPos = (Integer)getValue(call, "y_pos", 0);
        Integer width_narrow = (Integer)getValue(call, "width_narrow", 0);
        Integer width_wide = (Integer)getValue(call, "width_wide", 0);
        Integer height = (Integer)getValue(call, "height", 0);
        Integer row_height_of_micro_pdf417 = (Integer)getValue(call, "row_height_of_micro_pdf417", 10);
        Integer narrow_width_of_micro_pdf417 = (Integer)getValue(call, "narrow_width_of_micro_pdf417", 5);
        Integer rotation = (Integer)getValue(call, "rotation", 0);
        try{
            result.success(printer.drawBarcodeTLC39(data,
                    xPos,
                    yPos,
                    width_narrow,
                    width_wide,
                    height,
                    row_height_of_micro_pdf417,
                    narrow_width_of_micro_pdf417,
                    rotation));
        }catch(Exception e){
            result.success(1000);
        }
    }

    public void drawBarcodeRSS(@NonNull MethodCall call, @NonNull Result result) {
        String data = (String) getValue(call, "data", "");
        Integer xPos = (Integer)getValue(call, "x_pos", 0);
        Integer yPos = (Integer)getValue(call, "y_pos", 0);
        Integer barcode_type = (Integer)getValue(call, "barcode_type", 0);
        Integer magnification = (Integer)getValue(call, "magnification", 0);
        Integer separator_height = (Integer)getValue(call, "separator_height", 0);
        Integer height = (Integer)getValue(call, "height", 0);
        Integer segment_width = (Integer)getValue(call, "segment_width", 10);
        Integer rotation = (Integer)getValue(call, "rotation", 0);
        try{
            result.success(printer.drawBarcodeRSS(data,
                    xPos,
                    yPos,
                    barcode_type,
                    magnification,
                    separator_height,
                    height,
                    segment_width,
                    rotation));
        }catch(Exception e){
            result.success(1000);
        }
    }

    public void drawBlock(@NonNull MethodCall call, @NonNull Result result) {
        Integer start_pos_x = (Integer)getValue(call, "start_pos_x", 0);
        Integer start_pos_y = (Integer)getValue(call, "start_pos_y", 0);
        Integer end_pos_x = (Integer)getValue(call, "end_pos_x", 0);
        Integer end_pos_y = (Integer)getValue(call, "end_pos_y", 0);
        Integer thickness = (Integer)getValue(call, "thickness", 0);
        String option = (String) getValue(call, "option", "B");
        try{
            result.success(printer.drawBlock(start_pos_x, start_pos_y, end_pos_x, end_pos_y, option, thickness));
        }catch(Exception e){
            result.success(1000);
        }
    }

    public void drawCircle(@NonNull MethodCall call, @NonNull Result result) {
        Integer start_pos_x = (Integer)getValue(call, "start_pos_x", 0);
        Integer start_pos_y = (Integer)getValue(call, "start_pos_y", 0);
        Integer size = (Integer)getValue(call, "size", 0);
        Integer multiplier = (Integer)getValue(call, "multiplier", 0);
        try{
            result.success(printer.drawCircle(start_pos_x, start_pos_y, size, multiplier));
        }catch(Exception e){
            result.success(1000);
        }
    }

    public void drawBase64Image(@NonNull MethodCall call, @NonNull Result result) {
        String data = (String) getValue(call, "data", "");
        Integer xPos = (Integer)getValue(call, "x_pos", 0);
        Integer yPos = (Integer)getValue(call, "y_pos", 0);
        Integer width = (Integer)getValue(call, "width", 0);
        Integer threshold = (Integer)getValue(call, "threshold", 128);
        Integer ditheringType = (Integer)getValue(call, "dithering_type", 1);
        Integer compressType = (Integer)getValue(call, "compress_type", 1);
        try{
            result.success((int)printer.drawBase64Image(data, xPos, yPos, width, threshold, ditheringType, compressType, true));
        }catch(Exception e){
            result.success(1000);
        }
    }

    public void drawPDFFile(@NonNull MethodCall call, @NonNull Result result) {
        String file_name = (String) getValue(call, "file_name", "");
        Integer xPos = (Integer)getValue(call, "x_pos", 0);
        Integer yPos = (Integer)getValue(call, "y_pos", 0);
        Integer width = (Integer)getValue(call, "width", 0);
        Integer page_number = (Integer)getValue(call, "page_number", 0);
        Integer threshold = (Integer)getValue(call, "threshold", 128);
        Integer ditheringType = (Integer)getValue(call, "dithering_type", 0);
        Integer compressType = (Integer)getValue(call, "compress_type", 1);
        //String licenseKey = (String) getValue(call, "license_key", "");
        try{
            //printer.setPDFLicenseKey(licenseKey);
            int callResult = (int)printer.drawPDFFile(Uri.parse("file://" + file_name), xPos, yPos, width, page_number, threshold, ditheringType, compressType);
            result.success(callResult);
        }catch(Exception e){
            result.success(1000);
        }
    }

    public void drawImageFile(@NonNull MethodCall call, @NonNull Result result) {
        String file_name = (String) getValue(call, "file_name", "");
        Integer xPos = (Integer)getValue(call, "x_pos", 0);
        Integer yPos = (Integer)getValue(call, "y_pos", 0);
        Integer width = (Integer)getValue(call, "width", 0);
        Integer threshold = (Integer)getValue(call, "threshold", 128);
        Integer ditheringType = (Integer)getValue(call, "dithering_type", 0);
        Integer compressType = (Integer)getValue(call, "compress_type", 1);
        String licenseKey = (String) getValue(call, "license_key", "");
        try{
            printer.setPDFLicenseKey(licenseKey);
            result.success((int)printer.drawImageFile(file_name, xPos, yPos, width, threshold, ditheringType, compressType));
        }catch(Exception e){
            result.success(1000);
        }
    }
}

