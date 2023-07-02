import 'package:flutter/material.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Forgot Password'),
        backgroundColor: Colors.deepPurpleAccent,
        foregroundColor: Colors.white,
      ),
      body: const Center(
        child: Column(
          children: [Text("Forgot Password")],
        ),
      ),
    );
  }
}
