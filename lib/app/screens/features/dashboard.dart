import 'package:community_app/app/components/dashboard_drawer.dart';
import 'package:community_app/app/consumer/app_state.dart';
import 'package:community_app/app/model/user.dart';
import 'package:community_app/app/shared_pref.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  bool isLoaded = false;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () async {
      var path = (await getApplicationDocumentsDirectory()).path;
      var user = User.fromMap(
          (await SharedPref.getLoggedUser()) as Map<String, dynamic>);
      debugPrint(user.toString());
      if (mounted) {
        Provider.of<AppState>(context, listen: false).setUser(user);
        Provider.of<AppState>(context, listen: false).setLocalPath(path);
        setState(() => isLoaded = true);
      }
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
      body: Center(
        child: isLoaded
            ? const Text("Welcome")
            : const CircularProgressIndicator(),
      ),
      // drawer: DashboardDrawer(user, path, isLoaded),
      drawer: DashboardDrawer(isLoaded),
    );
  }
}
