import 'package:homesync/presentation/widgets/wifi_screen.dart';

import '../home/home_screen.dart';
import '../widgets/device_card.dart';
import '../widgets/bt_screen.dart';
import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  List<String> rooms = ['Living Room', 'Bedroom', 'Kitchen'];
  List<String> devices = ['Smart Light', 'Smart Fan', 'Smart Lock'];

  void _renameItem(int index, List<String> list, String title) {
    TextEditingController controller = TextEditingController(text: list[index]);
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Rename $title'),
          content: TextField(
            controller: controller,
            decoration: InputDecoration(hintText: 'Enter new name'),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                String newName = controller.text.trim();
                if (newName.isNotEmpty && newName != list[index]) {
                  setState(() {
                    list[index] = newName;
                  });
                }
                Navigator.pop(context);
              },
              child: Text('Confirm'),
            ),
          ],
        );
      },
    );
  }

  void _deleteItem(int index, List<String> list, String title) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Delete ${list[index]}?'),
          content: Text('Are you sure you want to delete this $title?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  list.removeAt(index);
                });
                Navigator.pop(context);
              },
              child: Text('Confirm', style: TextStyle(color: Colors.red)),
            ),
          ],
        );
      },
    );
  }

  void _resetRooms() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Reset Rooms'),
          content: Text('All the saved rooms will be deleted.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  rooms.clear();
                });
                Navigator.pop(context);
              },
              child: Text('Confirm', style: TextStyle(color: Colors.red)),
            ),
          ],
        );
      },
    );
  }

  void _resetDevicesInRoom() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return ListView.builder(
          itemCount: rooms.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(rooms[index]),
              onTap: () {
                Navigator.pop(context);
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: Text('Reset Devices in ${rooms[index]}?'),
                      content: Text('All the devices of ${rooms[index]} will be lost.'),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: Text('Cancel'),
                        ),
                        TextButton(
                          onPressed: () {
                            // Add logic to reset devices in the selected room
                            Navigator.pop(context);
                          },
                          child: Text('Confirm', style: TextStyle(color: Colors.red)),
                        ),
                      ],
                    );
                  },
                );
              },
            );
          },
        );
      },
    );
  }

  void _factoryReset() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Factory Reset'),
          content: Text('All the saved data will be cleared.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  rooms.clear();
                  devices.clear();
                });
                Navigator.pop(context);
              },
              child: Text('Confirm', style: TextStyle(color: Colors.red)),
            ),
          ],
        );
      },
    );
  }
  Widget _buildSettingsSection(BuildContext context, String title, List<Widget> items) {
    return Card(
      margin: EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text(
              title,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          Column(children: items),
        ],
      ),
    );
  }

  Widget _buildListOption(BuildContext context, String title, List<String> list, String itemType, IconData icon, {bool isDelete = false}) {
    return ListTile(
      title: Text(title, style: TextStyle(color: isDelete ? Colors.red : Colors.grey[55])),
      trailing: Icon(Icons.arrow_forward_ios, size: 16),
      onTap: () => _showItemList(context, list, itemType, icon, isDelete),
    );
  }

  Widget _buildSimpleOption(BuildContext context, String title, IconData icon, {VoidCallback? onTap}) {
    return ListTile(
      title: Text(title),
      leading: Icon(icon),
      trailing: Icon(Icons.arrow_forward_ios, size: 16),
      onTap: onTap,
    );
  }

  void _showItemList(BuildContext context, List<String> list, String itemType, IconData icon, bool isDelete) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return ListView.builder(
          itemCount: list.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(list[index]),
              trailing: Icon(icon, color: isDelete ? Colors.red : null),
              onTap: () {
                Navigator.pop(context);
                if (isDelete) {
                  _deleteItem(index, list, itemType);
                } else {
                  _renameItem(index, list, itemType);
                }
              },
            );
          },
        );
      },
    );
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Settings')),
      body: ListView(
        children: [
          _buildSettingsSection(context, 'Room Settings', [
            _buildListOption(context, 'Rename Room', rooms, 'Room', Icons.edit),
            _buildListOption(context, 'Delete Room', rooms, 'Room', Icons.delete, isDelete: true),
          ]),
          _buildSettingsSection(context, 'Device Settings', [
            _buildListOption(context, 'Rename Device', devices, 'Device', Icons.edit),
            _buildListOption(context, 'Delete Device', devices, 'Device', Icons.delete, isDelete: true),
          ]),
          _buildSettingsSection(context, 'Configuration Settings', [
            _buildSimpleOption(context, 'Bluetooth Configuration', Icons.bluetooth,onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => BluetoothScanScreen()));
            }),
            _buildSimpleOption(context, 'WiFi Configuration', Icons.wifi, onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => WiFiScreen()));
            }),
            _buildSimpleOption(context, 'Reconnect Lost Devices', Icons.refresh),
          ]),
          _buildSettingsSection(context, 'Reset Settings', [
            _buildSimpleOption(context, 'Reset Rooms', Icons.room_preferences, onTap: _resetRooms),
            _buildSimpleOption(context, 'Reset Devices in a Room', Icons.devices_other, onTap: _resetDevicesInRoom),
            _buildSimpleOption(context, 'Factory Reset', Icons.restore, onTap: _factoryReset,),
          ]),
        ],
      ),
    );
  }
}
