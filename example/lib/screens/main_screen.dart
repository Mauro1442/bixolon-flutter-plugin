import 'package:bxlflutterbgatelib_example/screens/constants.dart';
import 'package:bxlflutterbgatelib_example/screens/printer_label.dart';
import 'package:bxlflutterbgatelib_example/screens/printer_receipt.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);
  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: const [
          ReceiptPrinterPage(),
          LabelPrinterPage(),
        ],
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
            gradient: kOrangeGradientDecoration,
            boxShadow: const [BoxShadow(color: Colors.orange, blurRadius: 5)]),
        child: BottomNavigationBar(
          elevation: 0.0,
          backgroundColor: Colors.transparent,
          currentIndex: _currentIndex,
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.white60,
          type: BottomNavigationBarType.fixed,
          items: const [
            BottomNavigationBarItem(
                label: 'Receipt',
                icon: Icon(
                  Icons.local_print_shop,
                  color: Colors.white,
                )),
            BottomNavigationBarItem(
                label: 'Label',
                icon: Icon(Icons.local_print_shop, color: Colors.white)),
          ],
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
        ),
      ),
    );
  }
}
