import 'package:flutter/material.dart';
import 'package:praca_inz/config/theme/color_palette.dart';

class BackgroundMesh extends StatelessWidget {
  final Color _shader;
  final Color _foreground;
  const BackgroundMesh({
    Key? key,
    required Color shader,
    required Color foreground,
  })  : _shader = shader,
        _foreground = foreground,
        super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
        body: _body(),
      );

  Widget _body() => CustomPaint(
        size: Size.infinite,
        painter: ShaderPainter(_shader),
        foregroundPainter: ForegroundPainter(_foreground),
      );
}

class ShaderPainter extends CustomPainter {
  final Color color;

  ShaderPainter(this.color);

  @override
  void paint(Canvas canvas, Size size) =>
      canvas.drawPaint(Paint()..color = color);

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class ForegroundPainter extends CustomPainter {
  final Color color;

  ForegroundPainter(this.color);

  @override
  void paint(Canvas canvas, Size size) {
    _paintTopLeftCorner(canvas, size);
    _paintCenterRight(canvas, size);
    _paintBottomLeftCorner(canvas, size);
  }

  void _paintTopLeftCorner(Canvas canvas, Size size) {
    final double x = size.width;
    final double y = size.height;
    Paint paint = Paint()..color = color;
    Path path = Path()
      ..moveTo(0, 0)
      ..lineTo(x * 0.46, 0)
      ..cubicTo(x * 0.36, y * 0.02, x * 0.31, y * 0.07, x * 0.31, y * 0.09)
      ..lineTo(x * 0.31, x * 0.17)
      ..cubicTo(x * 0.31, y * 0.24, x * 0.13, y * 0.26, 0, y * 0.27)
      ..lineTo(0, 0);

    canvas.drawShadow(path, ColorPalette.colorBasic1000, 5.0, true);
    canvas.drawPath(path, paint);
  }

  void _paintCenterRight(Canvas canvas, Size size) {
    final double x = size.width;
    final double y = size.height;
    Paint paint = Paint()..color = color;
    Path path = Path()
      ..moveTo(x, y * 0.51)
      ..lineTo(x, y * 0.30)
      ..cubicTo(x * 0.83, y * 0.24, x * 0.61, y * 0.31, x * 0.63, y * 0.41)
      ..cubicTo(x * 0.63, y * 0.44, x * 0.75, y * 0.56, x, y * 0.53);

    canvas.drawShadow(path, ColorPalette.colorBasic1000, 8.0, true);
    canvas.drawPath(path, paint);
  }

  void _paintBottomLeftCorner(Canvas canvas, Size size) {
    final double x = size.width;
    final double y = size.height;
    Paint paint = Paint()..color = color;
    Path path = Path()
      ..moveTo(0, y)
      ..lineTo(x * 0.6, y)
      ..cubicTo(x * 0.83, y * 0.95, x * 0.35, y * 0.51, 0, y * 0.51);

    canvas.drawShadow(path, ColorPalette.colorBasic1000, 10.0, true);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
