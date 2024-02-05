import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  FlutterBlue flutterBlue = FlutterBlue.instance;
  bool isScanning = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('BLE Scanner for Bhumik'),
        backgroundColor: Colors.blue,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () {
                if (isScanning) {
                  stopScan();
                } else {
                  startScan();
                }
              },
              child: Text(isScanning ? 'Stop Scanning' : 'Start Scanning'),
            ),
          ],
        ),
      ),
    );
  }

  void startScan() {
    setState(() {
      isScanning = true;
    });

    flutterBlue.startScan(timeout: Duration(seconds: 4));

    flutterBlue.scanResults.listen((List<ScanResult> results) {
      // Do something with scan results
      for (ScanResult result in results) {
        print('Device found: ${result.device.name}');
      }
    });
  }

  void stopScan() {
    setState(() {
      isScanning = false;
    });

    flutterBlue.stopScan();
  }
}
