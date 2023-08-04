import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:community_app/app/model/committee_member.dart';
import 'package:community_app/app/shared_pref.dart';
import 'package:flutter/material.dart';

class CommonRepository {
  static final CollectionReference _commonRef =
      FirebaseFirestore.instance.collection("common");

  static Future<List<CommitteeMember>> getAllCommitteeMembers() async {
    bool cacheAvailable =
        await SharedPref.isCacheAvailable(SharedPref.cachedCommittee);
    debugPrint("Cache available: $cacheAvailable");
    var snapshot = await _commonRef
        .doc("Committee")
        .get(GetOptions(source: cacheAvailable ? Source.cache : Source.server));
    if (!snapshot.exists) {
      return [];
    }
    await SharedPref.setCacheAvailable(SharedPref.cachedCommittee, true);
    return ((snapshot.data() as Map<String, dynamic>)['info'] as List<dynamic>)
        .map((e) => CommitteeMember.fromMap(e as Map<String, dynamic>))
        .toList();
  }
}
