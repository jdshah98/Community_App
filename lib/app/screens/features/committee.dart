import 'package:community_app/app/constants/images.dart';
import 'package:flutter/material.dart';

class Committee extends StatelessWidget {
  const Committee({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Committee Info",
          style: TextStyle(letterSpacing: 0.1),
        ),
        backgroundColor: Colors.deepPurpleAccent,
        foregroundColor: Colors.white,
      ),
      body: const SingleChildScrollView(
        child: Column(
          children: [
            Card(
              elevation: 5,
              margin: EdgeInsets.all(16),
              surfaceTintColor: Colors.white,
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(right: 16),
                      child: Image(
                        image: AssetImage(avatar),
                        width: 100,
                        height: 100,
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Prakashbhai M Shah",
                        ),
                        Text("Pramukh"),
                        Text("Trustee Address "),
                        Text("Trustee Contact No"),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
