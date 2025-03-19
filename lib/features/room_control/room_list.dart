import 'package:flutter/material.dart';

class RoomListScreen extends StatefulWidget {
  @override
  _RoomListScreenState createState() => _RoomListScreenState();
}

class _RoomListScreenState extends State<RoomListScreen> {
  List<String> rooms = ['Living Room', 'Bedroom', 'Kitchen'];

  void addRoom() {
    TextEditingController roomController = TextEditingController();
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Add New Room'),
        content: TextField(
          controller: roomController,
          decoration: InputDecoration(hintText: 'Enter room name'),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              if (roomController.text.isNotEmpty) {
                setState(() {
                  rooms.add(roomController.text);
                });
              }
              Navigator.pop(context);
            },
            child: Text('Add'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Room List')),
      body: ListView.builder(
        itemCount: rooms.length,
        itemBuilder: (context, index) => ListTile(
          title: Text(rooms[index]),
          leading: Icon(Icons.meeting_room),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: addRoom,
        child: Icon(Icons.add),
      ),
    );
  }
}
