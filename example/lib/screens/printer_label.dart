import 'package:flutter/material.dart';
import 'package:bxlflutterbgatelib_example/screens/components/my_textfield.dart';
import 'package:bxlflutterbgatelib_example/screens/printer_label_setting.dart';
import 'package:bxlflutterbgatelib_example/models/printer_connection_info.dart';
import 'package:bxlflutterbgatelib_example/models/printer_label_info.dart';
import 'components/my_progress_indicator.dart';
import 'components/my_gradient_button.dart';
import 'components/my_textfield.dart';
import 'devicecontrol/device_slcs.dart';
import 'printer_discovery.dart';
import 'printer_id_list.dart';
import 'constants.dart';

class LabelPrinterPage extends StatefulWidget {
  const LabelPrinterPage({Key? key}) : super(key: key);

  @override
  _LabelPrinterPageState createState() => _LabelPrinterPageState();
}

class _LabelPrinterPageState extends State<LabelPrinterPage>
    with ChangeNotifier {
  bool _isOpen = false;
  bool _showWaiting = false;
  int? _deviceId = -1;
  MPosDevice? _deviceInfo;
  final PrinterLabelInfo _printerLabelInfo = PrinterLabelInfo();
  late final LabelPrinterController _printerController =
      LabelPrinterController(labelInfo: _printerLabelInfo);
  late final TextEditingController _tfController = TextEditingController();

  @override
  void dispose() async {
    _printerController.disconnect();
    _tfController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(50),
          child: AppBar(
            title: const Text(
              'Label Printing',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 23),
            ),
            flexibleSpace: kAppbarGradient,
            actions: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: IconButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => LabelPrinterSettingPage(
                                    labelInfo: _printerLabelInfo,
                                  )));
                    },
                    icon: const Icon(Icons.settings)),
              ),
            ],
          ),
        ),
        body: Stack(
          children: _showWaiting
              ? [
                  _testButtonWidgets(context),
                  const MyProgressIndicator(label: 'Waiting...')
                ]
              : [_testButtonWidgets(context)],
        ),
      ),
    );
  }

  Widget _testButtonWidgets(BuildContext context) {
    return Positioned.fill(
        child: SingleChildScrollView(
      child: Align(
        alignment: Alignment.center,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(10),
              child: MyTextField(
                controller: _tfController,
              ),
            ),
            const Divider(),
            Padding(
              padding: const EdgeInsets.all(5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(width: 10),
                  MyGradientButton(
                      label: 'Discovery',
                      func: () {
                        _callDeviceMethod(context, 'discoveryDevice');
                      }),
                  const SizedBox(width: 10),
                  MyGradientButton(
                      label: 'Device ID List',
                      func: (_deviceInfo?.address == null)
                          ? null
                          : () => _callDeviceMethod(context, 'getDeviceIdList')),
                  const SizedBox(width: 10),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(width: 10),
                  MyGradientButton(
                      label: 'Open',
                      func: (_deviceInfo?.address == null || _isOpen)
                          ? null
                          : () => _callDeviceMethod(context, 'openDevice')),
                  const SizedBox(width: 10),
                  MyGradientButton(
                      label: 'Close',
                      func: _isOpen
                          ? () => _callDeviceMethod(context, 'closeDevice')
                          : null),
                  const SizedBox(
                    width: 10,
                  ),
                ],
              ),
            ),
            const Divider(),
            Padding(
              padding: const EdgeInsets.all(5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(width: 10),
                  MyGradientButton(
                      label: 'Check Printer Status',
                      func: _isOpen
                          ? () =>
                              _callDeviceMethod(context, 'checkPrinterStatus')
                          : null),
                  const SizedBox(width: 10),
                ],
              ),
            ),
            const Divider(),
            Padding(
              padding: const EdgeInsets.all(5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(width: 10),
                  MyGradientButton(
                      label: 'Print Label',
                      func: _isOpen
                          ? () => _callDeviceMethod(context, 'printLabel')
                          : null),
                  const SizedBox(width: 10),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(width: 10),
                  MyGradientButton(
                      label: 'Print Label (PDF File)',
                      func: _isOpen
                          ? () => _callDeviceMethod(context, 'printPDFFile')
                          : null),
                  const SizedBox(width: 10),
                ],
              ),
            ),
            const Divider(),
            Padding(
              padding: const EdgeInsets.all(5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(width: 10),
                  MyGradientButton(
                      label: 'Model Name',
                      func: _isOpen
                          ? () => _callDeviceMethod(context, 'getModelName')
                          : null),
                  const SizedBox(width: 10),
                  MyGradientButton(
                      label: 'Firmware Version',
                      func: _isOpen
                          ? () =>
                              _callDeviceMethod(context, 'getFirmwareVersion')
                          : null),
                  const SizedBox(
                    width: 10,
                  ),
                ],
              ),
            ),
            const Divider(),
          ],
        ),
      ),
    ));
  }

  void _callDeviceMethod(BuildContext context, String methodName) async {
    if (_showWaiting) {
      return;
    }

    _showProgressWidget(true);

    switch (methodName) {
      case 'discoveryDevice':
        _discoveryDevice(context);
        break;
      case 'getDeviceIdList':
        _getDeviceIdList(context);
        break;
      case 'openDevice':
        _openDevice(context);
        break;
      case 'closeDevice':
        _closeDevice(context);
        break;
      case 'checkPrinterStatus':
        _checkPrinterStatus(context);
        break;
      case 'printLabel':
        _printLabel(context);
        break;
      case 'printPDFFile':
        _printPDFFile(context);
        break;
      case 'getModelName':
        _getModelName(context);
        break;
      case 'getFirmwareVersion':
        _getFirmwareVersion(context);
        break;
      case 'rfidCalibration':
        _rfidCalibration(context);
        break;
      case 'rfidTagWriting':
        _rfidTagWriting(context);
        break;
    }

    _showProgressWidget(false);
  }

  void _openDevice(BuildContext context) async {
    final result = await _printerController.connect(_deviceInfo,
        deviceId: _deviceId ?? -1, timeout: 3);
    if (result == 0) {
      _printerController.listenOutputCompletedEventStream(() {
        _tfController.text = 'OutputCompletedEvent received\r\n';
      });
      setState(() {
        _isOpen = true;
        _tfController.text = 'Connected with the printer\r\n';
      });
    } else {
      setState(() {
        _tfController.text =
            'Failed in connecting with the printer, ERR CODE: $result\r\n';
      });
    }
  }

  void _closeDevice(BuildContext context) async {
    await _printerController.disconnect(timeout: 3).then((value) {
      setState(() {
        _isOpen = false;
        _tfController.text = 'Disconnected with the printer\r\n';
      });
    });
  }

  void _checkPrinterStatus(BuildContext context) async {
    var status = await _printerController.checkPrinterStatus();
    _updatePrinterStatusMessage(status);
  }

  void _printLabel(BuildContext context) async {
    await _printerController.printLabel();
  }

  void _printPDFFile(BuildContext context) async {
    int result = await _printerController.printPDFFile();
    if (result != 0) {
      setState(() {
        _tfController.text =
            'Failed in printing PDF file, ERR CODE: $result\r\n';
      });
    }
  }

  void _rfidCalibration(BuildContext context) async {
    await _printerController.rfidCalibration();
  }

  void _rfidTagWriting(BuildContext context) async {
    await _printerController.rfidTagWriting();
  }

  void _getFirmwareVersion(BuildContext context) async {
    final resultString = await _printerController.getFirmwareVersion();
    setState(() {
      _tfController.text = '$resultString\r\n';
    });
  }

  void _getModelName(BuildContext context) async {
    final resultString = await _printerController.getModelName();
    setState(() {
      _tfController.text = '$resultString\r\n';
    });
  }

  void _discoveryDevice(BuildContext context) async {
    _closeDevice(context);
    final device = await Navigator.push(context,
        MaterialPageRoute(builder: (context) => const PrinterDiscoveryPage()));
    setState(() {
      _deviceInfo = device;
    });
    _tfController.text =
        '${_deviceInfo?.deviceName}, ${_deviceInfo?.address}, ${_deviceInfo?.interfaceType}\r\n';
  }

  void _getDeviceIdList(BuildContext context) async {
    final deviceId = await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => PrinterIdListPage(
                  printerInfo: _deviceInfo,
                )));
    setState(() {
      _deviceId = deviceId;
    });
    _tfController.text =
        '${_deviceInfo?.deviceName}, ${_deviceInfo?.address}, ${_deviceInfo?.interfaceType}\r\n';
  }

  void _showProgressWidget(bool printing) {
    setState(() {
      if (printing) {
        _showWaiting = printing;
        return;
      }
      Future.delayed(const Duration(milliseconds: 500), () {
        setState(() {
          _showWaiting = printing;
        });
      });
    });
  }

  void _updatePrinterStatusMessage(int status) {
    setState(() {
      if (status == 0) {
        _tfController.text = 'NORMAL ($status)\r\n';
      } else if (status < 0) {
        _tfController.text =
            'Failed in checking the printer status ($status)\r\n';
      } else {
        if (status & 1 != 0) {
          _tfController.text = 'PAPER EMPTY ($status)\r\n';
        }
        if (status & 2 != 0) {
          _tfController.text = 'COVER OPEN ($status)\r\n';
        }
        if (status & 4 != 0) {
          _tfController.text = 'CUTTER JAM ($status)\r\n';
        }
        if (status & 8 != 0) {
          _tfController.text = 'TPH OVER-HEAT ($status)\r\n';
        }
        if (status & 16 != 0) {
          _tfController.text = 'GAP ERROR ($status)\r\n';
        }
        if (status & 32 != 0) {
          _tfController.text = 'RIBBON END ($status)\r\n';
        }
        if (status & 64 != 0) {
          _tfController.text = 'BUILDING LABEL ($status)\r\n';
        }
        if (status & 128 != 0) {
          _tfController.text = 'PRINTING LABEL ($status)\r\n';
        }
        if (status & 256 != 0) {
          _tfController.text = 'LABEL PAUSED ($status)\r\n';
        }
        if (status & 512 != 0) {
          _tfController.text = 'BOARD OVER-HEAT ($status)\r\n';
        }
        if (status & 1024 != 0) {
          _tfController.text = 'MOTOR OVER-HEAT ($status)\r\n';
        }
        if (status & 2048 != 0) {
          _tfController.text = 'WAITING FOR LABEL TAKEN ($status)\r\n';
        }
        if (status & 4096 != 0) {
          _tfController.text = 'RFID WRITING ERROR ($status)\r\n';
        }
      }
    });
  }
}
