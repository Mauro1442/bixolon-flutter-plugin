import 'package:bxlflutterbgatelib/mposcontroller_config.dart';
import 'package:bxlflutterbgatelib_example/models/printer_connection_info.dart';

class BgateConfigController {
  final MPosControllerConfig _config = MPosControllerConfig();

  Future<bool> connect(MPosDevice? connectionInfo,
      {int deviceId = 0, int timeout = 3}) async {
    if (connectionInfo == null) {
      return false;
    }
    await _config.selectInterface(
        connectionInfo.interfaceType, connectionInfo.address);
    await _config.selectCommandMode(0 /*via B-gate*/);
    await _config.setKeepNetworkConnection(1);
    var result =
        await _config.openService(deviceId: deviceId, timeout: timeout) ?? 1000;
    if (result == 0) {
      return true;
    }
    return false;
  }

  Future<void> disconnect({int timeout = 3}) async {
    if (await _config.isOpen() != 0) {
      await _config.closeService(timeout: timeout);
    }
  }

  Future<String?> searchDevices() async {
    return await _config.searchDevices();
  }

  Future<String?> getBgateSerialNumber() async {
    return await _config.getBgateSerialNumber();
  }

  Future<String?> getUSBDevice(int deviceId) async {
    // get the USB VID&PID with the id
    return await _config.getUSBDevice(deviceId);
  }

  Future<int?> addCustomDevice(int deviceType, String vid, String pid) async {
    return await _config.addCustomDevice(deviceType, vid, pid);
  }

  Future<int?> deleteCustomDevice(int deviceType, String vid, String pid) async {
    return await _config.deleteCustomDevice(deviceType, vid, pid);
  }

  Future<int?> reInitCustomDeviceType(int deviceType) async {
    return await _config.reInitCustomDeviceType(deviceType);
  }

  Future<List<String>?> getCustomDevices(int deviceType) async {
    return await _config.getCustomDevices(deviceType);
  }

  Future<List<int>?> getSerialConfig(int deviceId) async {
    return await _config.getSerialConfig(deviceId);
  }

  Future<List<int>?> getSerialConfiguration(int deviceId) async {
    return await _config.getSerialConfiguration(deviceId);
  }

  Future<List<int>?> setSerialConfig(int deviceId, int baudRate, int dataBit, int stopBit, int parityBit) async {
    return await _config.setSerialConfig(deviceId, baudRate, dataBit, stopBit, parityBit);
  }

  Future<List<int>?> setSerialConfiguration(int deviceId, int baudRate, int dataBit, int stopBit, int parityBit, int flowControl) async {
    return await _config.setSerialConfiguration(deviceId, baudRate, dataBit, stopBit, parityBit, flowControl);
  }

}