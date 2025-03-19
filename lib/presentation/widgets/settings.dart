// import 'package:flutter/material.dart';
//
// class SettingsScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Settings'),
//       ),
//       body: ListView(
//         children: [
//           _buildSettingsSection(context, 'Room Settings', [
//             _buildSettingItem(context, 'Rename Room'),
//             _buildSettingItem(context, 'Delete Room'),
//             _buildSettingItem(context, 'Reorder Rooms'),
//           ]),
//           _buildSettingsSection(context, 'Device Settings', [
//             _buildSettingItem(context, 'Rename Device'),
//             _buildSettingItem(context, 'Assign Device to Room'),
//             _buildSettingItem(context, 'Set Device Icon'),
//           ]),
//           _buildSettingsSection(context, 'Connection Settings', [
//             _buildSettingItem(context, 'WiFi Configuration'),
//             _buildSettingItem(context, 'Bluetooth Pairing'),
//             _buildSettingItem(context, 'Reconnect Lost Devices'),
//           ]),
//           _buildSettingsSection(context, 'Reset', [
//             _buildSettingItem(context, 'Reset Room', isDestructive: true),
//             _buildSettingItem(context, 'Reset Device', isDestructive: true),
//             _buildSettingItem(context, 'Reset Application', isDestructive: true),
//           ]),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildSettingsSection(BuildContext context, String title, List<Widget> items) {
//     return Card(
//       margin: EdgeInsets.all(10),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Padding(
//             padding: const EdgeInsets.all(10.0),
//             child: Text(
//               title,
//               style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//             ),
//           ),
//           Column(children: items),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildSettingItem(BuildContext context, String label, {bool isDestructive = false}) {
//     return ListTile(
//       title: Text(label, style: TextStyle(color: isDestructive ? Colors.red : Colors.grey[55])),
//       trailing: Icon(Icons.arrow_forward_ios, size: 16),
//       onTap: () {
//         // Navigate to detailed settings page or show dialog
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text('$label selected')),
//         );
//       },
//     );
//   }
// }
import '../home/home_screen.dart';
import '../widgets/device_card.dart';
import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  List<String> rooms = ['Living Room', 'Bedroom', 'Kitchen'];

  void _renameRoom(int index) {
    TextEditingController controller = TextEditingController(text: rooms[index]);
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Rename Room'),
          content: TextField(
            controller: controller,
            decoration: InputDecoration(hintText: 'Enter new room name'),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                String newName = controller.text.trim();
                if (newName.isNotEmpty && newName != rooms[index]) {
                  setState(() {
                    rooms[index] = newName;
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

  void _deleteRoom(int index) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Delete ${rooms[index]}?'),
          content: Text('Are you sure you want to delete this room?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  rooms.removeAt(index);
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Settings')),
      body: ListView(
        children: [
          _buildSettingsSection(context, 'Room Settings', [
            ListTile(
              title: Text('Rename Room'),
              trailing: Icon(Icons.arrow_forward_ios, size: 16),
              onTap: () => _showRoomList(context, isRenaming: true),
            ),
            ListTile(
              title: Text('Delete Room'),
              trailing: Icon(Icons.arrow_forward_ios, size: 16),
              onTap: () => _showRoomList(context, isRenaming: false),
            ),
            _buildSettingItem(context, 'Reorder Rooms'),
          ]),
        ],
      ),
    );
  }

  void _showRoomList(BuildContext context, {required bool isRenaming}) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return ListView.builder(
          itemCount: rooms.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(rooms[index]),
              trailing: Icon(isRenaming ? Icons.edit : Icons.delete, color: isRenaming ? null : Colors.red),
              onTap: () {
                Navigator.pop(context);
                if (isRenaming) {
                  _renameRoom(index);
                } else {
                  _deleteRoom(index);
                }
              },
            );
          },
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

  Widget _buildSettingItem(BuildContext context, String label, {bool isDestructive = false}) {
    return ListTile(
      title: Text(label, style: TextStyle(color: isDestructive ? Colors.red : Colors.black)),
      trailing: Icon(Icons.arrow_forward_ios, size: 16),
      onTap: () {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('$label selected')),
        );
      },
    );
  }
}
