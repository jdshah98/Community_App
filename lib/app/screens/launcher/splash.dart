import 'dart:async';

import 'package:community_app/app/constants/images.dart';
import 'package:community_app/app/screens/auth/login.dart';
import 'package:community_app/app/screens/features/dashboard.dart';
import 'package:community_app/app/screens/launcher/view_add_screen.dart';
import 'package:community_app/app/shared_pref.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool isLoggedIn = false;

  void fetchLoggedStatus() async {
    var loggedStatus = await SharedPref.getLoggedIn();
    debugPrint(loggedStatus.toString());
    setState(() {
      isLoggedIn = loggedStatus;
    });
  }

  @override
  void initState() {
    super.initState();
    fetchLoggedStatus();
    Timer(
      const Duration(seconds: 5),
      () => Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => ViewAddScreen(
              isLoggedIn ? const DashboardScreen() : const LoginScreen()),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final double width;
    final double height;
    if (MediaQuery.of(context).size.aspectRatio <= 1) {
      width = MediaQuery.of(context).size.width * 0.6;
      height = width;
    } else {
      height = MediaQuery.of(context).size.height * 0.6;
      width = height;
    }

    return Scaffold(
      body: Center(
        child: Image(
          image: const AssetImage(roundedLogo),
          width: width,
          height: height,
        ),
      ),
      backgroundColor: Colors.deepPurpleAccent,
    );
  }
}
