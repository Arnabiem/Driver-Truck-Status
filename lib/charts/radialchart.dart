import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

// import '../components/statusCount.dart';
class Driver {
  final String driverName;
  final String truckNumber;
  final String status;

  Driver(this.driverName, this.truckNumber, this.status);
}




class RadialChartWidget extends StatefulWidget {
  const RadialChartWidget({Key? key}) : super(key: key);

  @override
  _RadialChartWidgetState createState() => _RadialChartWidgetState();
}

class _RadialChartWidgetState extends State<RadialChartWidget> {
  
   static List<Driver> drivers = [];

  @override
  void initState() {
    super.initState();
    loadDriverData();
  }

  Future<void> loadDriverData() async {
    String jsonContent = await rootBundle.loadString('assets/truckstatus.json');
    List<dynamic> driverList = json.decode(jsonContent)['data'];
    drivers = driverList.map((driverData) => Driver(
              driverData['driver_name'],
              driverData['truck_number'],
              driverData['status'],
            ))
        .toList();
    setState(() {});
  }

 static int getActiveDriverCount() {
    return drivers.where((driver) => driver.status == 'active').length;
  }

  static int  getInactiveDriverCount() {
    return drivers.where((driver) => driver.status == 'inactive').length;
  }




  var chartData = [
    _RadialData('Active', getActiveDriverCount()),
    _RadialData('In Active', getInactiveDriverCount()),
    ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(''),
      ),
      // body: Center(
          body: Container(
            height: 300,
        margin: EdgeInsets.all(20),
        child: SfCircularChart(
            backgroundColor: Colors.black,
            palette: [ const Color.fromARGB(255, 8, 132, 234),const Color.fromARGB(255, 101, 192, 234),],
            title: ChartTitle(text: 'Active Vehicles',),
            legend: Legend(isVisible: true),
            series:[
              RadialBarSeries<_RadialData,String>(
                radius: '80%',
                innerRadius: '70%',
                gap: '8%',
                cornerStyle: CornerStyle.bothCurve,
                dataSource: chartData,
              xValueMapper: (_RadialData data, _)=> data.xData, 
              yValueMapper: (_RadialData data, _)=> data.yData)
              
            ]),
      ),
    );
  }
}

class _RadialData {
  _RadialData(this.xData, this.yData);
   final String xData;
  final num yData;
}