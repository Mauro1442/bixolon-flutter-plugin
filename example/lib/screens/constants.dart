import 'package:flutter/material.dart';


var kOrangeGradientDecoration = const LinearGradient(
  colors: [Colors.orange, Colors.deepOrange],
  begin: Alignment.bottomRight,
  end: Alignment.topLeft,
);

var kAppbarGradient = Container(
  decoration: BoxDecoration(
    gradient: kOrangeGradientDecoration,
  ),
);
