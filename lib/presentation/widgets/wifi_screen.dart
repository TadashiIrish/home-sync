// import 'package:flutter/material.dart';
// import '../../data/sevices/wifi_service.dart';
// import 'package:wifi_scan/wifi_scan.dart';
//
// class WiFiScreen extends StatefulWidget {
//   @override
//   _WiFiScreenState createState() => _WiFiScreenState();
// }
//
// class _WiFiScreenState extends State<WiFiScreen> {
//   final WiFiService _wifiService = WiFiService();
//   List<WiFiAccessPoint> _wifiNetworks = [];
//   String? _connectedSSID;
//
//   @override
//   void initState() {
//     super.initState();
//     _initializeWiFi();
//   }
//
//   Future<void> _initializeWiFi() async {
//     _wifiNetworks = await _wifiService.scanNetworks();
//     _connectedSSID = await _wifiService.loadSavedSSID();
//     setState(() {});
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text("HomeSync WiFi Setup")),
//       body: ListView.builder(
//         itemCount: _wifiNetworks.length,
//         itemBuilder: (context, index) {
//           String ssid = _wifiNetworks[index].ssid ?? "Unknown";
//           bool isConnected = ssid == _connectedSSID;
//           return ListTile(
//             title: Text(ssid),
//             trailing: Switch(
//               value: isConnected,
//               onChanged: (value) async {
//                 if (value) {
//                   bool success = await _wifiService.connectToWiFi(ssid);
//                   if (success) setState(() => _connectedSSID = ssid);
//                 } else {
//                   await _wifiService.disconnectWiFi();
//                   setState(() => _connectedSSID = null);
//                 }
//               },
//             ),
//           );
//         },
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import '../../data/sevices/wifi_service.dart';
import 'package:wifi_scan/wifi_scan.dart';

class WiFiScreen extends StatefulWidget {
  @override
  _WiFiScreenState createState() => _WiFiScreenState();
}

class _WiFiScreenState extends State<WiFiScreen> {
  final WiFiService _wifiService = WiFiService();
  List<WiFiAccessPoint> _wifiNetworks = [];
  String? _connectedSSID;

  @override
  void initState() {
    super.initState();
    _initializeWiFi();
  }

  Future<void> _initializeWiFi() async {
    _wifiNetworks = await _wifiService.scanNetworks();
    _connectedSSID = await _wifiService.loadSavedSSID();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Scan WiFi Devices")),
      body: Column(
        children: [
          ElevatedButton(
            onPressed: () async {
              await _initializeWiFi();
            },
            child: Text("Start Scan"),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _wifiNetworks.length,
              itemBuilder: (context, index) {
                String ssid = _wifiNetworks[index].ssid ?? "Unknown";
                bool isConnected = ssid == _connectedSSID;
                return ListTile(
                  title: Text(ssid),
                  trailing: Switch(
                    value: isConnected,
                    onChanged: (value) async {
                      if (value) {
                        bool success = await _wifiService.connectToWiFi(ssid);
                        if (success) setState(() => _connectedSSID = ssid);
                      } else {
                        await _wifiService.disconnectWiFi();
                        setState(() => _connectedSSID = null);
                      }
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}