import 'package:flutter/material.dart';

class AddressBook extends StatelessWidget {
  const AddressBook({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Address Book",
          style: TextStyle(letterSpacing: 0.1),
        ),
        backgroundColor: Colors.deepPurpleAccent,
        foregroundColor: Colors.white,
      ),
      body: const Center(child: Text("Address Book")),
    );
  }
}
