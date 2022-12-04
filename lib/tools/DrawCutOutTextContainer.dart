import 'package:flutter/material.dart';

class DrawCutOutTextContainer extends CustomPainter {

  DrawCutOutTextContainer({required this.text}) {
    _textPainter = TextPainter(
      text: TextSpan(
        text: text,
        style: const TextStyle(
          fontSize: 72,
        ),
      ),
      textDirection: TextDirection.ltr,
    );
    _textPainter.layout();
  }

  final String text;
  late final TextPainter _textPainter;


  @override
  void paint(Canvas canvas, Size size) {
    final textOffset = size.center(Offset.zero) - _textPainter.size.center(Offset.zero);
    final textRect = textOffset & _textPainter.size;

    final boxRect = RRect.fromRectAndRadius(textRect.inflate(10), const Radius.circular(4));
    final boxPaint = Paint()
      ..color = const Color(0xffffffff)
      ..blendMode = BlendMode.srcOut;

    canvas.saveLayer(boxRect.outerRect, Paint());

    _textPainter.paint(canvas, textOffset);
    canvas.drawRRect(boxRect, boxPaint);

    canvas.restore();
  }

  @override
  bool shouldRepaint(DrawCutOutTextContainer oldDelegate) {
    return text != oldDelegate.text;
  }
}