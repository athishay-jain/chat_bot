import 'dart:async';

import 'package:chat_bot/Screens/home_screen.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(Duration(seconds: 4), () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomeScreen(),)),);
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Color(0xfffefaf2),
      body: Center(
        child: FadeInImage(
          placeholder: AssetImage("assets/images/black.png"),
          image: AssetImage("assets/images/appicon_vertical.png"),
          fadeInDuration: Duration(seconds: 2),
        ),
      ),
    );
  }
}
