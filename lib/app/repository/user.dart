import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:community_app/app/exceptions/data_not_found.dart';
import 'package:community_app/app/model/user.dart';
import 'package:flutter/widgets.dart';

class UserRepository {
  static final CollectionReference _usersRef =
      FirebaseFirestore.instance.collection("users");

  static Future<User> getUser(String contact) async {
    final snapshot = await _usersRef.doc(contact).get();
    if (!snapshot.exists) {
      throw DataNotFound("Member Not Found!!");
    }
    debugPrint(snapshot.data().toString());
    return User.fromMap(snapshot.data() as Map<String, dynamic>);
  }

  static Future<void> updatePassword(String contact, String password) async {
    await _usersRef
        .doc(contact)
        .set({'Password': password}, SetOptions(merge: true));
  }
}
