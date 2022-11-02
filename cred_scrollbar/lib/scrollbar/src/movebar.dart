import 'package:cred_scrollbar/scrollbar/src/roundbar.dart';
import 'package:flutter/material.dart';

class Movebar extends StatefulWidget {
  const Movebar({
    super.key,
    this.height,
    this.width,
    this.maxWidth,
    this.scrollPercent = 0.0,
    this.duration = const Duration(milliseconds: 200),
    this.curve = Curves.linear,
  }) : assert(scrollPercent >= 0.0 && scrollPercent <= 100.0);

  final double? height;
  final double? width;
  final double? maxWidth;
  final double scrollPercent;
  final Duration duration;
  final Curve curve;

  @override
  State<Movebar> createState() => _MovebarState();
}

class _MovebarState extends State<Movebar> {
  @override
  Widget build(BuildContext context) {
    final maxWidth = widget.maxWidth ?? widget.width;
    final calculatedLeft =
        ((maxWidth ?? 0) - (widget.width ?? 0)) * widget.scrollPercent / 100;
    return AnimatedPositioned(
      duration: widget.duration,
      curve: widget.curve,
      left: calculatedLeft,
      child: Roundbar(
        key: widget.key,
        height: widget.height,
        width: widget.width,
      ),
    );
  }
}
