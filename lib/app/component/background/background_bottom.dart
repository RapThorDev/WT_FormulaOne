import 'package:f1_application/util/draw_triangle.dart';
import 'package:flutter/material.dart';


class BackgroundBottom extends StatelessWidget {
  const BackgroundBottom({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Stack(
      children: [
        Positioned(
          bottom: 0,
          left: 0,
          child: SizedBox(
            height: size.height * 0.5,
            width: size.width,
            child: CustomPaint(painter: DrawLowerTriangle(context)),
          ),
        ),
      ],
    );
  }
}
