

class MPosDevice {
  int interfaceType = 0;
  String deviceName = '';
  String address = '';
  String productName = '';
  static MPosDevice fromJON(Map<String, dynamic> json) {
    var device = MPosDevice();
    device.address = json['address'] ?? '';
    device.deviceName = json['device_name'] ?? '';
    device.interfaceType = json['interface_type'] ?? -1;
    device.productName = json['product_name'] ?? '';
    return device;
  }
}

class MPosDeviceID {
  int deviceID = 0;
  String deviceType = '';
  String vidPid = '';
  static MPosDeviceID fromJON(Map<String, dynamic> json) {
    var device = MPosDeviceID();
    device.deviceID = json['device_id'];
    device.deviceType = json['device_type'];
    device.vidPid = json['vid_pid'];
    return device;
  }
}