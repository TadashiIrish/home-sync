import 'package:flutter/material.dart';

class RoomDetailsScreen extends StatefulWidget {
  final String? roomName;
  RoomDetailsScreen({this.roomName});

  @override
  _RoomDetailsScreenState createState() => _RoomDetailsScreenState();
}

class _RoomDetailsScreenState extends State<RoomDetailsScreen> {
  List<Map<String, dynamic>> devices = [];

  void _addNewDevice() {
    TextEditingController deviceController = TextEditingController();
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Add New Device"),
          content: TextField(
            controller: deviceController,
            decoration: InputDecoration(hintText: "Enter device name"),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                if (deviceController.text.isNotEmpty) {
                  setState(() {
                    devices.add({
                      'name': deviceController.text,
                      'state': false,
                      'icon': Icons.device_hub,
                    });
                  });
                }
                Navigator.of(context).pop();
              },
              child: Text("Add"),
            ),
          ],
        );
      },
    );
  }

  void toggleDeviceState(int index) {
    setState(() {
      devices[index]['state'] = !devices[index]['state'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.roomName ?? "Room Details"),
      ),
      body: ListView.builder(
        padding: EdgeInsets.all(16),
        itemCount: devices.length,
        itemBuilder: (context, index) {
          return Card(
            child: ListTile(
              leading: Icon(devices[index]['icon']),
              title: Text(devices[index]['name']),
              trailing: Switch(
                value: devices[index]['state'],
                onChanged: (value) => toggleDeviceState(index),
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addNewDevice,
        child: Icon(Icons.add),
      ),
    );
  }
}