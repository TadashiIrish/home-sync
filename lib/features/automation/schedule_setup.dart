import 'package:flutter/material.dart';

class AutomationScreen extends StatefulWidget {
  @override
  _AutomationScreenState createState() => _AutomationScreenState();
}

class _AutomationScreenState extends State<AutomationScreen> {
  List<Map<String, dynamic>> automations = [];

  void _addAutomation() async {
    String? selectedDevice;
    String? selectedAction;
    TimeOfDay? selectedTime;

    await showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setDialogState) {
            return AlertDialog(
              title: Text("Create Automation"),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  DropdownButton<String>(
                    value: selectedDevice,
                    hint: Text("Select Device"),
                    onChanged: (value) {
                      setDialogState(() => selectedDevice = value);
                    },
                    items: ["Lights", "Fan", "AC", "TV", "Microwave"]
                        .map((device) => DropdownMenuItem(
                      value: device,
                      child: Text(device),
                    ))
                        .toList(),
                  ),
                  DropdownButton<String>(
                    value: selectedAction,
                    hint: Text("Select Action"),
                    onChanged: (value) {
                      setDialogState(() => selectedAction = value);
                    },
                    items: ["Turn ON", "Turn OFF"]
                        .map((action) => DropdownMenuItem(
                      value: action,
                      child: Text(action),
                    ))
                        .toList(),
                  ),
                  TextButton(
                    onPressed: () async {
                      TimeOfDay? picked = await showTimePicker(
                        context: context,
                        initialTime: TimeOfDay.now(),
                      );
                      if (picked != null) {
                        setDialogState(() => selectedTime = picked);
                      }
                    },
                    child: Text(
                      selectedTime != null
                          ? "Time: ${selectedTime!.format(context)}"
                          : "Select Time",
                      style: TextStyle(fontSize: 16, color: Colors.blue),
                    ),
                  ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text("Cancel"),
                ),
                TextButton(
                  onPressed: () {
                    if (selectedDevice != null &&
                        selectedAction != null &&
                        selectedTime != null) {
                      setState(() {
                        automations.add({
                          'device': selectedDevice,
                          'action': selectedAction,
                          'time': selectedTime!.format(context),
                        });
                      });
                      Navigator.pop(context);
                    }
                  },
                  child: Text("Save"),
                ),
              ],
            );
          },
        );
      },
    );
  }

  void _removeAutomation(int index) {
    setState(() {
      automations.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Automation")),
      body: automations.isEmpty
          ? Center(child: Text("No Automations Added"))
          : ListView.builder(
        itemCount: automations.length,
        itemBuilder: (context, index) {
          return Card(
            margin: EdgeInsets.all(10),
            child: ListTile(
              leading: Icon(Icons.schedule),
              title: Text(
                  "${automations[index]['device']} - ${automations[index]['action']}"),
              subtitle: Text("Time: ${automations[index]['time']}"),
              trailing: IconButton(
                icon: Icon(Icons.delete, color: Colors.red),
                onPressed: () => _removeAutomation(index),
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addAutomation,
        child: Icon(Icons.add),
      ),
    );
  }
}
