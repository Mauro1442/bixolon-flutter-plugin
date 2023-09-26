import 'dart:convert';
import 'dart:io';
import 'package:bxlflutterbgatelib/mposcontroller_labelprinter.dart';
import 'package:bxlflutterbgatelib_example/models/printer_connection_info.dart';
import 'package:bxlflutterbgatelib_example/models/printer_label_info.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';


class LabelPrinterController {
  final MPosControllerLabelPrinter _printer = MPosControllerLabelPrinter();
  final PrinterLabelInfo labelInfo;
  LabelPrinterController({required this.labelInfo});

  void listenOutputCompletedEventStream(Function func) {
    if (outputCompletedEventStream != null) {
      _printer.outputCompletedEventStream.listen((event) {
        func();
      });
    }
  }

  Stream<void>? get outputCompletedEventStream {
    return _printer.outputCompletedEventStream;
  }

  Future<int> connect(MPosDevice? connectionInfo, {int deviceId = -1, int timeout = 3}) async {
    if (connectionInfo == null) {
      return 1000;
    }
    await _printer.selectInterface(
        connectionInfo.interfaceType, connectionInfo.address);
    await _printer.selectCommandMode(deviceId < 0 ? 1 : 0);
    await _printer.setKeepNetworkConnection(1);
    return await _printer.openService(deviceId: deviceId, timeout: timeout) ?? 1000;

  }

  Future<void> disconnect({int timeout = 3}) async {
    if (await _printer.isOpen() != 0) {
      await _printer.closeService(timeout: timeout);
    }
  }

  Future<int> checkPrinterStatus() async {
    int? status = -1;
    try {
      status = await _printer.checkPrinterStatus();
    } catch (e) {
      print(e);
    }
    return status!;
  }

  Future<void> printLabel() async {
    try {
      await _printer.setTransaction(1 /*Transaction In*/);
      //double dotsPerUnit = (await _printer.getPrinterDPI())!.toDouble() / 25.4;
      double dotsPerUnit = (labelInfo.dpi / 25.4);
      await _printer.setDensity(10);
      await _printer.setMargin(0, 0);
      final orientation = PrintOrientation.values[labelInfo.orientation].convertedText;
      await _printer.setOrientation(orientation);
      await _printer.setAutoCutter(labelInfo.cutEnable, 0);
      await _printer.setRewinder(0);
      await _printer.setWidth((dotsPerUnit * labelInfo.labelWidth).round());
      final mediaType = LabelMediaType.values[labelInfo.mediaType].convertedText;
      await _printer.setLength((dotsPerUnit * labelInfo.labelHeight).round(), (dotsPerUnit * 3).round(), mediaType, 0);
      await _printer.drawBlock(4, 10, (dotsPerUnit * 52).round(), (dotsPerUnit * 73).round(), 'B', (dotsPerUnit * 2).round());
      await _printer.setCharacterset(0 /*PC437*/, 0 /*USA*/);
      await _printer.drawTextDeviceFont('Bitmap Font', (dotsPerUnit * 6).round(), (dotsPerUnit * 7).round(), '4', 1, 1, 0);
      await _printer.drawTextVectorFont('Vector Font', (dotsPerUnit * 6).round(), (dotsPerUnit * 13).round(), 'U', 30, 30);
      await _printer.drawBarcode1D('0987654321', (dotsPerUnit * 6).round(), (dotsPerUnit * 19).round(), 1, 2, 2, 128, 5);
      final imageBytes = await rootBundle.load('testfiles/logo.png');
      var base64Data = base64Encode(imageBytes.buffer.asUint8List());
      await _printer.drawBase64Image(base64Data, (dotsPerUnit * 6).round(), (dotsPerUnit * 46).round(), 300);
      await _printer.printBuffer(1);
    } catch (e) {
      print(e);
    } finally {
      // start Printing.
      await _printer.setTransaction(0 /*Transaction Out,*/);
    }
  }

  Future<void> printBarcodes() async {
    try {
      await _printer.setTransaction(1 /*Transaction In*/);

      //double dotsPerUnit = (await _printer.getPrinterDPI())!.toDouble() / 25.4;
      double dotsPerUnit = (labelInfo.dpi / 25.4);
      await _printer.setDensity(10);
      await _printer.setMargin(0, 0);
      final orientation = PrintOrientation.values[labelInfo.orientation].convertedText;
      await _printer.setOrientation(orientation);
      await _printer.setAutoCutter(labelInfo.cutEnable, 0);
      await _printer.setRewinder(0);
      await _printer.setOffset(0);
      await _printer.setCuttingPosition(0);
      await _printer.setWidth((dotsPerUnit * 52).round());
      final mediaType = LabelMediaType.values[labelInfo.mediaType].convertedText;
      await _printer.setLength(
          (dotsPerUnit * 360).round(), (dotsPerUnit * 3).round(), mediaType, 0);
      await _printer.drawBlock(
          (dotsPerUnit * 8).round(),
          (dotsPerUnit * 7).round(),
          (dotsPerUnit * 32).round(),
          (dotsPerUnit * 23).round(),
          'B',
          3);
      await _printer.drawCircle(
          (dotsPerUnit * 35).round(), (dotsPerUnit * 7).round(), 3, 2);
      //await _printer.drawBarcode1D('12345%+-.', (dotsPerUnit * 10).round(), (dotsPerUnit * 10).round(), 0, 1, 2, 80);
      //await _printer.drawBarcode1D('>A1234567890', (dotsPerUnit * 10).round(), (dotsPerUnit * 30).round(), 1, 1, 2, 80);
      await _printer.drawBarcodeMaxiCode('This is a MaxiCode',
          (dotsPerUnit * 10).round(), (dotsPerUnit * 50).round(), 4);
      await _printer.drawBarcodePDF417(
          'This is a PDF417',
          (dotsPerUnit * 10).round(),
          (dotsPerUnit * 85).round(),
          30, 5, 0, 0, 0, 1, 2, 4);
      await _printer.drawBarcodeQRCode('This is a QRCode', (dotsPerUnit * 10).round(),
          (dotsPerUnit * 95).round(), 4, 1, 51);
      await _printer.drawBarcodeDataMatrix('This is a DataMatrix',
          (dotsPerUnit * 10).round(), (dotsPerUnit * 115).round(), 4);

      /*
      await _printer.drawBarcodeRSS('12345678901|this is composite info',
          (dotsPerUnit * 10).round(),
          (dotsPerUnit * 10).round(),
          0/*RSS14*/, 2, 1, 20, 10
      );

      await _printer.drawBarcodeTLC39('123456,ABCD12345678901234,5551212,88899',
          (dotsPerUnit * 10).round(),
          (dotsPerUnit * 10).round(),
          2, 4, 50, 3, 2
      );

      await _printer.drawBarcodePlessey('12345',
          (dotsPerUnit * 10).round(),
          (dotsPerUnit * 10).round(),
          2, 4, 60, 1, 0
      );

      await _printer.drawBarcodeMSI('123456',
          (dotsPerUnit * 10).round(),
          (dotsPerUnit * 10).round(),
          2, 4, 75, 1, 1, 0
      );

      await _printer.drawBarcodeIMB('0123456709498765432101234567891',
          (dotsPerUnit * 10).round(),
          (dotsPerUnit * 10).round(), 1
      );

      await _printer.drawBarcodeMicroPDF('This is a Micro-PDF',
          (dotsPerUnit * 10).round(),
          (dotsPerUnit * 10).round(), 3, 3, 12
      );

      await _printer.drawBarcodeCodaBlock('BIXOLON BARCODE TEST 123BIXOLON BARCODE TEST 123BIXOLON BARCODE TEST 123BIXOLON BARCODE TEST 123',
          (dotsPerUnit * 10).round(),
          (dotsPerUnit * 10).round(),
          2, 4, 30, 0, 30, 'F', 4
      );

      await _printer.drawBarcodeCode49('This is a Code49',
          (dotsPerUnit * 10).round(),
          (dotsPerUnit * 10).round(),
          1, 2, 80, 0, 7
      );

      await _printer.drawBarcodeAztec('This is an Aztec Code',
          (dotsPerUnit * 10).round(),
          (dotsPerUnit * 10).round(),
          5, 0, 0, 0, 1, '1'
      );
       */
      await _printer.printBuffer(1);
    } catch (e) {
      print(e);
    } finally {
      // start Printing.
      await _printer.setTransaction(0 /*Transaction Out,*/);
    }
  }

  Future<int> printPDFFile() async {
    int apiResult = 1000;
    try {
      await _printer.setTransaction(1 /*Transaction In*/);
      //double dotsPerUnit = (await _printer.getPrinterDPI())!.toDouble() / 25.4;
      double dotsPerUnit = (labelInfo.dpi / 25.4);
      await _printer.setDensity(10);
      await _printer.setMargin(0, 0);
      final orientation = PrintOrientation.values[labelInfo.orientation].convertedText;
      await _printer.setOrientation(orientation);
      await _printer.setAutoCutter(labelInfo.cutEnable, 0);
      await _printer.setWidth((dotsPerUnit * labelInfo.labelWidth).round());
      final mediaType = LabelMediaType.values[labelInfo.mediaType].convertedText;
      await _printer.setLength(
          (dotsPerUnit * labelInfo.labelHeight).round(), (dotsPerUnit * 3).round(), mediaType, 0);

      String pdfFilePath = (await getTemporaryDirectory()).path + '/testPdfFile.pdf';
      final pdfBytes = await rootBundle.load('testfiles/testPdfFile.pdf');
      final buffer = pdfBytes.buffer;
      await File(pdfFilePath).writeAsBytes(buffer.asUint8List(pdfBytes.offsetInBytes, pdfBytes.lengthInBytes));
      apiResult = await _printer.drawPDFFile(pdfFilePath, (dotsPerUnit * 10).round(), (dotsPerUnit * 10).round(), (dotsPerUnit * 48).round(), 0) ?? 1000;

      await _printer.printBuffer(1);
    } catch (e) {
      print(e);
    } finally {
      // start Printing.
      await _printer.setTransaction(0 /*Transaction Out,*/);
    }
    return apiResult;
  }

  Future<void> rfidCalibration() async {
    try {
      await _printer.setTransaction(1 /*Transaction In*/);
      await _printer.calibrateRFID();
    } catch (e) {
      print(e);
    } finally {
      // start Printing.
      await _printer.setTransaction(0 /*Transaction Out,*/);
    }
  }

  Future<void> rfidTagWriting() async {
    try {
      await _printer.setTransaction(1 /*Transaction In*/);
      const dotsPerUnit = 203 / 25.4;
      await _printer.drawTextVectorFont("RFID TEST", (dotsPerUnit * 10).round(), (dotsPerUnit * 10).round(), 'U', 30, 30);
      //await _printer.setRFIDPosition(20);
      //await _printer.setEPCDataStructure(64, '2,3,14,20,25');
      await _printer.setupRFID(5 /*EPC GEN2*/, 3, 2, 15);
      await _printer.writeRFID(65 /*ASCII*/, 4, '987654321012'.length, '987654321012');
      await _printer.printBuffer(1);
    } catch (e) {
      print(e);
    } finally {
      // start Printing.
      await _printer.setTransaction(0 /*Transaction Out,*/);
    }
  }

  Future<String?> getFirmwareVersion() async {
    String? resultString = '';
    try {
      resultString = await _printer.getFirmwareVersion();
    } catch (e) {
      print(e);
    }
    return resultString;
  }

  Future<String?> getModelName() async {
    String? resultString = '';
    try {
      resultString = await _printer.getModelName();
    } catch (e) {
      print(e);
    }
    return resultString;
  }

  Future<String?> getStatisticsData(int info) async {
    String? resultString = '';
    try {
      resultString = await _printer.getStatisticsData(info);
    } catch (e) {
      print(e);
    }
    return resultString;
  }

}