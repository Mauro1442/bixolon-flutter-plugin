import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:bxlflutterbgatelib_example/models/printer_connection_info.dart';
import 'devicecontrol/device_config.dart';
import 'constants.dart';

class PrinterIdListPage extends StatefulWidget {
  final MPosDevice? printerInfo;

  const PrinterIdListPage({Key? key, required this.printerInfo})
      : super(key: key);

  @override
  _PrinterIdListPageState createState() => _PrinterIdListPageState();
}

class _PrinterIdListPageState extends State<PrinterIdListPage> {
  List<MPosDeviceID>? _deviceIdList;
  bool _isRrefreshing = false;
  final BgateConfigController _configController = BgateConfigController();
  MPosDevice? _printerInfo;

  @override
  void initState() {
    super.initState();
    _printerInfo = null;
    _printerInfo = widget.printerInfo;
    refreshDeviceIdList();
  }

  @override
  void dispose() async {
    _configController.disconnect();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child: AppBar(
          title: const Text('Device ID List'),
          flexibleSpace: kAppbarGradient,
          actions: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: IconButton(
                  onPressed: () {
                    if (!_isRrefreshing) {
                      refreshDeviceIdList();
                    }
                  },
                  icon: const Icon(Icons.refresh)),
            ),
          ],
        ),
      ),
      body: _deviceIdList != null
          ? (_deviceIdList!.isNotEmpty
              ? ListView.builder(
                  itemCount: _deviceIdList!.length,
                  itemBuilder: _buildRow,
                )
              : const Center(
                  child: Text('NO Devices or NOT supported'),
                ))
          : const Center(
              child: CircularProgressIndicator(
                color: Colors.orange,
              ),
            ),
    );
  }

  Widget _buildRow(BuildContext context, int i) {
    final device = _deviceIdList!.elementAt(i);
    return Container(
      margin: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        gradient: kOrangeGradientDecoration,
      ),
      child: ListTile(
        onTap: () => {Navigator.pop(context, device.deviceID)},
        title: Row(
          children: [
            const Icon(
              Icons.local_print_shop,
              color: Colors.white,
            ),
            const SizedBox(
              width: 20,
              height: 70,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RichText(
                    text: TextSpan(
                        text: 'Device ID : ',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                        children: [TextSpan(text: '${device.deviceID}')])),
                RichText(
                    text: TextSpan(
                        text: 'USB ID : ',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                        children: [TextSpan(text: device.vidPid)])),
                RichText(
                    text: TextSpan(
                        text: device.deviceType,
                        style: const TextStyle(fontWeight: FontWeight.bold))),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void refreshDeviceIdList() async {
    _isRrefreshing = true;
    setState(() {
      _deviceIdList = null;
    });
    List<MPosDeviceID> deviceIdList = [];
    await _configController
        .connect(_printerInfo, deviceId: 0, timeout: 3)
        .then((result) async {
      if (result) {
        //String? test = await _configController.getBgateSerialNumber();
        //List<String>? test3 = await _configController.getCustomDevices(40);
        //List<int>? test4 = await _configController.getSerialConfig(107);
        String? jsonString = await _configController.searchDevices() ?? '[]';
        Iterable l = json.decode(jsonString);
        for (final element in l) {
          int deviceID = element['device_id'];
          String vidPid = await _configController.getUSBDevice(deviceID) ?? '';
          element['vid_pid'] = vidPid;
        }
        List<MPosDeviceID> idList = List<MPosDeviceID>.from(
            l.map((device) => MPosDeviceID.fromJON(device)));
        deviceIdList.addAll(idList);
      }
    });
    setState(() {
      _deviceIdList = deviceIdList;
    });
    print('isEmpty: ${_deviceIdList!.isEmpty}');
    _configController.disconnect(timeout: 3);
    _isRrefreshing = false;
  }
}
