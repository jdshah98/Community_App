import 'package:community_app/app/repository/user.dart';
import 'package:flutter/material.dart';

class AddressBook extends StatefulWidget {
  const AddressBook({super.key});

  @override
  State<AddressBook> createState() => _AddressBookState();
}

class _AddressBookState extends State<AddressBook> {
  final TextEditingController _mobileController = TextEditingController();

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
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
            child: TextField(
              keyboardType: TextInputType.phone,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                label: Text('Mobile'),
                hintText: 'Enter Mobile',
              ),
              controller: _mobileController,
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepPurpleAccent,
                foregroundColor: Colors.white,
              ),
              onPressed: () => _searchAddress(),
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 32, vertical: 8),
                child: Text("Search"),
              ),
            ),
          ),
        ],
      ),
    );
  }

  _searchAddress() async {
    final mobileNumber = _mobileController.value.text.trim();

    if (mobileNumber.isEmpty) {
      return;
    }

    final searchedUser = await UserRepository.getUser(mobileNumber);
    debugPrint(searchedUser.toString());
  }
}
