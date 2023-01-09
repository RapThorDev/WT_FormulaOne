import 'package:f1_application/util/build_blur.dart';
import 'package:flutter/material.dart';

class Summary extends StatelessWidget {
  final Widget childWidget;

  const Summary(this.childWidget, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;

    return Column(
      children: [
        const SizedBox(
          height: 40,
        ),
        Container(
          width: screenSize.width * 0.9,
          height: 2,
          color: const Color(0xff000000),
        ),
        const SizedBox(
          height: 20,
        ),
        buildBlur(
          child: Container(
            padding: const EdgeInsets.all(5),
            decoration: const BoxDecoration(
                color: Color(0x88000000)
            ),
            child: Column(
              children: [
                const Text(
                  "Summary",
                  style: TextStyle(
                      fontFamily: "OleoScript",
                      fontSize: 92,
                      color: Color(0xffffffff),
                      shadows: [
                        Shadow(color: Color(0xff000000),
                            offset: Offset(2, 2),
                            blurRadius: 5),
                        Shadow(color: Color(0x88000000),
                            offset: Offset(1, 1),
                            blurRadius: 7),
                        Shadow(color: Color(0x22000000),
                            offset: Offset(0, 0),
                            blurRadius: 10),
                      ]
                  ),
                ),
                childWidget
              ],
            ),
          ),
        ),
      ],
    );
  }
}
