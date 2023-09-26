import 'package:flutter/material.dart';

class MyGradientButton extends StatelessWidget {
  const MyGradientButton({Key? key, required this.label, this.func}) : super(key: key);

  final String label;
  final VoidCallback? func;

  @override
  Widget build(BuildContext context) {

    final kButtonStyle = TextButton.styleFrom(
        primary: Colors.white,
        onSurface: Colors.transparent,
        shadowColor: Colors.transparent);

    final btnColor = (func != null)
        ? [Colors.orange, Colors.deepOrange]
        : [Colors.grey, Colors.transparent];

    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          gradient: LinearGradient(
            colors: btnColor,
            begin: Alignment.bottomRight,
            end: Alignment.topLeft,
          ),
        ),
        child: TextButton(
            onPressed: func ?? () {}, child: Text(label), style: kButtonStyle),
      ),
    );
  }
}
