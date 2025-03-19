import 'package:flutter/material.dart';

class LoadingScreen extends StatefulWidget{
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState() {
    super.initState();
    _initializeApp();
  }

  Future<void> _initializeApp() async {
    await Future.delayed(Duration(seconds: 3)); // Simulating app setup
    Navigator.pushReplacementNamed(context, '/home'); // Navigate to Home
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.black, // Keep background dark for glow effect
      body: Center(
        child: Image.asset(
          'images/H S.gif',
          fit: BoxFit.fill, // Ensures full-screen display
          width: double.infinity,
          height: double.infinity,
        ),
      ),
    );
  }
}





