import 'dart:async';

import 'package:community_app/app/constants/images.dart';
import 'package:community_app/app/repository/utils.dart';
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
  bool isInternetConnected = true;

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
    checkConnectivity();
  }

  checkConnectivity() async {
    if (!isInternetConnected) {
      setState(() => isInternetConnected = true);
    }
    final isConnected = await Utils.isInternetConnected();
    if (isConnected) {
      Timer(
        const Duration(seconds: 3),
        () => Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => ViewAddScreen(
                isLoggedIn ? const DashboardScreen() : const LoginScreen()),
          ),
        ),
      );
    } else {
      debugPrint('not connected');
      Future.delayed(
        const Duration(seconds: 2),
        () => setState(() => isInternetConnected = false),
      );
    }
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
      body: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.7,
            child: Image(
              image: const AssetImage(roundedLogo),
              width: width,
              height: height,
            ),
          ),
          Center(
            child: isInternetConnected
                ? const CircularProgressIndicator(
                    color: Colors.white,
                  )
                : Column(
                    children: [
                      const Text(
                        "OOPS!",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 24,
                          color: Colors.white,
                        ),
                      ),
                      const Text(
                        "NO INTERNET",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 24,
                          color: Colors.white,
                        ),
                      ),
                      const Text(
                        "Please check your network connection.",
                        style: TextStyle(
                          fontWeight: FontWeight.normal,
                          fontSize: 14,
                          color: Colors.white,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 8),
                        child: ElevatedButton(
                          onPressed: checkConnectivity,
                          child: const Text("TRY AGAIN"),
                        ),
                      ),
                    ],
                  ),
          ),
        ],
      ),
      backgroundColor: Colors.deepPurpleAccent,
    );
  }
}
