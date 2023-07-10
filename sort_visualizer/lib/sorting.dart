import 'package:flutter/material.dart';
import 'package:sort_visualizer/element.dart';

class Sorting {
  Sorting({required this.setState});

  final Function setState;

  bubbleSort(List<ArrayElement> currentArray, int arrayLength,
      Duration delayedDuration) async {
    final array = currentArray;
    int lengthOfArray = arrayLength;
    for (int i = 0; i < lengthOfArray - 1; i++) {
      for (int j = 0; j < lengthOfArray - i - 1; j++) {
        array[j].toColor(Colors.red);
        array[j + 1].toColor(Colors.red);
        setState();
        if (array[j].number > array[j + 1].number) {
          await Future.delayed(delayedDuration);

          // Swapping using temporary variable
          final temp = array[j];
          array[j] = array[j + 1];
          array[j + 1] = temp;
        }
        array[j].toColor(Colors.white);
        array[j + 1].toColor(Colors.white);
        setState();
      }
    }
  }

  insertionSort(List<ArrayElement> currentArray, int arrayLength,
      Duration delayedDuration) async {
    final list = currentArray;
    int n = arrayLength;

    for (int i = 1; i < n; i++) {
      setState();
      list[i].toColor(Colors.red);
      setState();
      var temp = list[i];
      int j = i - 1;
      while (j >= 0 && temp.number < list[j].number) {
        list[j].toColor(Colors.red);
        setState();
        list[j + 1] = list[j];
        await Future.delayed(delayedDuration);
        list[j + 1].toColor(Colors.white);
        setState();
        --j;
      }
      list[j + 1] = temp;
      await Future.delayed(delayedDuration);
      list[j + 1].toColor(Colors.white);
      setState();
    }
  }

  selectionSort(List<ArrayElement> currentArray, int arrayLength,
      Duration delayedDuration) async {
    final list = currentArray;
    final e = arrayLength;

    ArrayElement tmp;
    int m, i, j;
    for (i = 0; i < e; ++i) {
      m = i;
      list[i].toColor(Colors.red);
      setState();
      for (j = i + 1; j < e; ++j) {
        list[j].toColor(Colors.red);
        setState();
        if (list[j].number < list[m].number) {
          m = j;
        }
        await Future.delayed(delayedDuration);
        list[j].toColor(Colors.white);
        setState();
      }
      if (m != i) {
        tmp = list[m];
        list[m] = list[i];
        list[i] = tmp;
      }
      list[m].toColor(Colors.white);
      setState();
    }
  }
}
