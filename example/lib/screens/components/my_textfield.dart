import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  final TextEditingController controller;
  const MyTextField({Key? key, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
          side: const BorderSide(color: Colors.orange, width: 2),
          borderRadius: BorderRadius.circular(3)),
      child: SizedBox(
        height: 75,
        child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: TextField(
                maxLines: null,
                controller: controller,
                decoration: const InputDecoration(border: InputBorder.none),
              ),
            )),
      ),
    );
  }
}
