import 'dart:async';
import 'package:flutter/services.dart';

class MPosControllerLabelPrinter {

  static const MethodChannel _channel = MethodChannel('com.bixolon.mposcontroller/labelprinter');
  static const EventChannel _outputCompletedChannel = EventChannel('com.bixolon.mposcontroller/labelprinter/outputcompleted');

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

  Future<int?> setCharacterset(int characterset, int internationalCharacterset) async {
    final Map<String, dynamic> params = <String, dynamic>{
      'character_set' : characterset,
      'international_character_set' : internationalCharacterset
    };
    return await _channel.invokeMethod('setCharacterset', params);
  }

  Future<int?> checkPrinterStatus() async {
    return await _channel.invokeMethod('checkPrinterStatus') ?? -1;
  }

  Future<int?> printBuffer(int numberOfCopies) async {
    final Map<String, dynamic> params = <String, dynamic>{
      'copies' : numberOfCopies,
    };
    return await _channel.invokeMethod('printBuffer', params);
  }

  Future<int?> drawTextDeviceFont(String data,
      int xPosition,
      int yPosition,
      String fontType,
      int fontWidth,
      int fontHeight,
      int rightSpace,
      {
        int rotation = 0,
        int reverse = 0,
        int bold = 0,
        int rightToLeft = 0,
        int alignment = 0
      }) async {
    final Map<String, dynamic> params = <String, dynamic>{
      'data': data,
      'x_pos' : xPosition,
      'y_pos' : yPosition,
      'font_type' : fontType,
      'font_width' : fontWidth,
      'font_height' : fontHeight,
      'right_space' : rightSpace,
      'rotation' : rotation,
      'reverse' : reverse,
      'bold' : bold,
      'right_to_left' : rightToLeft,
      'alignment' : alignment
    };
    return await _channel.invokeMethod('drawTextDeviceFont', params);
  }

  Future<int?> drawTextVectorFont(String data,
      int xPosition,
      int yPosition,
      String fontType,
      int fontWidth,
      int fontHeight,
      {
        int rightSpace = 0,
        int rotation = 0,
        int reverse = 0,
        int bold = 0,
        int italic = 0,
        int rightToLeft = 0,
        int alignment = 0
      }) async {
    final Map<String, dynamic> params = <String, dynamic>{
      'data': data,
      'x_pos' : xPosition,
      'y_pos' : yPosition,
      'font_type' : fontType,
      'font_width' : fontWidth,
      'font_height' : fontHeight,
      'right_space' : rightSpace,
      'rotation' : rotation,
      'reverse' : reverse,
      'bold' : bold,
      'italic' : italic,
      'right_to_left' : rightToLeft,
      'alignment' : alignment
    };
    return await _channel.invokeMethod('drawTextVectorFont', params);
  }

  Future<int?> drawBarcode1D(String data,
      int xPosition,
      int yPosition,
      int barcodeType,
      int widthNarrow,
      int widthWide,
      int height,
      int hri,
      {
        int rotation = 0,
        int quietZoneWidth = 0
      }) async {
    final Map<String, dynamic> params = <String, dynamic>{
      'data': data,
      'x_pos' : xPosition,
      'y_pos' : yPosition,
      'barcode_type' : barcodeType,
      'width_narrow' : widthNarrow,
      'width_wide' : widthWide,
      'height' : height,
      'hri' : hri,
      'rotation' : rotation,
      'quiet_zone_width' : quietZoneWidth
    };
    return await _channel.invokeMethod('drawBarcode1D', params);
  }

  Future<int?> drawBarcodeMaxiCode(String data, int xPosition, int yPosition, int mode) async {
    final Map<String, dynamic> params = <String, dynamic>{
      'data': data,
      'x_pos' : xPosition,
      'y_pos' : yPosition,
      'mode' : mode
    };
    return await _channel.invokeMethod('drawBarcodeMaxiCode', params);
  }

  Future<int?> drawBarcodePDF417(String data,
      int xPosition,
      int yPosition,
      int maximumRowCount,
      int maximumColumnCount,
      int eccLevel,
      int dataCompressionMethod,
      int hri,
      int originPoint,
      int moduleWidth,
      int barHeight,
      {int rotation = 0}
      ) async {
    final Map<String, dynamic> params = <String, dynamic>{
      'data': data,
      'x_pos' : xPosition,
      'y_pos' : yPosition,
      'maximum_row_count' : maximumRowCount,
      'maximum_column_count' : maximumColumnCount,
      'ecc_level' : eccLevel,
      'data_compression_method' : dataCompressionMethod,
      'hri' : hri,
      'origin_point' : originPoint,
      'module_width' : moduleWidth,
      'bar_height' : barHeight,
      'rotation' : rotation
    };
    return await _channel.invokeMethod('drawBarcodePDF417', params);
  }

  Future<int?> drawBarcodeQRCode(String data,
      int xPosition,
      int yPosition,
      int size,
      int model,
      int eccLevel,
      {int rotation = 0}) async {
    final Map<String, dynamic> params = <String, dynamic>{
      'data': data,
      'x_pos' : xPosition,
      'y_pos' : yPosition,
      'size' : size,
      'model' : model,
      'ecc_level' : eccLevel,
      'rotation' : rotation
    };
    return await _channel.invokeMethod('drawBarcodeQRCode', params);
  }

  Future<int?> drawBarcodeDataMatrix(String data,
      int xPosition,
      int yPosition,
      int size,
      {
        int reverse = 0,
        int rotation = 0
      }) async {
    final Map<String, dynamic> params = <String, dynamic>{
      'data': data,
      'x_pos' : xPosition,
      'y_pos' : yPosition,
      'size' : size,
      'reverse' : reverse,
      'rotation' : rotation
    };
    return await _channel.invokeMethod('drawBarcodeDataMatrix', params);
  }

  Future<int?> drawBarcodeAztec(String data,
      int xPosition,
      int yPosition,
      int size,
      int extendedChannel,
      int eccLevel,
      int menuSymbol,
      int numberOfSymbols,
      String optionalID,
      { int rotation = 0}) async {
    final Map<String, dynamic> params = <String, dynamic>{
      'data': data,
      'x_pos' : xPosition,
      'y_pos' : yPosition,
      'size' : size,
      'extended_channel' : extendedChannel,
      'ecc_level' : eccLevel,
      'menu_symbol' : menuSymbol,
      'number_of_symbols' : numberOfSymbols,
      'optional_id' : optionalID,
      'rotation' : rotation
    };
    return await _channel.invokeMethod('drawBarcodeAztec', params);
  }

  Future<int?> drawBarcodeCode49(String data,
      int xPosition,
      int yPosition,
      int widthNarrow,
      int widthWide,
      int height,
      int hri,
      int startingMode,
      { int rotation = 0 }) async {
    final Map<String, dynamic> params = <String, dynamic>{
      'data': data,
      'x_pos' : xPosition,
      'y_pos' : yPosition,
      'width_narrow' : widthNarrow,
      'width_wide' : widthWide,
      'height' : height,
      'hri' : hri,
      'starting_mode' : startingMode,
      'rotation' : rotation
    };
    return await _channel.invokeMethod('drawBarcodeCode49', params);
  }

  Future<int?> drawBarcodeCodaBlock(String data,
      int xPosition,
      int yPosition,
      int widthNarrow,
      int widthWide,
      int height,
      int securityLevel,
      int dataColumns,
      String mode,
      int rowsToEncode) async {
    final Map<String, dynamic> params = <String, dynamic>{
      'data': data,
      'x_pos' : xPosition,
      'y_pos' : yPosition,
      'width_narrow' : widthNarrow,
      'width_wide' : widthWide,
      'height' : height,
      'security_level' : securityLevel,
      'data_columns' : dataColumns,
      'mode' : mode,
      'rows_to_encode' : rowsToEncode
    };
    return await _channel.invokeMethod('drawBarcodeCodaBlock', params);
  }

  Future<int?> drawBarcodeMicroPDF(String data,
      int xPosition,
      int yPosition,
      int moduleWidth,
      int height,
      int mode,
      { int rotation = 0 }) async {
    final Map<String, dynamic> params = <String, dynamic>{
      'data': data,
      'x_pos' : xPosition,
      'y_pos' : yPosition,
      'module_width' : moduleWidth,
      'height' : height,
      'mode' : mode,
      'rotation' : rotation
    };
    return await _channel.invokeMethod('drawBarcodeMicroPDF', params);
  }

  Future<int?> drawBarcodeIMB(String data,
      int xPosition,
      int yPosition,
      int hri,
      { int rotation = 0 }) async {
    final Map<String, dynamic> params = <String, dynamic>{
      'data': data,
      'x_pos' : xPosition,
      'y_pos' : yPosition,
      'hri' : hri,
      'rotation' : rotation
    };
    return await _channel.invokeMethod('drawBarcodeIMB', params);
  }

  Future<int?> drawBarcodeMSI(String data,
      int xPosition,
      int yPosition,
      int widthNarrow,
      int widthWide,
      int height,
      int checkDigit,
      int printCheckDigit,
      int hri,
      { int rotation = 0 }) async {
    final Map<String, dynamic> params = <String, dynamic>{
      'data': data,
      'x_pos' : xPosition,
      'y_pos' : yPosition,
      'width_narrow' : widthNarrow,
      'width_wide' : widthWide,
      'height' : height,
      'check_digit' : checkDigit,
      'print_check_digit' : printCheckDigit,
      'hri' : hri,
      'rotation' : rotation
    };
    return await _channel.invokeMethod('drawBarcodeMSI', params);
  }

  Future<int?> drawBarcodePlessey(String data,
      int xPosition,
      int yPosition,
      int widthNarrow,
      int widthWide,
      int height,
      int printCheckDigit,
      int hri,
      { int rotation = 0 }) async {
    final Map<String, dynamic> params = <String, dynamic>{
      'data': data,
      'x_pos' : xPosition,
      'y_pos' : yPosition,
      'width_narrow' : widthNarrow,
      'width_wide' : widthWide,
      'height' : height,
      'print_check_digit' : printCheckDigit,
      'hri' : hri,
      'rotation' : rotation
    };
    return await _channel.invokeMethod('drawBarcodePlessey', params);
  }

  Future<int?> drawBarcodeTLC39(String data,
      int xPosition,
      int yPosition,
      int widthNarrow,
      int widthWide,
      int height,
      int rowHeightOfMicroPDF417,
      int narrowWidthOfMicroPDF417,
      { int rotation = 0 }) async {
    final Map<String, dynamic> params = <String, dynamic>{
      'data': data,
      'x_pos' : xPosition,
      'y_pos' : yPosition,
      'width_narrow' : widthNarrow,
      'width_wide' : widthWide,
      'height' : height,
      'row_height_of_micro_pdf417' : rowHeightOfMicroPDF417,
      'narrow_width_of_micro_pdf417' : narrowWidthOfMicroPDF417,
      'rotation' : rotation
    };
    return await _channel.invokeMethod('drawBarcodeTLC39', params);
  }

  Future<int?> drawBarcodeRSS(String data,
      int xPosition,
      int yPosition,
      int barcodeType,
      int magnification,
      int separatorHeight,
      int height,
      int segmentWidth,
      { int rotation = 0 }) async {
    final Map<String, dynamic> params = <String, dynamic>{
      'data': data,
      'x_pos' : xPosition,
      'y_pos' : yPosition,
      'barcode_type' : barcodeType,
      'magnification' : magnification,
      'separator_height' : separatorHeight,
      'height' : height,
      'segment_width' : segmentWidth,
      'rotation' : rotation
    };
    return await _channel.invokeMethod('drawBarcodeRSS', params);
  }

  Future<int?> drawBlock(int startPosX,
      int startPosY,
      int endPosX,
      int endPosY,
      String option,
      int thickness) async {
    final Map<String, dynamic> params = <String, dynamic>{
      'start_pos_x': startPosX,
      'start_pos_y' : startPosY,
      'end_pos_x': endPosX,
      'end_pos_y' : endPosY,
      'thickness' : thickness,
      'option' : option
    };
    return await _channel.invokeMethod('drawBlock', params);
  }

  Future<int?> drawCircle(int startPosX,
      int startPosY,
      int size,
      int multiplier) async {
    final Map<String, dynamic> params = <String, dynamic>{
      'start_pos_x': startPosX,
      'start_pos_y' : startPosY,
      'size' : size,
      'multiplier' : multiplier
    };
    return await _channel.invokeMethod('drawCircle', params);
  }

  Future<int?> drawBase64Image(String base64String,
      int xPosition,
      int yPosition,
      int width,
      {
        int threshold = 128,
        int ditheringType = 1,
        int compressType = 1
      }) async {
    final Map<String, dynamic> params = <String, dynamic>{
      'data': base64String,
      'x_pos' : xPosition,
      'y_pos' : yPosition,
      'width' : width,
      'threshold' : threshold,
      'dithering_type' : ditheringType,
      'compress_type' : compressType
    };
    return await _channel.invokeMethod('drawBase64Image', params);
  }

  Future<int?> drawImageFile(String fileName,
      int xPosition,
      int yPosition,
      int width,
      {
        int threshold = 128,
        int ditheringType = 1,
        int compressType = 1
      }) async {
    final Map<String, dynamic> params = <String, dynamic>{
      'file_name': fileName,
      'x_pos' : xPosition,
      'y_pos' : yPosition,
      'width' : width,
      'threshold' : threshold,
      'dithering_type' : ditheringType,
      'compress_type' : compressType
    };
    return await _channel.invokeMethod('drawImageFile', params);
  }

  Future<int?> drawPDFFile(String fileName,
      int xPosition,
      int yPosition,
      int width,
      int pageNumber,
      {
        int threshold = 128,
        int ditheringType = 0,
        int compressType = 1
      }) async {
    final Map<String, dynamic> params = <String, dynamic>{
      'file_name': fileName,
      'x_pos' : xPosition,
      'y_pos' : yPosition,
      'width' : width,
      'page_number' : pageNumber,
      'threshold' : threshold,
      'dithering_type' : ditheringType,
      'compress_type' : compressType
    };
    return await _channel.invokeMethod('drawPDFFile', params);
  }


  Future<int?> setPrintingType(String printingType) async {
    final Map<String, dynamic> params = <String, dynamic>{
      'printing_type': printingType,
    };
    return await _channel.invokeMethod('setPrintingType', params);
  }

  Future<int?> setMargin(int horizontalMargin, int verticalMargin) async {
    final Map<String, dynamic> params = <String, dynamic>{
      'horizontal_margin': horizontalMargin,
      'vertical_margin': verticalMargin
    };
    return await _channel.invokeMethod('setMargin', params);
  }

  Future<int?> setLength(int labelLength, int gapLength, String mediaType, int offsetLength) async {
    final Map<String, dynamic> params = <String, dynamic>{
      'label_length': labelLength,
      'gap_length': gapLength,
      'media_type': mediaType,
      'offset_length': offsetLength
    };
    return await _channel.invokeMethod('setLength', params);
  }

  Future<int?> setWidth(int labelWidth) async {
    final Map<String, dynamic> params = <String, dynamic>{
      'label_width': labelWidth
    };
    return await _channel.invokeMethod('setWidth', params);
  }

  Future<int?> setSpeed(int speed) async {
    final Map<String, dynamic> params = <String, dynamic>{
      'speed': speed
    };
    return await _channel.invokeMethod('setSpeed', params);
  }

  Future<int?> setDensity(int density) async {
    final Map<String, dynamic> params = <String, dynamic>{
      'density': density
    };
    return await _channel.invokeMethod('setDensity', params);
  }

  Future<int?> setOrientation(String orientation) async {
    final Map<String, dynamic> params = <String, dynamic>{
      'orientation': orientation
    };
    return await _channel.invokeMethod('setOrientation', params);
  }

  Future<int?> setOffset(int length) async {
    final Map<String, dynamic> params = <String, dynamic>{
      'length': length
    };
    return await _channel.invokeMethod('setOffset', params);
  }

  Future<int?> setCuttingPosition(int length) async {
    final Map<String, dynamic> params = <String, dynamic>{
      'length': length
    };
    return await _channel.invokeMethod('setCuttingPosition', params);
  }

  Future<int?> setAutoCutter(int enableAutoCutter, int cuttingPeriod) async {
    final Map<String, dynamic> params = <String, dynamic>{
      'enable_autocutter': enableAutoCutter,
      'cut_period': cuttingPeriod,
    };
    return await _channel.invokeMethod('setAutoCutter', params);
  }

  Future<int?> setRewinder(int enableRewinder) async {
    final Map<String, dynamic> params = <String, dynamic>{
      'enable_rewinder': enableRewinder
    };
    return await _channel.invokeMethod('setRewinder', params);
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

  Future<int?> getPrinterDPI() async {
    return await _channel.invokeMethod('getPrinterDPI');
  }

  Future<int?> getMaxWidth() async {
    return await _channel.invokeMethod('getMaxWidth');
  }

  Future<List<int>?> getSupportedSpeeds() async {
    final speeds = await _channel.invokeMethod('getSupportedSpeeds');
    List<int>? array = [];
    for(final item in speeds){
      array.add(item as int);
    }
    return array;
  }

  Future<int?> setupRFID(int rfidType, int numberOfRetries, int numberOfLabels, int radioPower) async {
    final Map<String, dynamic> params = <String, dynamic>{
      'rfid_type': rfidType,
      'number_of_retries': numberOfRetries,
      'number_of_labels' : numberOfLabels,
      'radio_power' : radioPower
    };
    return await _channel.invokeMethod('setupRFID', params);
  }

  Future<int?> calibrateRFID() async {
    return await _channel.invokeMethod('calibrateRFID');
  }

  Future<int?> setRFIDPosition(int transPosition) async {
    final Map<String, dynamic> params = <String, dynamic>{
      'trans_position': transPosition
    };
    return await _channel.invokeMethod('setRFIDPosition', params);
  }

  Future<int?> setRFIDPassword(String oldAccessPwd, String oldKillPwd, String newAccessPwd, String newKillPwd) async {
    final Map<String, dynamic> params = <String, dynamic>{
      'old_access_pwd': oldAccessPwd,
      'old_kill_pwd': oldKillPwd,
      'new_access_pwd': oldKillPwd,
      'new_kill_pwd': newKillPwd
    };
    return await _channel.invokeMethod('setRFIDPassword', params);
  }

  Future<int?> setEPCDataStructure(int totalSize, String fieldSizes) async {
    final Map<String, dynamic> params = <String, dynamic>{
      'total_size': totalSize,
      'field_sizes': fieldSizes,
    };
    return await _channel.invokeMethod('setEPCDataStructure', params);
  }

  Future<int?> writeRFID(int dataType, int startBlockNumber, int dataLength, String data) async {
    final Map<String, dynamic> params = <String, dynamic>{
      'data': data,
      'data_type': dataType,
      'start_block_number': startBlockNumber,
      'data_length': dataLength,
    };
    return await _channel.invokeMethod('writeRFID', params);
  }

  Future<int?> lockRFID() async {
    return await _channel.invokeMethod('lockRFID');
  }

  Stream<void> get outputCompletedEventStream {
    return _outputCompletedChannel.receiveBroadcastStream().cast();
  }

}