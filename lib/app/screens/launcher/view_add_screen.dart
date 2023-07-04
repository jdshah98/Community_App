import 'package:flutter/material.dart';

class ViewAddScreen extends StatelessWidget {
  const ViewAddScreen(this.redirectWidget, {super.key});

  final Widget redirectWidget;

  static const String _addBannerImageUrl =
      "https://firebasestorage.googleapis.com/v0/b/community-app-c1b2b.appspot.com/o/add_banner%2Fadd_banner.png?alt=media&token=02be13f1-ed02-4b4b-8561-9f7468dd92ba";

  @override
  Widget build(BuildContext context) {
    final double width;
    final double height;
    if (MediaQuery.of(context).size.aspectRatio <= 1) {
      width = MediaQuery.of(context).size.width * 0.9;
      height = MediaQuery.of(context).size.height *
          MediaQuery.of(context).size.aspectRatio;
    } else {
      width = MediaQuery.of(context).size.height;
      height = MediaQuery.of(context).size.height * 0.9;
    }

    return Scaffold(
      body: Stack(
        children: [
          const Center(
            child: Text(
              "Loading...",
              style: TextStyle(color: Colors.deepPurpleAccent, fontSize: 28),
            ),
          ),
          Center(
            child: Image(
              image: const NetworkImage(_addBannerImageUrl),
              width: width,
              height: height,
              fit: BoxFit.contain,
            ),
          ),
        ],
      ),
      floatingActionButton: FutureBuilder(
        future: Future.delayed(const Duration(seconds: 3)),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return Padding(
              padding: const EdgeInsets.all(8),
              child: FloatingActionButton(
                onPressed: () => Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => redirectWidget),
                ),
                tooltip: 'Close',
                child: const Icon(Icons.close),
              ),
            );
          }
          return const SizedBox.shrink();
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
    );
  }
}
