import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame/effects.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(
    GameWidget(game: FlameWave()),
  );
}

double edgeLength = 400.0;
double edgeWidth = 0.1;

class FlameWave extends FlameGame {
  @override
  Future<void> onLoad() async {
    add(RectangleComponent(
      size: size,
      position: Vector2.all(0),
      paint: Paint()..color = Colors.blue,
    ));
    const color = Colors.cyan;
    final xCount = (size.x / edgeWidth).ceil();
    for (var x = 0; x < xCount; x++) {
      add(WaterComponent(
        position: Vector2(x * edgeWidth / 2, 0),
        paint: Paint()..color = color,
        size: Vector2(edgeWidth, edgeLength),
        index: x,
      ));
    }
  }
}

class WaterComponent extends PositionComponent {
  final int index;
  WaterComponent(
      {required Paint paint,
      required super.size,
      required super.position,
      required this.index})
      : super(children: [
          RectangleComponent(
            position: position,
            size: size,
            paint: paint,
          )
        ]);

  _reduceScaleEffect() {
    add(ScaleEffect.to(
      Vector2(1, 0.9),
      EffectController(duration: 1, infinite: true, alternate: true),
      onComplete: _addScaleEffect,
    ));
  }

  _addScaleEffect({double delay = 0}) {
    add(ScaleEffect.to(
      Vector2(1, 1.1),
      EffectController(
          duration: 1, infinite: true, alternate: true, startDelay: delay),
      onComplete: _reduceScaleEffect,
    ));
  }

  @override
  Future<void> onLoad() async {
    var delay = (index / 200).ceil() / ((index / 10000).ceil() + 0.5 * 10) +
        (index / 20000);
    _addScaleEffect(delay: delay);
  }
}
