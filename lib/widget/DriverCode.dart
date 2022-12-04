import 'package:flutter/material.dart';

class DriverCode extends StatelessWidget {
  const DriverCode({Key? key, required this.driverCode}) : super(key: key);

  final String driverCode;


  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
      decoration: const BoxDecoration(
        color: Color(0xcc000000),
        borderRadius: BorderRadius.all(Radius.circular(5)),
      ),
      child: Text(
        driverCode,
        textAlign: TextAlign.center,
        style: const TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontFamily: "Titillium",
            fontWeight: FontWeight.bold
        ),
      ),
    );
  }
}
