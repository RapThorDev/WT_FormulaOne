import 'package:f1_application/tools/DrawTriangle.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;


class BackgroundTop extends StatefulWidget {
  const BackgroundTop({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<BackgroundTop> createState() => _BackgroundTopState();
}

class _BackgroundTopState extends State<BackgroundTop> {
  @override
  Widget build(BuildContext context) {
    double titleFontSize = MediaQuery.of(context).size.width * 0.25;
    double titleTop = titleFontSize / 2.5 ;

    return Stack(
      children: [
        Positioned(
          top: 0,
          left: 0,
          child: Container(
              decoration: const BoxDecoration(
                  boxShadow: [
                    BoxShadow(color: Color(0xff000000), offset: Offset(2, 2), blurRadius: 5)
                  ]
              ),
              child: CustomPaint(
                  painter: DrawUpperTriangle(context)
              )
          ),
        ),
        Positioned(
          top: titleTop,
          left: 0,
          child: Transform.rotate(
            angle: -math.pi * 0.1,
            child: Text(
              widget.title,
              style: TextStyle(
                fontSize: titleFontSize,
                fontFamily: "OleoScript",
                fontStyle: FontStyle.italic,
                color: const Color(0xffffffff),
                shadows: const [
                  Shadow(color: Color(0xaa000000), offset: Offset(2, 2), blurRadius: 2),
                  Shadow(color: Color(0x88000000), offset: Offset(4, 4), blurRadius: 3),
                  Shadow(color: Color(0x44000000), offset: Offset(4, 4), blurRadius: 5),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
