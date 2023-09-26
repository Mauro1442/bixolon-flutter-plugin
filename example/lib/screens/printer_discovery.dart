import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:bxlflutterbgatelib/mposlookup.dart';
import 'package:bxlflutterbgatelib_example/models/printer_connection_info.dart';
import 'constants.dart';

class PrinterDiscoveryPage extends StatefulWidget {
  const PrinterDiscoveryPage({Key? key}) : super(key: key);

  @override
  _PrinterDiscoveryPageState createState() => _PrinterDiscoveryPageState();
}

class _PrinterDiscoveryPageState extends State<PrinterDiscoveryPage> {
  List<MPosDevice>? _deviceList;
  bool _isRrefreshing = false;

  @override
  void initState() {
    super.initState();
    refreshDeviceList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child: AppBar(
          title: const Text('Device Discovery'),
          flexibleSpace: kAppbarGradient,
          actions: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: IconButton(
                  onPressed: () {
                    if (!_isRrefreshing) {
                      refreshDeviceList();
                    }
                  },
                  icon: const Icon(Icons.refresh)),
            ),
          ],
        ),
      ),
      body: _deviceList != null
          ? (_deviceList!.isNotEmpty
              ? ListView.builder(
                  itemCount: _deviceList!.length,
                  itemBuilder: _buildRow,
                )
              : const Center(
                  child: Text('No Devices Found'),
                ))
          : const Center(
              child: CircularProgressIndicator(
                color: Colors.orange,
              ),
            ),
    );
  }

  Widget _buildRow(BuildContext context, int i) {
    MPosDevice device = _deviceList!.elementAt(i);
    IconData iconData = Icons.usb;
    if (device.interfaceType == 1 || device.interfaceType == 2) {
      iconData = Icons.network_wifi;
    } else if (device.interfaceType == 4 || device.interfaceType == 8) {
      iconData = Icons.bluetooth;
    }

    return Container(
      margin: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        gradient: kOrangeGradientDecoration,
      ),
      child: ListTile(
        onTap: () => {Navigator.pop(context, device)},
        title: Row(
          children: [
            Icon(
              iconData,
              color: Colors.white,
            ),
            const SizedBox(
              width: 20,
              height: 70,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  device.deviceName,
                  style: const TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
                Text(
                  device.address,
                  style: const TextStyle(color: Colors.white),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void refreshDeviceList() async {
    _isRrefreshing = true;
    setState(() {
      _deviceList = null;
    });
    List<MPosDevice> deviceList = [];

    // Discovery for Bluetooth Device
    String? jsonString = await MPosLookup.getBluetoothDevices() ?? '[]';
    Iterable l = json.decode(jsonString);
    List<MPosDevice> list =
        List<MPosDevice>.from(l.map((device) => MPosDevice.fromJON(device)));
    deviceList.addAll(list);

    // Discovery for BLE (Bluetooth Low Energy) Device
    jsonString = await MPosLookup.getBLEDevices() ?? '[]';
    l = json.decode(jsonString);
    list = List<MPosDevice>.from(l.map((device) => MPosDevice.fromJON(device)));
    for (var device in list) {
      deviceList.add(device);
    }

    // Discovery for Network Device
    jsonString = await MPosLookup.getNetworkDevices() ?? '[]';
    l = json.decode(jsonString);
    list = List<MPosDevice>.from(l.map((device) => MPosDevice.fromJON(device)));
    for (var device in list) {
      deviceList.add(device);
    }

    // Discovery for USB Device (Android Only)
    jsonString = await MPosLookup.getUSBDevices() ?? '[]';
    l = json.decode(jsonString);
    list = List<MPosDevice>.from(l.map((device) => MPosDevice.fromJON(device)));
    for (var device in list) {
      deviceList.add(device);
    }

    // Update State
    setState(() {
      _deviceList = deviceList;
    });
    _isRrefreshing = false;
  }
}
