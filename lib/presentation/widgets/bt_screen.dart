// import 'package:flutter/material.dart';
// import 'package:flutter_blue_plus/flutter_blue_plus.dart';
//
// class BluetoothScanScreen extends StatefulWidget {
//   @override
//   _BluetoothScanScreenState createState() => _BluetoothScanScreenState();
// }
//
// class _BluetoothScanScreenState extends State<BluetoothScanScreen> {
//   List<ScanResult> _scanResults = [];
//   bool _isScanning = false;
//
//   void _startScan() async {
//     setState(() => _isScanning = true);
//     _scanResults.clear();
//
//     FlutterBluePlus.startScan(timeout: Duration(seconds: 5));
//
//     FlutterBluePlus.scanResults.listen((results) {
//       setState(() => _scanResults = results);
//     });
//
//     await Future.delayed(Duration(seconds: 5));
//     setState(() => _isScanning = false);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text("Bluetooth Scanner")),
//       body: Column(
//         children: [
//           ElevatedButton(
//             onPressed: _isScanning ? null : _startScan,
//             child: Text(_isScanning ? "Scanning..." : "Start Scan"),
//           ),
//           Expanded(
//             child: ListView.builder(
//               itemCount: _scanResults.length,
//               itemBuilder: (context, index) {
//                 final result = _scanResults[index];
//                 return ListTile(
//                   title: Text(result.device.platformName.isNotEmpty
//                       ? result.device.platformName
//                       : "Unknown Device"),
//                   subtitle: Text(result.device.remoteId.toString()),
//                 );
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';

class BluetoothScanScreen extends StatefulWidget {
  @override
  _BluetoothScanScreenState createState() => _BluetoothScanScreenState();
}

class _BluetoothScanScreenState extends State<BluetoothScanScreen> {
  List<ScanResult> _scanResults = [];
  bool _isScanning = false;

  void _toggleScan() async {
    if (_isScanning) {
      FlutterBluePlus.stopScan();
      setState(() => _isScanning = false);
    } else {
      setState(() => _isScanning = true);
      _scanResults.clear();

      FlutterBluePlus.startScan();

      FlutterBluePlus.scanResults.listen((results) {
        setState(() => _scanResults = results);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Scan Bluetooth Devices")),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: ElevatedButton(
              onPressed: _toggleScan,
              child: Text(_isScanning ? "Stop Scan" : "Start Scan"),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _scanResults.length,
              itemBuilder: (context, index) {
                final result = _scanResults[index];
                return ListTile(
                  title: Text(result.device.platformName.isNotEmpty
                      ? result.device.platformName
                      : "Unknown Device"),
                  subtitle: Text(result.device.remoteId.toString()),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}