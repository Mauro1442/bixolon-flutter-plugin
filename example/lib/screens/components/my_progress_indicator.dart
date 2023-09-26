import 'package:flutter/material.dart';

class MyProgressIndicator extends StatelessWidget {

  final String label;
  const MyProgressIndicator({Key? key, this.label = '...'}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: Align(
        alignment: Alignment.center,
        child: SizedBox(
          height: 120,
          width: MediaQuery.of(context).size.width - 100,
          child: Card(
            elevation: 30,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            child: Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                gradient: LinearGradient(
                  begin: Alignment.bottomRight,
                  end: Alignment.topLeft,
                  colors: [Colors.deepOrange, Colors.white],
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const CircularProgressIndicator(
                    color: Colors.white,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(label, style: const TextStyle(color: Colors.white))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
