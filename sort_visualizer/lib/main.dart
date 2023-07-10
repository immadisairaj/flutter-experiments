import 'package:flutter/material.dart';
import 'package:sort_visualizer/element.dart';
import 'package:sort_visualizer/sorting.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.pink),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Selection Sort Visualizer'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late List<ArrayElement> currentArray;
  late Sorting sorting;

  final arrayLength = 100;
  final delayedDuration = const Duration(milliseconds: 1);

  @override
  void initState() {
    super.initState();
    sorting = Sorting(setState: _setStateCallback);
    currentArray = [];
    // add all to array
    for (int i = 1; i <= arrayLength; i++) {
      currentArray.add(ArrayElement(number: i));
    }

    _shuffle();
  }

  _setStateCallback() {
    setState(() {});
  }

  _shuffle() {
    // shuffle the array
    currentArray.shuffle();
    for (int i = 0; i < arrayLength; i++) {
      currentArray[i].toColor(Colors.white);
    }
    setState(() {});
  }

  _startSort() async {
    await sorting.selectionSort(currentArray, arrayLength, delayedDuration);

    for (int i = 0; i < arrayLength; i++) {
      await Future.delayed(delayedDuration);
      setState(() {
        currentArray[i].toColor(Colors.green);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
        actions: [
          IconButton(
            onPressed: _shuffle,
            tooltip: 'Shuffle',
            icon: const Icon(Icons.shuffle),
          ),
          IconButton(
            onPressed: _startSort,
            tooltip: 'Start',
            icon: const Icon(Icons.start_outlined),
          ),
        ],
      ),
      body: Scaffold(
        backgroundColor: Colors.black,
        body: SafeArea(
          child: LayoutBuilder(
            builder: (context, constraints) {
              final height = constraints.maxHeight;
              final width = constraints.maxWidth;

              return Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: currentArray.map((element) {
                  final calcHeight = height * element.number / arrayLength;
                  final calcWidth = width / arrayLength;
                  return SizedBox(
                    height: calcHeight,
                    width: calcWidth,
                    child: ColoredBox(color: element.color),
                  );
                }).toList(),
              );
            },
          ),
        ),
      ),
    );
  }
}
