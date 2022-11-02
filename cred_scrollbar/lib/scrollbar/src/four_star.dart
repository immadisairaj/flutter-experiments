import 'package:flutter/material.dart';

class FourStar extends StatelessWidget {
  const FourStar({super.key, this.height, this.width});

  final double? height;
  final double? width;

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      key: key,
      size: Size(width ?? 10, height ?? 10),
      painter: _FourStarPainter(),
    );
  }
}

class _FourStarPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color.fromARGB(255, 168, 44, 190)
      ..strokeWidth = 2
      ..style = PaintingStyle.fill;

    final path = Path()
      ..moveTo(size.width / 2, 0)
      ..quadraticBezierTo(
          size.width / 2, size.height / 2, size.width, size.height / 2)
      ..quadraticBezierTo(
          size.width / 2, size.height / 2, size.width / 2, size.height)
      ..quadraticBezierTo(size.width / 2, size.height / 2, 0, size.height / 2)
      ..quadraticBezierTo(size.width / 2, size.height / 2, size.width / 2, 0);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
