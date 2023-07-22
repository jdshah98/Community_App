import 'package:community_app/app/consumer/app_state.dart';
import 'package:community_app/app/screens/launcher/splash.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'app/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AppState(),
      child: MaterialApp(
        title: 'Saurashtra Jain Yuvak Mandal App',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.deepPurpleAccent,
          ),
          useMaterial3: true,
        ),
        home: const SplashScreen(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}

        // home: FutureBuilder(
        //   future: Firebase.initializeApp(
        //     options: DefaultFirebaseOptions.currentPlatform,
        //   ),
        //   builder: (context, snapshot) {
        //     if (snapshot.connectionState == ConnectionState.done) {
        //       return const SplashScreen();
        //     }
        //     return const Scaffold(
        //       backgroundColor: Colors.deepPurpleAccent,
        //       body: Center(
        //         child: CircularProgressIndicator(
        //           color: Colors.white,
        //         ),
        //       ),
        //     );
        //   },
        // ),
