import 'package:flutter/material.dart';


class Cutout extends StatelessWidget {
  const Cutout({
    Key? key,
    required this.color,
    required this.child
  }) : super(key: key);

  final Color color;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      blendMode: BlendMode.srcOut,
      shaderCallback: (bounds) => LinearGradient(colors: [color], stops: const [0.0]).createShader(bounds),
      child: Stack(
          children: [
            Positioned(
                bottom: 0,
                right: 0,
                child: Container(
                  width: 200,
                  height: 100,
                  color: const Color(0xff565656),
                )
            ),
            Positioned(
                bottom: 0,
                right: 0,
                child: child
            )
          ]
      ),
    );
  }
}
