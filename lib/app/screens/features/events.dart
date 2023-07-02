import 'package:flutter/material.dart';

class EventScreen extends StatelessWidget {
  const EventScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Events'),
        backgroundColor: Colors.deepPurpleAccent,
        foregroundColor: Colors.white,
      ),
      body: const Center(
        child: Column(
          children: [Text("No Events!!")],
        ),
      ),
    );
  }
}
