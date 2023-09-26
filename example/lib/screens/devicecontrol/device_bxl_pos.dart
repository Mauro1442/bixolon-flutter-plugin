import 'dart:convert';
import 'dart:io';
import 'package:bxlflutterbgatelib/mposcontroller_printer.dart';
import 'package:bxlflutterbgatelib_example/models/printer_connection_info.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';

class ReceiptPrinterController {
  final MPosControllerPrinter _printer = MPosControllerPrinter();

  void listenPrinterStatusEventStream(Function func) {
    if (printerStatusEventStream != null) {
      _printer.printerStatusEventStream.listen((event) {
        func(event);
      });
    }
  }

  void listenOutputCompletedEventStream(Function func) {
    if (outputCompletedEventStream != null) {
      _printer.outputCompletedEventStream.listen((event) {
        func();
      });
    }
  }

  Stream<int>? get printerStatusEventStream {
    return _printer.printerStatusEventStream;
  }

  Stream<void>? get outputCompletedEventStream {
    return _printer.outputCompletedEventStream;
  }

  Future<int> connect(MPosDevice? connectionInfo,
      {int deviceId = -1, int timeout = 3}) async {
    if (connectionInfo == null) {
      return 1000;
    }
    await _printer.selectInterface(
        connectionInfo.interfaceType, connectionInfo.address);
    await _printer.selectCommandMode(deviceId < 0 ? 1 : 0);
    await _printer.setKeepNetworkConnection(1);
    var result =
        await _printer.openService(deviceId: deviceId, timeout: timeout) ??
            1000;
    if (result == 0) {
      // call 'asbEnable' with 1 for getting a event for printer status
      await _printer.asbEnable(1);
    }
    return result;
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

  Future<void> printInLineMode() async {
    try {
      await _printer.setTransaction(1 /*Transaction In*/);
      await _printer.setCharacterset(0 /*PC437*/);
      await _printer.setInternationalCharacterset(0 /*USA*/);
      await _printer.printText('Left\n', alignment: 0);
      await _printer.printText('Center\n', alignment: 1);
      await _printer.printText('Right\n', alignment: 2);
      await _printer.printText('Bitmap Font A\n', fontType: 0);
      await _printer.printText('Bitmap Font B\n', fontType: 1);
      await _printer.printText('Bitmap Font C\n', fontType: 2);
      await _printer.printText('Bold\n', bold: 1);
      await _printer.printText('Underline\n', underline: 2);
      await _printer.printText('Reverse\n', reverse: 1);
      await _printer.printText('Double Size\n', fontWidth: 1, fontHeight: 1);
      await _printer.print1DBarcode('{C1234567890', 110 /*Code128*/, 2, 50,
          alignment: 0, textPostion: 2);
      await _printer.printQRCode("http://www.bixolon.com", 205, 4, 51);
      await _printer.printPDF417("http://www.bixolon.com", 201, 0, 0, 2, 4, 4);

      // Image File
      final imageBytes = await rootBundle.load('testfiles/logo.png');
      var base64Data = base64Encode(imageBytes.buffer.asUint8List());
      await _printer.printBase64Image(base64Data, 384, alignment: 1);
      await _printer.cutPaper(65 /* Partial cut with feeds*/);
    } catch (e) {
      print(e);
    } finally {
      // start Printing.
      await _printer.setTransaction(0 /*Transaction Out,*/);
    }
  }

  Future<void> printInPageMode() async {
    try {
      /*
      await _printer.setPagemode(1 /*PAGE MODE IN*/);
      await _printer.setCharacterset(0);
      await _printer.setInternationalCharacterset(0);
      await _printer.setPagemodePrintArea(0, 0, 384, 400);
      await _printer.setPagemodeDirection(0);
      await _printer.printText('LEFT TO RIGHT');
      await _printer.setPagemodeDirection(1);
      await _printer.printText('BOTTOM TO TOP');
      await _printer.setPagemodeDirection(2);
      await _printer.printText('RIGHT TO LEFT',);
      await _printer.setPagemodeDirection(3);
      await _printer.printText('TOP TO BOTTOM');
      await _printer.setPagemode(0 /*PAGE MODE OUT*/);
    */
      var yPositionInDot = 50;
      await _printer.setPagemode(1 /*PAGE MODE IN*/);
      await _printer.setPagemodePrintArea(0, 0, 384, 384);
      await _printer.setPagemodeDirection(3);
      await _printer.setPagemodePosition(30, yPositionInDot);
      await _printer.printText('PAGE MODE #1');
      yPositionInDot += 30;
      await _printer.setPagemodePosition(30, yPositionInDot);
      await _printer.printText('PAGE MODE #2');
      yPositionInDot += 30;
      await _printer.setPagemodePosition(30, yPositionInDot);
      await _printer.print1DBarcode('{C1234567890', 110, 2, 50);
      yPositionInDot += 70;
      await _printer.setPagemodePosition(30, yPositionInDot);
    } catch (e) {
      print(e);
    } finally {
      // start Printing.
      await _printer.setPagemode(0 /*PAGE MODE OUT*/);
    }
  }

  Future<int> printPDFFile() async {
    int apiResult = 1000;
    try {
      await _printer.setTransaction(1 /*Transaction In*/);
      String pdfFilePath = (await getTemporaryDirectory()).path + '/testPdfFile.pdf';
      final pdfBytes = await rootBundle.load('testfiles/testPdfFile.pdf');
      final buffer = pdfBytes.buffer;
      await File(pdfFilePath).writeAsBytes(
          buffer.asUint8List(pdfBytes.offsetInBytes, pdfBytes.lengthInBytes));
      apiResult = await _printer.printPDFFile(pdfFilePath, 384, 0, 0, alignment: 1) ?? 1000;
      //await _printer.cutPaper(65 /* Partial cut with feeds*/);
    } catch (e) {
      print(e);
    } finally {
      // start Printing.
      await _printer.setTransaction(0 /*Transaction Out,*/);
    }
    return apiResult;
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
