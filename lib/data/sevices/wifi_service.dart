// import 'package:wifi_iot/wifi_iot.dart';
// import 'package:shared_preferences/shared_preferences.dart';
//
// class WiFiService {
//   Future<List<WifiNetwork>> scanNetworks() async {
//     return await WiFiForIoTPlugin.loadWifiList() ?? [];
//   }
//
//   Future<bool> connectToWiFi(String ssid, {String? password}) async {
//     bool success = await WiFiForIoTPlugin.connect(ssid, password: password);
//     if (success) await _saveSSID(ssid);
//     return success;
//   }
//
//   Future<void> disconnectWiFi() async {
//     await WiFiForIoTPlugin.disconnect();
//     await _clearSSID();
//   }
//
//   Future<void> _saveSSID(String ssid) async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     await prefs.setString("saved_ssid", ssid);
//   }
//
//   Future<String?> loadSavedSSID() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     return prefs.getString("saved_ssid");
//   }
//
//   Future<bool> isWiFiEnabled() async {
//     return await WiFiForIoTPlugin.isWiFiEnabled();
//   }
//
//   Future<void> _clearSSID() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     await prefs.remove("saved_ssid");
//   }
// }

import 'package:wifi_scan/wifi_scan.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WiFiService {
  Future<List<WiFiAccessPoint>> scanNetworks() async {
    final canGetScans = await WiFiScan.instance.canGetScannedResults();
    if (canGetScans == CanGetScannedResults.yes) {
      return await WiFiScan.instance.getScannedResults() ?? [];
    }
    return [];
  }

  Future<bool> connectToWiFi(String ssid, {String? password}) async {
    // Custom connection logic based on IoT device requirements
    await _saveSSID(ssid);
    return true;
  }

  Future<void> disconnectWiFi() async {
    await _clearSSID();
  }

  Future<void> _saveSSID(String ssid) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString("saved_ssid", ssid);
  }

  Future<String?> loadSavedSSID() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString("saved_ssid");
  }

  Future<void> _clearSSID() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove("saved_ssid");
  }
}