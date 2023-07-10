import 'package:flutter/material.dart';

class ArrayElement {
  ArrayElement({required this.number, Color color = Colors.white})
      : _color = color;

  final int number;
  Color _color;

  get color => _color;

  toColor(Color color) => _color = color;

  ArrayElement copyWith({int? number, Color? color}) =>
      ArrayElement(number: number ?? this.number, color: color ?? _color);
}
