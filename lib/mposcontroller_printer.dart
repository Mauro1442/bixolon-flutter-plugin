import 'dart:async';
import 'package:flutter/services.dart';

class MPosControllerPrinter {

  static const MethodChannel _channel = MethodChannel('com.bixolon.mposcontroller/printer');
  static const EventChannel _printerStatusChannel = EventChannel('com.bixolon.mposcontroller/printer/status');
  static const EventChannel _outputCompletedChannel = EventChannel('com.bixolon.mposcontroller/printer/outputcompleted');

  Future<int?> openService({ int deviceId = -1, int timeout = 3}) async {
    final Map<String, dynamic> params = <String, dynamic>{
      'device_id' : deviceId,
      'time_out' : timeout
    };
    return await _channel.invokeMethod('openService', params);
  }

  Future<int?> closeService({ int timeout = 3}) async {
    final Map<String, dynamic> params = <String, dynamic>{
      'time_out' : timeout
    };
    return await _channel.invokeMethod('closeService', params);
  }

  Future<int?> selectInterface(int interfaceType, String address) async {
    final Map<String, dynamic> params = <String, dynamic>{
      'interface_type' : interfaceType,
      'address' : address
    };
    return await _channel.invokeMethod('selectInterface', params);
  }

  Future<int?> selectCommandMode(int commandMode) async {
    final Map<String, dynamic> params = <String, dynamic>{
      'command_mode' : commandMode,
    };
    return await _channel.invokeMethod('selectCommandMode', params);
  }

  Future<int?> setTransaction(int transaction) async {
    final Map<String, dynamic> params = <String, dynamic>{
      'transaction' : transaction,
    };
    return await _channel.invokeMethod('setTransaction', params);
  }

  Future<int?> setReadMode(int mode) async {
    final Map<String, dynamic> params = <String, dynamic>{
      'read_mode' : mode,
    };
    return await _channel.invokeMethod('setReadMode', params);
  }

  Future<int?> directIO(List<int> data) async {
    final Map<String, dynamic> params = <String, dynamic>{
      'data_array' : data,
    };
    return await _channel.invokeMethod('directIO', params);
  }

  Future<int?> isOpen() async {
    return await _channel.invokeMethod('isOpen');
  }

  Future<int?> setKeepNetworkConnection(int keepConnection) async {
    final Map<String, dynamic> params = <String, dynamic>{
      'keep_connection': keepConnection,
    };
    return await _channel.invokeMethod('setKeepNetworkConnection', params);
  }

  Future<int?> printText(String data,
      {
        int fontType = 0,
        int fontWidth = 0,
        int fontHeight = 0,
        int bold = 0,
        int underline = 0,
        int reverse = 0,
        int alignment = 0
      }) async {
    final Map<String, dynamic> params = <String, dynamic>{
      'data' : data,
      'font_type' : fontType,
      'font_width' : fontWidth,
      'font_height' : fontHeight,
      'bold' : bold,
      'underline' : underline,
      'reverse' : reverse,
      'alignment' : alignment
    };
    return await _channel.invokeMethod('printText', params);
  }

  Future<int?> setCharacterset(int characterset) async {
    final Map<String, dynamic> params = <String, dynamic>{
      'character_set' : characterset
    };
    return await _channel.invokeMethod('setCharacterset', params);
  }

  Future<int?> setInternationalCharacterset(int characterset) async {
    final Map<String, dynamic> params = <String, dynamic>{
      'character_set' : characterset
    };
    return await _channel.invokeMethod('setInternationalCharacterset', params);
  }

  Future<int?> setPagemode(int mode) async {
    final Map<String, dynamic> params = <String, dynamic>{
      'mode' : mode
    };
    return await _channel.invokeMethod('setPagemode', params);
  }

  Future<int?> setPagemodePrintArea(int x, int y, int width, int height) async {
    final Map<String, dynamic> params = <String, dynamic>{
      'x' : x,
      'y' : y,
      'width' : width,
      'height' : height
    };
    return await _channel.invokeMethod('setPagemodePrintArea', params);
  }

  Future<int?> setPagemodeDirection(int direction) async {
    final Map<String, dynamic> params = <String, dynamic>{
      'direction' : direction
    };
    return await _channel.invokeMethod('setPagemodeDirection', params);
  }

  Future<int?> setPagemodePosition(int x, int y) async {
    final Map<String, dynamic> params = <String, dynamic>{
      'x' : x,
      'y' : y
    };
    return await _channel.invokeMethod('setPagemodePosition', params);
  }

  Future<int?> printBase64Image(String base64String,
      int width,
      {
        int alignment = 0,
        int threshold = 128,
        int ditheringType = 1,
        int compressType = 1
      }) async {
    final Map<String, dynamic> params = <String, dynamic>{
      'data': base64String,
      'width' : width,
      'alignment' : alignment,
      'threshold' : threshold,
      'dithering_type' : ditheringType,
      'compress_type' : compressType
    };
    return await _channel.invokeMethod('printBase64Image', params);
  }

  Future<int?> printImageFile(String fileName,
      int width,
      {
        int alignment = 0,
        int threshold = 128,
        int ditheringType = 1,
        int compressType = 1
      }) async {
    final Map<String, dynamic> params = <String, dynamic>{
      'file_name': fileName,
      'width' : width,
      'alignment' : alignment,
      'threshold' : threshold,
      'dithering_type' : ditheringType,
      'compress_type' : compressType
    };
    return await _channel.invokeMethod('printImageFile', params);
  }

  Future<int?> printPDFFile(String fileName,
      int width,
      int startPage,
      int endPage,
      {
        int alignment = 0,
        int threshold = 128,
        int ditheringType = 0,
        int compressType = 1,
      }) async {
    final Map<String, dynamic> params = <String, dynamic>{
      'file_name': fileName,
      'width' : width,
      'alignment' : alignment,
      'start_page' : startPage,
      'end_page' : endPage,
      'threshold' : threshold,
      'dithering_type' : ditheringType,
      'compress_type' : compressType
    };
    return await _channel.invokeMethod('printPDFFile', params);
  }

  Future<int?> print1DBarcode(String data,
      int symbology,
      int barWidth,
      int height,
      {
        int alignment = 0,
        int textPostion = 0
      }) async {
    final Map<String, dynamic> params = <String, dynamic>{
      'data': data,
      'symbol' : symbology,
      'width' : barWidth,
      'height' : height,
      'alignment' : alignment,
      'text_position' : textPostion,
    };
    return await _channel.invokeMethod('print1DBarcode', params);
  }

  Future<int?> printQRCode(String data, int model, int moduleSize, int eccLevel, { int alignment = 0 }) async {
    final Map<String, dynamic> params = <String, dynamic>{
      'data': data,
      'model' : model,
      'alignment' : alignment,
      'module_size' : moduleSize,
      'ecc_level' : eccLevel
    };
    return await _channel.invokeMethod('printQRCode', params);
  }

  Future<int?> printPDF417(String data,
      int symbol,
      int columnNumber,
      int rownumber,
      int moduleWidth,
      int moduleHeight,
      int eccLevel,
      { int alignment = 0 }) async {
    final Map<String, dynamic> params = <String, dynamic>{
      'data': data,
      'symbol' : symbol,
      'alignment' : alignment,
      'column_number' : columnNumber,
      'row_number' : rownumber,
      'module_width' : moduleWidth,
      'module_height' : moduleHeight,
      'ecc_level' : eccLevel
    };
    return await _channel.invokeMethod('printPDF417', params);
  }

  Future<int?> printDataMatrix(String data, int moduleSize, { int alignment = 0 }) async {
    final Map<String, dynamic> params = <String, dynamic>{
      'data': data,
      'module_size' : moduleSize,
      'alignment' : alignment
    };
    return await _channel.invokeMethod('printDataMatrix', params);
  }

  Future<int?> printGS1Databar(String data, int symbol, int size, { int alignment = 0 }) async {
    final Map<String, dynamic> params = <String, dynamic>{
      'data': data,
      'symbol' : symbol,
      'size' : size,
      'alignment' : alignment
    };
    return await _channel.invokeMethod('printGS1Databar', params);
  }

  Future<int?> printGS1DatabarMobile(String data,
      String cData,
      int symbol,
      int moduleWidth,
      int moduleHeight,
      int segmentHeight,
      int separatorHeight,
      { int alignment = 0 }) async {
    final Map<String, dynamic> params = <String, dynamic>{
      'data': data,
      'c_data': cData,
      'symbol' : symbol,
      'module_width' : moduleWidth,
      'module_height' : moduleHeight,
      'segment_height' : segmentHeight,
      'separator_height' : separatorHeight,
      'alignment' : alignment
    };
    return await _channel.invokeMethod('printGS1DatabarMobile', params);
  }

  Future<int?> printCompositeSymbology(String data,
      String cData,
      int symbol,
      int cSymbol,
      int size,
      { int alignment = 0 }) async {
    final Map<String, dynamic> params = <String, dynamic>{
      'data': data,
      'c_data': cData,
      'symbol' : symbol,
      'c_symbol' : cSymbol,
      'size' : size,
      'alignment' : alignment
    };
    return await _channel.invokeMethod('printCompositeSymbology', params);
  }

  Future<int?> printMaxicode(String data, int mode, { int alignment = 0 }) async {
    final Map<String, dynamic> params = <String, dynamic>{
      'data': data,
      'mode': mode,
      'alignment' : alignment
    };
    return await _channel.invokeMethod('printMaxicode', params);
  }

  Future<int?> printAztec(String data, int moduleSize, int eccLevel, int mode, { int alignment = 0 }) async {
    final Map<String, dynamic> params = <String, dynamic>{
      'data': data,
      'module_size': moduleSize,
      'ecc_level': eccLevel,
      'mode': mode,
      'alignment' : alignment
    };
    return await _channel.invokeMethod('printAztec', params);
  }

  Future<int?> printLine(int x1, int y1, int x2, int y2, int thickness) async {
    final Map<String, dynamic> params = <String, dynamic>{
      'x1': x1,
      'y1': y1,
      'x2': x2,
      'y2': y2,
      'thickness': thickness,
    };
    return await _channel.invokeMethod('printLine', params);
  }

  Future<int?> printBox(int left, int top, int right, int bottom, int thickness) async {
    final Map<String, dynamic> params = <String, dynamic>{
      'left': left,
      'top': top,
      'right': right,
      'bottom': bottom,
      'thickness': thickness,
    };
    return await _channel.invokeMethod('printBox', params);
  }

  Future<int?> cutPaper(int cutType) async {
    final Map<String, dynamic> params = <String, dynamic>{
      'cut_type': cutType
    };
    return await _channel.invokeMethod('cutPaper', params);
  }

  Future<int?> openDrawer(int pinNumber, { int onTime = 25, int offTime = 255 }) async {
    final Map<String, dynamic> params = <String, dynamic>{
      'pin_number': pinNumber,
      'on_time' : onTime,
      'off_time' : offTime
    };
    return await _channel.invokeMethod('openDrawer', params);
  }

  Future<String?> getModelName() async {
    return await _channel.invokeMethod('getModelName');
  }

  Future<String?> getFirmwareVersion() async {
    return await _channel.invokeMethod('getFirmwareVersion');
  }

  Future<String?> getStatisticsData(int info) async {
    final Map<String, dynamic> params = <String, dynamic>{
      'request_info': info
    };
    return await _channel.invokeMethod('getStatisticsData', params);
  }

  Future<int?> asbEnable(int enable) async {
    final Map<String, dynamic> params = <String, dynamic>{
      'enable': enable,
    };
    return await _channel.invokeMethod('asbEnable', params);
  }

  Stream<int> get printerStatusEventStream {
    return _printerStatusChannel.receiveBroadcastStream().cast();
  }

  Stream<void> get outputCompletedEventStream {
    return _outputCompletedChannel.receiveBroadcastStream().cast();
  }

  Future<int?> checkPrinterStatus() async {
    return await _channel.invokeMethod('checkPrinterStatus') ?? -1;
  }

  Future<int?> checkBattStatus() async {
    return await _channel.invokeMethod('checkBattStatus') ?? -1;
  }

  /*
  Future<int?> displayString(String data, int characterset, int internationalCharacterset, int line) async {
    final Map<String, dynamic> params = <String, dynamic>{
      'data' : data,
      'character_set': characterset,
      'international_character_set': internationalCharacterset,
      'line': line
    };
    return await _channel.invokeMethod('displayString', params);
  }

  Future<int?> clearScreen() async {
    return await _channel.invokeMethod('clearScreen');
  }

  Future<int?> storeImageFile(String fileName, int width, int imageNumber) async {
    final Map<String, dynamic> params = <String, dynamic>{
      'file_name' : fileName,
      'width': width,
      'image_number': imageNumber
    };
    return await _channel.invokeMethod('storeImageFile', params);
  }

  Future<int?> storeBase64Image(String data, int width, int imageNumber) async {
    final Map<String, dynamic> params = <String, dynamic>{
      'data' : data,
      'width': width,
      'image_number': imageNumber
    };
    return await _channel.invokeMethod('storeBase64Image', params);
  }

  Future<int?> displayIamge(int xPosition, int yPosition, int imageNumber) async {
    final Map<String, dynamic> params = <String, dynamic>{
      'x_pos': yPosition,
      'y_pos': yPosition,
      'image_number': imageNumber
    };
    return await _channel.invokeMethod('displayIamge', params);
  }

  Future<int?> clearIamge(int imageNumber) async {
    final Map<String, dynamic> params = <String, dynamic>{
      'image_number': imageNumber
    };
    return await _channel.invokeMethod('clearIamge', params);
  }

  Future<int?> showCursor(int showCursor) async {
    final Map<String, dynamic> params = <String, dynamic>{
      'show_cursor': showCursor
    };
    return await _channel.invokeMethod('showCursor', params);
  }
*/

  /*
  Future<int?> msrReady() async {
    return await _channel.invokeMethod('msrReady');
  }

  Future<String?> getTrack1Data() async {
    return await _channel.invokeMethod('getTrack1Data');
  }

  Future<String?> getTrack2Data() async {
    return await _channel.invokeMethod('getTrack2Data');
  }

  Future<String?> getTrack3Data() async {
    return await _channel.invokeMethod('getTrack3Data');
  }
*/

  /*
  Future<List<int>?> powerUpSCR() async {
    final atrData = await _channel.invokeMethod('powerUpSCR');
    List<int>? array = [];
    for(final item in atrData){
      array.add(item as int);
    }
    return array;
  }

  Future<int?> powerDownSCR() async {
    return await _channel.invokeMethod('powerDownSCR');
  }

  Future<int?> setSCROperationMode(int operationMode) async {
    final Map<String, dynamic> params = <String, dynamic>{
      'mode': operationMode
    };
    return await _channel.invokeMethod('setSCROperationMode', params);
  }

  Future<int?> setSCRCardType(int cardType) async {
    final Map<String, dynamic> params = <String, dynamic>{
      'card_type': cardType
    };
    return await _channel.invokeMethod('setSCRCardType', params);
  }

  Future<List<int>?> exchangeSCRData(List<int> data) async {
    final Map<String, dynamic> params = <String, dynamic>{
      'data_array': data
    };
    final responseData = await _channel.invokeMethod('exchangeSCRData', params);
    List<int>? array = [];
    for(final item in responseData){
      array.add(item as int);
    }
    return array;
  }

  Future<int?> getSCRCardStatus() async {
    return await _channel.invokeMethod('getSCRCardStatus') ?? -1;
  }
*/

}