import 'package:flutter/material.dart';

class DeviceCard extends StatefulWidget {
  final String deviceName;
  final IconData deviceIcon;
  final bool initialState;
  final VoidCallback? onTap;

  const DeviceCard({
    Key? key,
    required this.deviceName,
    required this.deviceIcon,
    required this.initialState,
    this.onTap,
  }) : super(key: key);

  @override
  _DeviceCardState createState() => _DeviceCardState();
}

class _DeviceCardState extends State<DeviceCard> {
  late bool isOn;

  @override
  void initState() {
    super.initState();
    isOn = widget.initialState;
  }

  void toggleState() {
    setState(() {
      isOn = !isOn;
    });
    if (widget.onTap != null) {
      widget.onTap!();
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: toggleState,
      child: AnimatedContainer(
        duration: Duration(milliseconds: 300),
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: isOn ? Colors.blue.shade100 : Colors.grey.shade300,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 4,
              spreadRadius: 1,
            )
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(widget.deviceIcon, size: 40, color: isOn ? Colors.blue : Colors.black54),
            SizedBox(height: 10),
            Text(
              widget.deviceName,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black),
            ),
            Switch(
              value: isOn,
              onChanged: (value) => toggleState(),
            ),
          ],
        ),
      ),
    );
  }
}