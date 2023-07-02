import 'package:flutter/material.dart';

class MatrimonyScreen extends StatelessWidget {
  const MatrimonyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Matrimony'),
        backgroundColor: Colors.deepPurpleAccent,
        foregroundColor: Colors.white,
      ),
      body: const Center(
        child: Column(
          children: [Text("Matrimonial!!")],
        ),
      ),
    );
  }
}
