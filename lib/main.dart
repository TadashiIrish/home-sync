import 'package:flutter/material.dart';
import 'presentation/home/loading_screen.dart';
import 'presentation/home/home_screen.dart';


// void main() {
//   runApp(const HomeSyncApp());
// }

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const HomeSyncApp());
}

class HomeSyncApp extends StatelessWidget {
  const HomeSyncApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Home Sync',
      theme: ThemeData.dark(), // You can customize the theme here
      initialRoute: '/', // Start with the loading screen
      routes: {
        '/': (context) => LoadingScreen(), // Inserted Loading Screen
        '/home': (context) => HomeScreen(), // Home Page after loading
      },
    );
  }
}