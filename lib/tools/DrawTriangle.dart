import 'package:flutter/material.dart';

class DrawUpperTriangle extends CustomPainter {

  final BuildContext context;

  DrawUpperTriangle(this.context);

  @override
  void paint(Canvas canvas, Size size) {
    double screenWidth = MediaQuery.of(context).size.width;
    var path = Path();
    path.moveTo(0, 0);
    path.lineTo(screenWidth, 0);
    path.lineTo(screenWidth, screenWidth / 6);
    path.lineTo(0, screenWidth / 2);
    path.close();
    canvas.drawPath(path, Paint()..color = const Color(0xffb10000));
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}

class DrawLowerTriangle extends CustomPainter {

  final BuildContext context;

  DrawLowerTriangle(this.context);

  @override
  void paint(Canvas canvas, Size size) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    var path = Path();
    path.moveTo(0, 0);
    path.lineTo(screenWidth, screenHeight / 2);
    path.lineTo(screenWidth, screenHeight);
    path.lineTo(0, screenHeight);
    path.close();
    canvas.drawPath(path, Paint()..color = const Color(0xffb10000));
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}