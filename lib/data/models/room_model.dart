class Room {
  final String name; // Room name (e.g., "Living Room", "Bedroom")
  final List<String> devices; // List of device names in the room

  Room({required this.name, required this.devices});

  // Convert Room to a Map (for storage, database, etc.)
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'devices': devices,
    };
  }

  // Create a Room object from a Map (useful for retrieving from a database)
  factory Room.fromMap(Map<String, dynamic> map) {
    return Room(
      name: map['name'],
      devices: List<String>.from(map['devices']),
    );
  }
}