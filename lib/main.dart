import 'package:community_app/app/screens/launcher/splash.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'app/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final Future<FirebaseApp> _initialiation =
      Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Saurashtra Jain Yuvak Mandal App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurpleAccent,
        ),
        useMaterial3: true,
      ),
      home: FutureBuilder(
        future: _initialiation,
        builder: (context, snapshot) {
          return const SplashScreen();
        },
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}
