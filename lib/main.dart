import 'package:flutter/material.dart';
// import 'package:radial_chart/components/statusCount.dart';


import 'charts/radialchart.dart';

void main() {
  runApp(new MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Graphs',
        theme: ThemeData(brightness: Brightness.dark),
        debugShowCheckedModeBanner: false,
        home: RadialChartWidget());
  }
}