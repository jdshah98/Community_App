import 'dart:async';

import 'package:flutter/material.dart';

class ViewAddScreen extends StatefulWidget {
  const ViewAddScreen(this.redirectWidget, {super.key});

  final Widget redirectWidget;

  @override
  State<ViewAddScreen> createState() => _ViewAddScreenState();
}

class _ViewAddScreenState extends State<ViewAddScreen> {
  final String addBannerImageUrl =
      "https://firebasestorage.googleapis.com/v0/b/community-app-c1b2b.appspot.com/o/add_banner%2Fadd_banner.png?alt=media&token=02be13f1-ed02-4b4b-8561-9f7468dd92ba";

  bool _showCloseButton = false;

  @override
  void initState() {
    super.initState();
    Future.delayed(
      const Duration(seconds: 3),
      () => setState(() => _showCloseButton = true),
    );
  }

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
              image: NetworkImage(addBannerImageUrl),
              width: width,
              height: height,
              fit: BoxFit.contain,
            ),
          ),
        ],
      ),
      floatingActionButton: Visibility(
        visible: _showCloseButton,
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: FloatingActionButton(
            onPressed: () => Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => widget.redirectWidget)),
            tooltip: 'Close',
            child: const Icon(Icons.close),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
    );
  }
}
