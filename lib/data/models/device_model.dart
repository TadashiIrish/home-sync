class Device {
  final String name; // Device name (e.g., "Smart Light", "Fan")
  bool isOn; // Device state (on/off)
  double? brightness; // Optional brightness control (for lights, screens)
  double? speed; // Optional speed control (for fans, motors)

  Device({
    required this.name,
    this.isOn = false,
    this.brightness,
    this.speed,
  });

  // Convert Device to a Map for database storage
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'isOn': isOn,
      'brightness': brightness,
      'speed': speed,
    };
  }

  // Create a Device object from a Map (retrieving from database)
  factory Device.fromMap(Map<String, dynamic> map) {
    return Device(
      name: map['name'],
      isOn: map['isOn'],
      brightness: map['brightness'],
      speed: map['speed'],
    );
  }
}