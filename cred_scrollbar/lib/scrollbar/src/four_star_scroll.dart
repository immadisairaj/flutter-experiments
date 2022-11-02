import 'package:cred_scrollbar/scrollbar/src/four_star.dart';
import 'package:flutter/material.dart';

class FourStarScroll extends StatefulWidget {
  const FourStarScroll({
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
  State<FourStarScroll> createState() => _FourStarScrollState();
}

class _FourStarScrollState extends State<FourStarScroll> {
  @override
  Widget build(BuildContext context) {
    final maxWidth = widget.maxWidth ?? widget.width;
    final calculatedLeft =
        ((maxWidth ?? 0) - (widget.width ?? 0)) * widget.scrollPercent / 100;
    final leftPadding = ((widget.width ?? 0) / 2 - (widget.height ?? 0) / 2);
    return AnimatedPositioned(
      duration: widget.duration,
      curve: widget.curve,
      left: calculatedLeft + leftPadding,
      child: AnimatedRotation(
        curve: widget.curve,
        duration: widget.duration,
        turns: widget.scrollPercent / 100,
        child: FourStar(
          key: widget.key,
          height: widget.height,
          width: widget.height,
        ),
      ),
    );
  }
}
