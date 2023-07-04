import 'package:community_app/app/components/dashboard_drawer.dart';
import 'package:community_app/app/model/user.dart';
import 'package:community_app/app/shared_pref.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  bool isLoaded = false;
  User user = User.empty();
  String path = "";
  String imagePath = "";

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () async {
      path = (await getApplicationDocumentsDirectory()).path;
      user = User.fromMap(
          (await SharedPref.getLoggedUser()) as Map<String, dynamic>);
      imagePath = "$path/${user.members[0].profilePic}";

      setState(() => isLoaded = true);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        backgroundColor: Colors.deepPurpleAccent,
        foregroundColor: Colors.white,
      ),
      body: isLoaded
          ? const Center(
              child: Text("Welcome"),
            )
          : const CircularProgressIndicator(),
      drawer: DashboardDrawer(user, path, isLoaded),
    );
  }
}
