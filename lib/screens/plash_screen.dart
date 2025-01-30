import 'dart:async';

import 'package:contactapp/screens/home_sceen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Timer(Duration(seconds: 2), () {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => HomeScreen()));
    });
    super.initState();
  }

  @override
  Widget build(context) {
    return Scaffold(
      body: Container(
        color: Colors.blueAccent,
        child: Center(
          child: Text("Contact",style: TextStyle(fontSize: 50),).animate().custom(
              duration: 300.ms,
              builder: (context, value, child) => Container(
                color: Color.lerp(Colors.red, Colors.blue, value),
                padding: EdgeInsets.all(8),
                child: child, // child is the Text widget being animated
              )
          ),
        ),
      ),
    );
  }
}
