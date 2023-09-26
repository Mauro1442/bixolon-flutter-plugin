import 'dart:async';
import 'package:flutter/services.dart';

class MPosLookup {
  static const MethodChannel _channel = MethodChannel('com.bixolon.mposlookup');

  static Future<String?> getBluetoothDevices() async {
    final String? devListJson = await _channel.invokeMethod('getBluetoothDevices');
    return devListJson;
  }

  static Future<String?> getNetworkDevices() async {
    final String? devListJson = await _channel.invokeMethod('getNetworkDevices');
    return devListJson;
  }

  static Future<String?> getBLEDevices() async {
    final String? devListJson = await _channel.invokeMethod('getBLEDevices');
    return devListJson;
  }

  static Future<String?> getUSBDevices() async {
    final String? devListJson = await _channel.invokeMethod('getUSBDevices');
    return devListJson;
  }
}