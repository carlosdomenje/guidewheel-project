import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MiniGaugeWidget extends StatefulWidget {
  MiniGaugeWidget(
      {required this.backgroundThick,
      required this.valueThick,
      required this.value,
      required this.minValue,
      required this.maxValue,
      required this.secondaryText,
      required this.mainValueIndicator});

  final double value;
  final int minValue;
  final int maxValue;
  final double backgroundThick;
  final double valueThick;
  final Widget mainValueIndicator;
  final Text secondaryText;

  @override
  _MiniGaugeWidgetState createState() => _MiniGaugeWidgetState();
}

class _MiniGaugeWidgetState extends State<MiniGaugeWidget>
    with SingleTickerProviderStateMixin {
  double newvalue = 0.0;
  late AnimationController controller;

  @override
  void initState() {
    controller = new AnimationController(
        vsync: this, duration: Duration(milliseconds: 400));
    newvalue = widget.value;

    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    controller.forward(from: 0.0);

    final diffAnimation = widget.value - newvalue;
    newvalue = widget.value;

    return AnimatedBuilder(
      animation: controller,
      builder: (BuildContext context, Widget? child) {
        double valueControl =
            (widget.value - diffAnimation) + (diffAnimation * controller.value);

        return Container(
          //padding: EdgeInsets.symmetric(horizontal: 30),
          height: double.infinity,
          width: double.infinity,
          color: Colors.transparent,
          child: Stack(
            fit: StackFit.expand,
            clipBehavior: Clip.none,
            children: [
              Positioned(
                  top: 25,
                  child: Container(
                      width: 60,
                      child: Center(child: widget.mainValueIndicator))),
              CustomPaint(
                painter: _MyRadialPainter(valueControl, widget.maxValue,
                    widget.minValue, widget.valueThick, widget.backgroundThick),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _MyRadialPainter extends CustomPainter {
  final double value;
  final int maxValue;
  final int minValue;
  final double valueThick;
  final double backThick;

  _MyRadialPainter(this.value, this.maxValue, this.minValue, this.valueThick,
      this.backThick);

  final Rect rect = new Rect.fromCircle(center: Offset(90, 90), radius: 130);

  final Gradient gradiente = new LinearGradient(colors: [
    Color(0xFF4575b4),
    Color(0xFF74add1),
    Color(0xFFfdae61),
    Color(0xFFfdae30),
    Color(0xFFf46d43),
    Color(0xFFd73027),
    Color(0xFFa50026),
  ]);

  @override
  void paint(Canvas canvas, Size size) {
    // Arc Background Paint
    final paint = new Paint()
      ..strokeWidth = backThick
      ..color = Colors.grey.withOpacity(0.20)
      ..style = PaintingStyle.stroke;

    final center = new Offset(size.width * 0.5, size.height * 0.5);
    final radius = min(size.width * 0.5, size.height * 0.5);

    // Arc Background
    canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius), -pi, pi, false, paint);

    // Arc Background Paint
    Paint paintArc = new Paint()
      ..strokeWidth = valueThick
      //..color = Colors.blue
      ..shader = gradiente.createShader(rect)
      ..style = PaintingStyle.stroke;

    double arcAngle = 0;
    double negArcAnge = 0;

    if (value > maxValue) {
      paintArc = new Paint()
        ..strokeWidth = valueThick
        ..color = Color(0xFFa50026)
        //..shader = gradiente.createShader(rect)
        ..style = PaintingStyle.stroke;
      arcAngle = pi;
      negArcAnge = -pi;
    } else if (value < minValue) {
      paintArc = new Paint()
        ..strokeWidth = valueThick
        ..color = Color(0xFF4575b4)
        //..shader = gradiente.createShader(rect)
        ..style = PaintingStyle.stroke;
      negArcAnge = -pi;
      arcAngle = pi;
    } else {
      arcAngle = (pi / (maxValue - minValue)) * (value - minValue);

      paintArc = new Paint()
        ..strokeWidth = valueThick
        //..color = Colors.blue
        ..shader = gradiente.createShader(rect)
        ..style = PaintingStyle.stroke;
    }

    canvas.drawArc(Rect.fromCircle(center: center, radius: radius), -pi,
        arcAngle, false, paintArc);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
