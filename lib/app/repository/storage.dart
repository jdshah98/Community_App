import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class CloudStorage {
  static final Reference _storageRef = FirebaseStorage.instance.ref();

  static fetchAndSaveToLocal(String path, String localPath) {
    File outputFile = File(localPath);
    _storageRef.child(path).writeToFile(outputFile);
    debugPrint("Done");
  }
}
