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
  bool isLoading = true;
  late User user;
  late String path;
  late String imagePath;

  void fetchData() async {
    path = (await getApplicationDocumentsDirectory()).path;
    user = User.fromMap(
        (await SharedPref.getLoggedUser()) as Map<String, dynamic>);
    imagePath = "$path/${user.members![0].profilePic}";
    debugPrint(imagePath);
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        backgroundColor: Colors.deepPurpleAccent,
        foregroundColor: Colors.white,
      ),
      body: !isLoading
          ? const Center(
              child: Text("Welcome"),
            )
          : const CircularProgressIndicator(),
      drawer: !isLoading
          ? DashboardDrawer(user, path)
          : const DashboardDrawer.nullDrawer(),
    );
  }
}
