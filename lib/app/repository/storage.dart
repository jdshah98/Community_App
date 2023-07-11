import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class CloudStorage {
  static final Reference _storageRef = FirebaseStorage.instance.ref();

  static fetchAndSaveToLocal(String path, String localPath) async {
    File outputFile = File(localPath);
    await _storageRef.child(path).writeToFile(outputFile);
    debugPrint("Done");
  }

  static upload(String path, String localPath) async {
    File inputFile = File(localPath);
    await _storageRef.child(path).putFile(inputFile);
    debugPrint("Done");
  }
}
