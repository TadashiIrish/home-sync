// import 'package:flutter/material.dart';
// //import '../room_details/add_appliance.dart';
//
// class HomeScreen extends StatefulWidget{
//   @override
//   _HomeScreenState createState() => _HomeScreenState();
// }
//
// class _HomeScreenState extends State<HomeScreen> {
//   //int _selectedIndex = 0;
//
//   // List of pages corresponding to bottom nav items
//   final List<Map<String, dynamic>> rooms = [
//     {'name': 'Living Room', 'devices': [{'name': 'TV', 'state': false}, {'name': 'Fan', 'state': true}]},
//     {'name': 'Bedroom', 'devices': [{'name': 'AC', 'state': false}, {'name': 'Lamp', 'state': true}]},
//     {'name': 'Kitchen', 'devices': [{'name': 'Refrigerator', 'state': true}, {'name': 'Microwave', 'state': false}]}
//   ];
//
//   // Function to toggle device state (ON/OFF) when switch is tapped
//   void toggleDeviceState(int roomIndex, int deviceIndex) {
//     setState(() {
//       rooms[roomIndex]['devices'][deviceIndex]['state'] =!rooms[roomIndex]['devices'][deviceIndex]['state'];
//     });
//   }
//
//   // void _onItemTapped(int index) {
//   //   setState(() {
//   //     _selectedIndex = index;
//   //   });
//   // }
//
//   @override
//   Widget build(BuildContext context) {
//     // return Scaffold(
//     //   appBar: AppBar(title: Text('Home Sync')),
//     //   body: _pages[_selectedIndex], // Display selected page
//     //   bottomNavigationBar: BottomNavigationBar(
//     //     currentIndex: _selectedIndex,
//     //     onTap: _onItemTapped,
//     //     selectedItemColor: Colors.blue, // Highlight active tab
//     //     unselectedItemColor: Colors.grey,
//     //     items: [
//     //       BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
//     //       BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Automation'),
//     //       BottomNavigationBarItem(icon: Icon(Icons.lock), label: 'Security'),
//     //     ],
//     //   ),
//     // );
//       return Scaffold(
//         appBar: AppBar(title: Text('Home Sync')),
//         drawer: Drawer(
//           child: ListView(
//             padding: EdgeInsets.zero,
//             children: [
//               DrawerHeader(
//                 decoration: BoxDecoration(color: Colors.blue),
//                 child: Text('Settings Menu', style: TextStyle(color: Colors.white, fontSize: 20)),
//               ),
//               ListTile(
//                 leading: Icon(Icons.settings),
//                 title: Text('General Settings'),
//                 onTap: () {},
//               ),
//               ListTile(
//                 leading: Icon(Icons.info),
//                 title: Text('About'),
//                 onTap: () {},
//               ),
//             ],
//           ),
//         ),
//         body: GridView.builder(  //to ensure grid view
//           padding: EdgeInsets.all(16),
//           itemCount: rooms.length,
//           gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//             crossAxisCount: 2, // Two rooms per row
//             crossAxisSpacing: 12,
//             mainAxisSpacing: 12,
//             childAspectRatio: 1.1,
//           ),
//           itemBuilder: (context, roomIndex) {
//             return Card(
//               shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Text(rooms[roomIndex]['name'], style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
//                   SizedBox(height: 8),
//                   Column(
//                     children: List.generate(rooms[roomIndex]['devices'].length, (deviceIndex) {
//                       return Row(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           Text(rooms[roomIndex]['devices'][deviceIndex]['name']),
//                           Switch(
//                             value: rooms[roomIndex]['devices'][deviceIndex]['state'],
//                             onChanged: (value) => toggleDeviceState(roomIndex, deviceIndex),
//                           ),
//                         ],
//                       );
//                     }),
//                   ),
//                 ],
//               ),
//             );
//           },
//         ),
//         floatingActionButton: FloatingActionButton(
//           onPressed: () {
//             // Add room/device functionality
//           },
//           child: Icon(Icons.add),
//         ),
//         bottomNavigationBar: BottomNavigationBar(
//           currentIndex: 0,
//           onTap: (index) {},
//           selectedItemColor: Colors.blue,
//           unselectedItemColor: Colors.grey,
//           items: [
//             BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
//             BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Automation'),
//             BottomNavigationBarItem(icon: Icon(Icons.lock), label: 'Security'),
//           ],
//         ),
//       );
//   }
// }
import 'package:flutter/material.dart';
import '../../features/room_control/room_list.dart';
import '../widgets/device_card.dart';
import '../../features/room_control/room_details.dart';
import '../widgets/settings.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isDarkTheme = false;

  void toggleTheme(bool value) {
    setState(() {
      isDarkTheme = value;
    });
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
        body: GridView.builder(
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
                    builder: (context) => RoomDetailsScreen(roomName: rooms[roomIndex]['name']),
                  ),
                );
              },
              child: Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      rooms[roomIndex]['name'],
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.black,
                      ),
                    ),
                    SizedBox(height: 8),
                    Expanded(
                      child: ListView(
                        shrinkWrap: true,
                        children: List.generate(
                            rooms[roomIndex]['devices'].length, (deviceIndex) {
                          return DeviceCard(
                            deviceName:
                            rooms[roomIndex]['devices'][deviceIndex]['name'],
                            deviceIcon:
                            rooms[roomIndex]['devices'][deviceIndex]['icon'],
                            initialState:
                            rooms[roomIndex]['devices'][deviceIndex]['state'],
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
          currentIndex: 0,
          onTap: (index) {},
          selectedItemColor: Colors.blue,
          unselectedItemColor: Colors.grey,
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Automation'),
            BottomNavigationBarItem(icon: Icon(Icons.lock), label: 'Security'),
          ],
        ),
      ),
    );
  }
}

