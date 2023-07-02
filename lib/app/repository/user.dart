import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:community_app/app/exceptions/data_not_found.dart';
import 'package:community_app/app/model/user.dart';

class UserRepository {
  static final CollectionReference _usersRef =
      FirebaseFirestore.instance.collection("users");

  static Future<User> getUser(String contact) async {
    final snapshot = await _usersRef.doc(contact).get();
    if (!snapshot.exists) {
      throw DataNotFound("Member Not Found!!");
    }
    return User.fromMap(snapshot.data() as Map<String, dynamic>);
  }
}
