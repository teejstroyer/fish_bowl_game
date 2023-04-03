import 'dart:math';
import 'package:fish_bowl_game/providers/countdown_timer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CountdownClock extends StatelessWidget {
  final Color color;
  final double diameter;

  const CountdownClock({
    super.key,
    required this.color,
    required this.diameter,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<CountdownTimer>(
      builder: (context, model, child) {
        return CustomPaint(
          painter: ArcPainter(
            (model.time) / model.maxTime,
            diameter,
            color,
            model.time.toString(),
            Theme.of(context).primaryTextTheme.bodySmall ?? const TextStyle(),
          ),
        );
      },
    );
  }
}

class ArcPainter extends CustomPainter {
  final double percent;
  final double diameter;
  final Color color;
  final String? text;
  final TextStyle textStyle;

  final _textPainter = TextPainter(textDirection: TextDirection.ltr);

  ArcPainter(
      this.percent, this.diameter, this.color, this.text, this.textStyle);

  @override
  void paint(Canvas canvas, Size size) {
    var center = size / 2;
    var paint = Paint()..color = color;

    canvas.drawArc(
      Rect.fromCenter(
        center: Offset(center.width, center.height),
        width: diameter,
        height: diameter,
      ),
      pi * 1.5,
      percent * 360 * (pi / 180),
      true,
      paint,
    );

    double angle = (percent * 360) * (pi / 180);
    for (int i = 0; i < (text?.length ?? 0); i++) {
      angle = _drawLetter(canvas, text![i], angle);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }

  double _drawLetter(Canvas canvas, String letter, double prevAngle) {
    _textPainter.text = TextSpan(
      text: letter,
      style: textStyle,
    );

    _textPainter.layout(
      minWidth: 0,
      maxWidth: diameter / 2,
    );

    final double d = _textPainter.width;
    final double alpha = 2 * asin(d / (diameter)) / 2;
    final newAngle = (alpha + prevAngle); // / 2;

    canvas.rotate(newAngle);

    _textPainter.paint(canvas, Offset(0, -diameter / 2));
    canvas.translate(d, 0);

    return alpha;
  }
}
