import 'package:flutter/material.dart';

class MessageListScreen extends StatefulWidget {
  const MessageListScreen({super.key});

  @override
  State<MessageListScreen> createState() => _MessageListScreenState();
}

class _MessageListScreenState extends State<MessageListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Messages",
          style: TextStyle(letterSpacing: 0.1),
        ),
        backgroundColor: Colors.deepPurpleAccent,
        foregroundColor: Colors.white,
      ),
      body: const Center(child: Text("Messages")),
    );
  }
}
