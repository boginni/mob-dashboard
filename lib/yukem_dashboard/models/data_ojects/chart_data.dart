import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DataSeries<T> {
  static getGradient(MaterialColor cor) {
    final List<Color> color = <Color>[];
    color.add(cor[50]!);
    color.add(cor[200]!);
    color.add(cor);

    final List<double> stops = <double>[];
    stops.add(0.0);
    stops.add(0.5);
    stops.add(1.0);

    return LinearGradient(
        colors: color,
        stops: stops,
        begin: Alignment.topCenter,
        end: Alignment.topCenter);
  }

  final String title;
  final List<ChartData<T>> series;

  final LinearGradient? gradient;

  DataSeries(this.title, this.series, {this.gradient}) {
    // gradient = getGradient(colors[curColor++]);
  }

  ChartData<String> sumSeries() {
    double sum = 0;

    for (var element in series) {
      sum += element.y;
    }

    return ChartData(title, sum);
  }
}

class ChartData<T> {
  ChartData(this.x, this.y);

  final T x;
  final double y;
}

int curColor = 0;

const colors = [Colors.red, Colors.blue];
