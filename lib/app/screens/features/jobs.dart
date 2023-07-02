import 'package:flutter/material.dart';

class JobScreen extends StatelessWidget {
  const JobScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Jobs'),
        backgroundColor: Colors.deepPurpleAccent,
        foregroundColor: Colors.white,
      ),
      body: const Center(
        child: Column(
          children: [Text("Job Portal!!")],
        ),
      ),
    );
  }
}
