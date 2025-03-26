import 'package:flutter/material.dart';
import 'package:homesync/features/security/door_lock.dart';
import '../../features/room_control/room_list.dart';
import '../widgets/device_card.dart';
import '../../features/room_control/room_details.dart';
import '../widgets/settings.dart';
import '../../features/automation/schedule_setup.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isDarkTheme = false; // Change theme state
  bool isHouseLocked = false; // House lock state

  int _selectedIndex = 0; // Track the selected tab

  final List<Widget> _pages = [
    HomeScreen(),         // Home
    AutomationScreen(), // Automation (Schedule Setup)
    Center(child: Text('Security Section')), // Placeholder for Security
  ];

  // void _onItemTapped(int index) {
  //   setState(() {
  //     _selectedIndex = index;
  //   });
  // }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    if (index == 1) { // Automation Tab
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => AutomationScreen()),
      );
    }

    if(index==2){ // Locking System
      Navigator.push(
        context, MaterialPageRoute(builder: (context) => DoorLockScreen()),
      );
    }
  }

  void toggleTheme(bool value) {
    setState(() {
      isDarkTheme = value;
    });
  }

  void toggleLockState() {
    setState(() {
      isHouseLocked = !isHouseLocked;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(isHouseLocked ? 'Main Entrance Locked' : 'Main Entrance Unlocked'),
        backgroundColor: isHouseLocked ? Colors.red : Colors.green,
      ),
    );
  }

  final List<Map<String, dynamic>> rooms = [
    {
      'name': 'Living Room',
      'devices': [
        {'name': 'Lights', 'state': true, 'icon': Icons.lightbulb},
        {'name': 'TV', 'state': false, 'icon': Icons.tv},
        {'name': 'Fan', 'state': true, 'icon': Icons.air},
      ]
    },
    {
      'name': 'Bedroom',
      'devices': [
        {'name': 'AC', 'state': false, 'icon': Icons.ac_unit},
        {'name': 'Fan', 'state': true, 'icon': Icons.air},
        {'name': 'Lights', 'state': true, 'icon': Icons.lightbulb},
      ]
    },
    {
      'name': 'Kitchen',
      'devices': [
        {'name': 'Lights', 'state': true, 'icon': Icons.lightbulb},
        {'name': 'Microwave', 'state': false, 'icon': Icons.microwave},
        {'name': 'Chimney', 'state': false, 'icon': Icons.heat_pump_outlined},
        {'name': 'Exhaust', 'state': true, 'icon': Icons.wind_power}
      ]
    }
  ];

  void toggleDeviceState(int roomIndex, int deviceIndex) {
    setState(() {
      rooms[roomIndex]['devices'][deviceIndex]['state'] =
      !rooms[roomIndex]['devices'][deviceIndex]['state'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: isDarkTheme ? ThemeData.dark() : ThemeData.light(),
      home: Scaffold(
        appBar: AppBar(
          title: Center(
            child: SizedBox(
              height: kToolbarHeight - 15,
              child: Image.asset('images/icons/HS_icon.jpg', fit: BoxFit.contain),
            ),
          ),
        ),
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              DrawerHeader(
                decoration: BoxDecoration(color: Colors.blue),
                child: Text('Settings Menu',
                    style: TextStyle(color: Colors.white, fontSize: 20)),
              ),
              ListTile(
                leading: Icon(Icons.settings),
                title: Text('General Settings'),
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => SettingsScreen()));
                },
              ),
              ListTile(
                leading: Icon(Icons.brightness_6),
                title: Text('Theme'),
                trailing: Switch(
                  value: isDarkTheme,
                  onChanged: toggleTheme,
                ),
              ),
              ListTile(
                leading: Icon(Icons.info),
                title: Text('About'),
                onTap: () {},
              ),
            ],
          ),
        ),
        body: Column(
          children: [
            // Lock Button Positioned Below AppBar
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                width: double.infinity,
                height: 60,
                decoration: BoxDecoration(
                  color: isHouseLocked ? Colors.red : Colors.red[200], // Toggle color
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.white60),
                ),
                child: TextButton.icon(
                  onPressed: toggleLockState,
                  icon: Icon(Icons.lock, color: isHouseLocked ? Colors.white : Colors.black),
                  label: Text(
                    isHouseLocked ? 'Main Entrance Locked' : 'Lock Main Entrance',
                    style: TextStyle(color: isHouseLocked ? Colors.white : Colors.black, fontSize: 18),
                  ),
                ),
              ),
            ),

            // Expanded Room Grid
            Expanded(
              child: GridView.builder(
                padding: EdgeInsets.all(16),
                itemCount: rooms.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  childAspectRatio: 1.1,
                ),
                itemBuilder: (context, roomIndex) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => RoomDetailsScreen(roomName: rooms[roomIndex]['name']),//clicking on room name leads to that particular room details
                        ),
                      );
                    },
                    child: Card(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            rooms[roomIndex]['name'],
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).brightness == Brightness.dark
                                  ? Colors.white
                                  : Colors.black,
                            ),
                          ),
                          SizedBox(height: 8),
                          Expanded(
                            child: ListView(
                              shrinkWrap: true,
                              children: List.generate(rooms[roomIndex]['devices'].length, (deviceIndex) {
                                return DeviceCard(
                                  deviceName: rooms[roomIndex]['devices'][deviceIndex]['name'],
                                  deviceIcon: rooms[roomIndex]['devices'][deviceIndex]['icon'],
                                  initialState: rooms[roomIndex]['devices'][deviceIndex]['state'],
                                  onTap: () => toggleDeviceState(roomIndex, deviceIndex),
                                );
                              }),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => RoomListScreen(),
              ),
            );
          },
          child: Icon(Icons.add),
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
          selectedItemColor: Colors.blue,
          unselectedItemColor: Colors.grey,
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(icon: Icon(Icons.alarm_add_outlined), label: 'Automation'),
            BottomNavigationBarItem(icon: Icon(Icons.lock), label: 'Security'),
          ],
        ),
      ),
    );
  }
}
