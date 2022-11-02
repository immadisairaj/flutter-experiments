import 'package:flutter/material.dart';
import 'package:rive/rive.dart';
import 'package:sensors_plus/sensors_plus.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  double x = 0;
  double y = 0;

  SMIInput? xInput;
  SMIInput? yInput;

  _gyroListen() {
    gyroscopeEvents.listen((GyroscopeEvent event) {
      setState(() {
        x += event.x;
        y += event.y;
      });
      // print('x: ${x}, y: ${y}');
      setState(() {
        xInput?.value = x * 100;
        yInput?.value = y * 100;
      });
      print('x: ${xInput?.value}, y: ${yInput?.value}');
    });
  }

  @override
  void initState() {
    _gyroListen();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Container(
        color: Colors.white,
        child: RiveAnimation.asset(
          'assets/3d_test.riv',
          artboard: 'New Artboard',
          onInit: _onRiveInit,
        ),
      ),
    );
  }

  _onRiveInit(Artboard artboard) {
    final controller =
        StateMachineController.fromArtboard(artboard, 'State Machine 1');
    artboard.addController(controller!);

    xInput = controller.findInput<double>('x input') as SMINumber;
    xInput?.value = 0.0;
    yInput = controller.findInput<double>('y input') as SMINumber;
    yInput?.value = 0.0;
  }
}
