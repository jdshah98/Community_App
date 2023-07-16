import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:community_app/app/model/message.dart';

class MessageRepository {
  static final CollectionReference _messageRef =
      FirebaseFirestore.instance.collection("messages");

  // static Future<List<Message>> getMessages() async {
  static CollectionReference getMessageRef() {
    // final snapshot = await _messageRef.get();
    // List<Message> messages = List.empty();
    // for (var doc in snapshot.docs) {
    //   if (doc.exists) {
    //     final message = Message.fromMap(doc.data() as Map<String, dynamic>);
    //     messages.add(message);
    //   }
    // }
    // return messages;
    return _messageRef;
  }

  static Future<void> createMessage(Message message) async {
    await _messageRef.add(message.toMap());
  }

  static Future<void> updateMessage(String contact, Object data) async {
    await _messageRef.doc(contact).set(data, SetOptions(merge: true));
  }
}
