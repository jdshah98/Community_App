import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:community_app/app/model/committee_member.dart';

class CommonRepository {
  static final CollectionReference _commonRef =
      FirebaseFirestore.instance.collection("common");

  static Future<List<CommitteeMember>> getAllCommitteeMembers() async {
    final snapshot = await _commonRef
        .doc("Committee")
        .get(const GetOptions(source: Source.cache));
    if (!snapshot.exists) {
      return [];
    }
    return ((snapshot.data() as Map<String, dynamic>)['info'] as List<dynamic>)
        .map((e) => CommitteeMember.fromMap(e as Map<String, dynamic>))
        .toList();
  }
}
