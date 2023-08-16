import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';



class Driver {
  final String driverName;
  final String truckNumber;
  final String status;

  Driver(this.driverName, this.truckNumber, this.status);
}



class StatusCountScreen extends StatefulWidget {
  @override
  _StatusCountScreenState createState() => _StatusCountScreenState();
}

class _StatusCountScreenState extends State<StatusCountScreen> {
  List<Driver> drivers = [];

  @override
  void initState() {
    super.initState();
    loadDriverData();
  }

  Future<void> loadDriverData() async {
    String jsonContent = await rootBundle.loadString('assets/truckstatus.json');
    List<dynamic> driverList = json.decode(jsonContent)['data'];
    drivers = driverList
        .map((driverData) => Driver(
              driverData['driver_name'],
              driverData['truck_number'],
              driverData['status'],
            ))
        .toList();
    setState(() {});
  }

  int getActiveDriverCount() {
    return drivers.where((driver) => driver.status == 'active').length;
  }

  int getInactiveDriverCount() {
    return drivers.where((driver) => driver.status == 'inactive').length;
  }
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Driver Status'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Active Drivers: ${getActiveDriverCount()}'),
            Text('Inactive Drivers: ${getInactiveDriverCount()}'),
          ],
        ),
      ),
    );
  }
}
