import 'package:cloud_firestore/cloud_firestore.dart';

class Message {
  final String content;
  final String sender;
  final Timestamp timestamp;

  const Message(
      {required this.content, required this.sender, required this.timestamp});

  Message.fromMap(Map<String, dynamic> map)
      : content = map["Content"],
        sender = map["Sender"],
        timestamp = map["Timestamp"];

  Map<String, dynamic> toMap() {
    return {
      'Content': content,
      'Sender': sender,
      'Timestamp': timestamp,
    };
  }

  @override
  String toString() {
    return "Message{content: $content, sender: $sender, timestamp: $timestamp}";
  }
}
