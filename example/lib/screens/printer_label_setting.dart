import 'package:flutter/material.dart';
import 'package:bxlflutterbgatelib_example/models/printer_label_info.dart';
import 'constants.dart';

class LabelPrinterSettingPage extends StatefulWidget {
  const LabelPrinterSettingPage({Key? key, required this.labelInfo})
      : super(key: key);
  final PrinterLabelInfo labelInfo;

  @override
  _LabelPrinterSettingPageState createState() =>
      _LabelPrinterSettingPageState();
}

class _LabelPrinterSettingPageState extends State<LabelPrinterSettingPage> {
  final _mediaTypes = ['GAP', 'BlackMark', 'Continuous'];
  final _orientations = ['Top to bottom', 'Bottom to top'];
  PrinterLabelInfo? _labelInfo;

  @override
  void initState() {
    super.initState();
    _labelInfo = widget.labelInfo;
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
              'Settings',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 23),
            ),
            flexibleSpace: kAppbarGradient,
          ),
        ),
        body: ListView(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildPrintDpiWidget(),
                  const Divider(),
                  _buildPrintOrientaionWidget(),
                  const Divider(),
                  _buildLabelSizeWidget(),
                  const Divider(),
                  _buildMediaTypeWidget(),
                  const Divider(),
                  _buildCutWidget(),
                  const Divider(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  _buildPrintDpiWidget() {
    return InkWell(
      onTap: (){
        setState(() {
          switch(_labelInfo!.dpi){
            case 203: _labelInfo!.dpi = 300; break;
            case 300: _labelInfo!.dpi = 600; break;
            case 600: _labelInfo!.dpi = 203; break;
          }
        });
      },
      child: ListTile(
        contentPadding: const EdgeInsets.all(0),
        leading: const Icon(Icons.change_circle_outlined),
        title: const Text(
          'DPI',
          style: TextStyle(
              fontSize: 17, color: Colors.black54, fontWeight: FontWeight.bold),
        ),
        trailing: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Text(_labelInfo!.dpi.toString(), style: const TextStyle(fontSize: 17),),
        ),
      ),
    );
  }
  _buildPrintOrientaionWidget() {
    return InkWell(
      onTap: (){
        setState(() {
          _labelInfo!.orientation = _labelInfo!.orientation == 0 ? 1 : 0;
        });
      },
      child: ListTile(
        contentPadding: const EdgeInsets.all(0),
        leading: const Icon(Icons.change_circle_outlined),
        title: const Text(
          'Orientation',
          style: TextStyle(
              fontSize: 17, color: Colors.black54, fontWeight: FontWeight.bold),
        ),
        trailing: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Text(_orientations[_labelInfo!.orientation], style: const TextStyle(fontSize: 17),),
        ),
      ),
    );
  }

  _buildCutWidget() {
    return InkWell(
      onTap: (){
        setState(() {
          _labelInfo!.cutEnable = _labelInfo!.cutEnable == 0 ? 1 : 0;
        });
      },
      child: ListTile(
        contentPadding: const EdgeInsets.all(0),
        leading: const Icon(Icons.cut),
        title: const Text(
          'Cut',
          style: TextStyle(
              fontSize: 17, color: Colors.black54, fontWeight: FontWeight.bold),
        ),
        trailing: Switch(
          activeColor: Colors.orange,
          value: (_labelInfo!.cutEnable > 0),
          onChanged: (value) {
            setState(() {
              _labelInfo!.cutEnable = value ? 1 : 0;
            });
          },
        ),
      ),
    );
  }

  _buildLabelSizeWidget() {
    return Column(
      children: [
        // width
        ListTile(
          contentPadding: const EdgeInsets.all(0),
          leading: const Icon(Icons.note_outlined),
          title: Text(
            'W: ${_labelInfo!.labelWidth.round().toString()} mm, H: ${_labelInfo!.labelHeight.round().toString()} mm',
            style: const TextStyle(
                fontSize: 17,
                color: Colors.black54,
                fontWeight: FontWeight.bold),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Expanded(
              child: Slider(
                activeColor: Colors.orange,
                inactiveColor: Colors.grey,
                value: _labelInfo!.labelWidth.toDouble(),
                min: 10,
                max: 300,
                onChanged: (value) {
                  setState(() {
                    _labelInfo!.labelWidth = value.toInt();
                  });
                },
                label: _labelInfo!.labelWidth.round().toString(),
              ),
            ),
            IconButton(onPressed: (){
              setState(() {
                if(_labelInfo!.labelWidth > 10){
                  _labelInfo!.labelWidth -= 1;
                }
              });
            }, icon: const Icon(Icons.remove_circle_outline, color: Colors.black54,)),
            IconButton(onPressed: (){
              setState(() {
                if(_labelInfo!.labelWidth < 300){
                  _labelInfo!.labelWidth += 1;
                }
              });
            }, icon: const Icon(Icons.add_circle_outline, color: Colors.black54,)),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Expanded(
              child: Slider(
                activeColor: Colors.orange,
                inactiveColor: Colors.grey,
                value: _labelInfo!.labelHeight.toDouble(),
                min: 10,
                max: 300,
                onChanged: (value) {
                  setState(() {
                    _labelInfo!.labelHeight = value.toInt();
                  });
                },
                label: _labelInfo!.labelHeight.round().toString(),
              ),
            ),
            IconButton(onPressed: (){
              setState(() {
                if(_labelInfo!.labelHeight > 10){
                  _labelInfo!.labelHeight -= 1;
                }
              });
            }, icon: const Icon(Icons.remove_circle_outline, color: Colors.black54,)),
            IconButton(onPressed: (){
              setState(() {
                if(_labelInfo!.labelHeight < 300){
                  _labelInfo!.labelHeight += 1;
                }
              });
            }, icon: const Icon(Icons.add_circle_outline, color: Colors.black54,)),
          ],
        ),

      ],
    );
  }

  _buildMediaTypeWidget() {
    return Column(
      children: [
        const ListTile(
          contentPadding: EdgeInsets.all(0),
          leading: Icon(Icons.list_alt_outlined),
          title: Text(
            'Media Type',
            style: TextStyle(
                fontSize: 17,
                color: Colors.black54,
                fontWeight: FontWeight.bold),
          ),
        ),
        Column(
          children: [
            for (int index = 0; index < _mediaTypes.length; index++)
              InkWell(
                onTap: (){
                  setState(() {
                    _labelInfo!.mediaType = index;
                  });
                },
                child: ListTile(
                  title: Text(
                    _mediaTypes[index],
                    style: const TextStyle(
                        color: Colors.black54, fontWeight: FontWeight.bold),
                  ),
                  leading: Radio(
                    value: index,
                    groupValue: _labelInfo!.mediaType,
                    activeColor: Colors.orange,
                    onChanged: (value) {
                      setState(() {
                        _labelInfo!.mediaType = value as int;
                      });
                    },
                  ),
                ),
              )
          ],
        ),
      ],
    );
  }
}
