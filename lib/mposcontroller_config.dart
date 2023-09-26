import 'dart:async';
import 'package:flutter/services.dart';

class MPosControllerConfig {

  static const MethodChannel _channel = MethodChannel('com.bixolon.mposcontroller/config');

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

  Future<String?> searchDevices() async {
    return await _channel.invokeMethod('searchDevices');
  }

  Future<String?> getBgateSerialNumber() async {
    return await _channel.invokeMethod('getBgateSerialNumber');
  }

  Future<String?> getUSBDevice(int deviceId) async {
    final Map<String, dynamic> params = <String, dynamic>{
      'device_id' : deviceId
    };
    return await _channel.invokeMethod('getUSBDevice', params);
  }

  Future<List<String>?> getCustomDevices(int deviceType) async {
    final Map<String, dynamic> params = <String, dynamic>{
      'device_type' : deviceType
    };
    final devices = await _channel.invokeMethod('getCustomDevices', params);
    List<String>? array = [];
    for(final item in devices){
      array.add(item as String);
    }
    return array;
  }

  Future<List<int>?> getSerialConfig(int deviceId) async {
    final Map<String, dynamic> params = <String, dynamic>{
      'device_id' : deviceId
    };
    final configs = await _channel.invokeMethod('getSerialConfig', params);
    List<int>? array = [];
    for(final item in configs){
      array.add(item as int);
    }
    return array;
  }

  Future<List<int>?> getSerialConfiguration(int deviceId) async {
    final Map<String, dynamic> params = <String, dynamic>{
      'device_id' : deviceId
    };
    final configs = await _channel.invokeMethod('getSerialConfiguration', params);
    List<int>? array = [];
    for(final item in configs){
      array.add(item as int);
    }
    return array;
  }

  Future<List<int>?> setSerialConfig(int deviceId, int baudRate, int dataBit, int stopBit, int parityBit) async {
    final Map<String, dynamic> params = <String, dynamic>{
      'device_id' : deviceId,
      'baud_rate' : baudRate,
      'data_bit' : dataBit,
      'stop_bit' : stopBit,
      'parity_bit' : parityBit
    };
    return await _channel.invokeMethod('setSerialConfig', params);
  }

  Future<List<int>?> setSerialConfiguration(int deviceId, int baudRate, int dataBit, int stopBit, int parityBit, int flowControl) async {
    final Map<String, dynamic> params = <String, dynamic>{
      'device_id' : deviceId,
      'baud_rate' : baudRate,
      'data_bit' : dataBit,
      'stop_bit' : stopBit,
      'parity_bit' : parityBit,
      'flow_control' : flowControl
    };
    return await _channel.invokeMethod('setSerialConfiguration', params);
  }

  Future<int?> addCustomDevice(int deviceType, String vid, String pid) async {
    final Map<String, dynamic> params = <String, dynamic>{
      'device_type' : deviceType,
      'vid' : vid,
      'pid' : pid
    };
    return await _channel.invokeMethod('addCustomDevice', params);
  }

  Future<int?> deleteCustomDevice(int deviceType, String vid, String pid) async {
    final Map<String, dynamic> params = <String, dynamic>{
      'device_type' : deviceType,
      'vid' : vid,
      'pid' : pid
    };
    return await _channel.invokeMethod('deleteCustomDevice', params);
  }

  Future<int?> reInitCustomDeviceType(int deviceType) async {
    final Map<String, dynamic> params = <String, dynamic>{
      'device_type' : deviceType
    };
    return await _channel.invokeMethod('reInitCustomDeviceType', params);
  }

}