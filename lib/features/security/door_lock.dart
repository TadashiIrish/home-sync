import 'package:flutter/material.dart';

class DoorLockScreen extends StatefulWidget {
  @override
  _DoorLockScreenState createState() => _DoorLockScreenState();
}

class _DoorLockScreenState extends State<DoorLockScreen> {
  Map<String, bool> roomLockStates = {
    'Living Room': false,
    'Bedroom': false,
    'Kitchen': false,
    // 'Bathroom': false,
  };

  void toggleLock(String roomName) {
    setState(() {
      roomLockStates[roomName] = !roomLockStates[roomName]!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Security Control'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Expanded(
          child: ListView(
            children: roomLockStates.keys.map((roomName) {
              return Card(
                child: ListTile(
                  title: Text(roomName, style: TextStyle(fontSize: 18)),
                  trailing: Icon(
                    roomLockStates[roomName]!
                        ? Icons.lock
                        : Icons.lock_open,
                    color: roomLockStates[roomName]! ? Colors.red : Colors.green,
                  ),
                  onTap: () => toggleLock(roomName),
                ),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}
