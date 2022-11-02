import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame/effects.dart';
import 'package:flutter/material.dart';

void main() {
  final game = FlameWave();
  runApp(
    MyApp(game: game),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.game});

  final FlameGame game;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      // debugShowMaterialGrid: true,
      title: 'India Flag',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: GameWidget(game: game),
    );
  }
}

double edgeLength = 380.0;
double edgeWidth = 0.1;
double scaleFactor = 1 / 7;

class FlameWave extends FlameGame {
  @override
  Future<void> onLoad() async {
    add(RectangleComponent(
      size: size,
      position: Vector2.all(0),
      paint: Paint()..color = Colors.black,
    ));
    final xCount = (size.x / edgeWidth).ceil();
    for (var x = 0; x < xCount; x++) {
      add(WaveComponent(
        position: Vector2(x * edgeWidth / 2, edgeLength / 4),
        paint: Paint()..color = Colors.green,
        size: Vector2(edgeWidth, edgeLength),
        index: (x * scaleFactor).ceil(),
      ));
    }
    for (var x = 0; x < xCount; x++) {
      add(WaveComponent(
        position: Vector2(x * edgeWidth / 2, 0),
        paint: Paint()..color = Colors.black,
        size: Vector2(edgeWidth, edgeLength),
        index: (x * scaleFactor).ceil(),
      ));
    }
    for (var x = 0; x < xCount; x++) {
      add(WaveComponent(
        position: Vector2(x * edgeWidth / 2, 0),
        paint: Paint()..color = Colors.white,
        size: Vector2(edgeWidth, edgeLength),
        index: (x * scaleFactor).ceil(),
      ));
    }
    add(AshokChakra(
      size: edgeLength * 0.4,
      position: Vector2(size.x / 2 - edgeLength * 0.4 / 2, edgeLength * 0.55),
    ));
    for (var x = 0; x < xCount; x++) {
      add(WaveComponent(
        position: Vector2(x * edgeWidth / 2, -edgeLength / 4),
        paint: Paint()..color = Colors.black,
        size: Vector2(edgeWidth, edgeLength),
        index: (x * scaleFactor).ceil(),
      ));
    }
    for (var x = 0; x < xCount; x++) {
      add(WaveComponent(
        position: Vector2(x * edgeWidth / 2, -edgeLength / 4),
        paint: Paint()..color = Colors.orange,
        size: Vector2(edgeWidth, edgeLength),
        index: (x * scaleFactor).ceil(),
      ));
    }
    for (var x = 0; x < xCount; x++) {
      add(WaveComponent(
        position: Vector2(x * edgeWidth / 2, -edgeLength / 2),
        paint: Paint()..color = Colors.black,
        size: Vector2(edgeWidth, edgeLength),
        index: (x * scaleFactor).ceil(),
      ));
    }
    for (var x = 0; x < xCount; x++) {
      add(WaveComponent(
        position: Vector2(x * edgeWidth / 2, -edgeLength / 2),
        paint: Paint()..color = Colors.black,
        size: Vector2(edgeWidth, edgeLength),
        index: (x * scaleFactor).ceil(),
      ));
    }
  }
}

class WaveComponent extends PositionComponent {
  final int index;
  WaveComponent(
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
      EffectController(
          duration: 1,
          infinite: true,
          alternate: true,
          curve: Curves.easeInOut),
      onComplete: _addScaleEffect,
    ));
  }

  _addScaleEffect({double delay = 0}) {
    add(ScaleEffect.to(
      Vector2(1, 1.1),
      EffectController(
          duration: 1,
          infinite: true,
          alternate: true,
          curve: Curves.easeInOut,
          startDelay: delay),
      onComplete: _reduceScaleEffect,
    ));
  }

  @override
  Future<void> onLoad() async => _addScaleEffect(delay: index / 1000);
}

class AshokChakra extends SpriteComponent {
  /// create a single wall component
  ///
  /// size is a required parameter
  /// position is default to (0, 0)
  AshokChakra({Vector2? position, required double size})
      : super(size: Vector2.all(size), position: position ?? Vector2.zero());

  @override
  Future<void>? onLoad() async {
    sprite = await Sprite.load('chakra.png');
    _addMoveEffect(delay: 0.5);
  }

  _reverseMoveEffect() {
    add(MoveEffect.by(
      Vector2(0, -size.x / 4),
      EffectController(
          duration: 1,
          infinite: true,
          alternate: true,
          curve: Curves.easeInOut),
      onComplete: _addMoveEffect,
    ));
  }

  _addMoveEffect({double delay = 0}) {
    add(MoveEffect.by(
      Vector2(0, size.x / 4),
      EffectController(
          duration: 1,
          infinite: true,
          alternate: true,
          curve: Curves.easeInOut,
          startDelay: delay),
      onComplete: _reverseMoveEffect,
    ));
  }
}
