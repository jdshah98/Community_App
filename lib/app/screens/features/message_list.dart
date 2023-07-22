import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:community_app/app/consumer/app_state.dart';
import 'package:community_app/app/model/message.dart';
import 'package:community_app/app/repository/message.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MessageListScreen extends StatefulWidget {
  const MessageListScreen({super.key});

  @override
  State<MessageListScreen> createState() => _MessageListScreenState();
}

class _MessageListScreenState extends State<MessageListScreen> {
  final TextEditingController _messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Consumer<AppState>(
      builder: (context, state, child) {
        String _name = state.user.members.entries.first.value.name;
        debugPrint(_name);
        return Scaffold(
          appBar: AppBar(
            title: const Text(
              "Messages",
              style: TextStyle(letterSpacing: 0.1),
            ),
            backgroundColor: Colors.deepPurpleAccent,
            foregroundColor: Colors.white,
          ),
          body: Stack(
            children: <Widget>[
              StreamBuilder<QuerySnapshot>(
                stream: MessageRepository.getMessageRef()
                    .orderBy("Timestamp")
                    .get(const GetOptions(source: Source.cache))
                    .asStream(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return const Text('Something went wrong');
                  }

                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Text('Loading');
                  }

                  List<Message> messages = snapshot.data!.docs
                      .map((doc) =>
                          Message.fromMap(doc.data()! as Map<String, dynamic>))
                      .toList();

                  debugPrint("Building..");

                  return ListView.builder(
                    itemCount: messages.length,
                    itemBuilder: (context, index) {
                      return Container(
                        padding: const EdgeInsets.only(
                          left: 8,
                          right: 8,
                          top: 8,
                          bottom: 8,
                        ),
                        child: Align(
                          alignment: (messages[index].sender == _name
                              ? Alignment.topRight
                              : Alignment.topLeft),
                          child: Container(
                            constraints: BoxConstraints(
                              maxWidth: MediaQuery.of(context).size.width * 0.8,
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: (messages[index].sender == _name
                                  ? Colors.indigo.shade100
                                  : Colors.grey.shade200),
                            ),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 8),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: messages[index].sender == _name
                                  ? [
                                      Text(
                                        messages[index].content,
                                        style: const TextStyle(fontSize: 14),
                                        softWrap: true,
                                        textAlign: TextAlign.right,
                                      ),
                                    ]
                                  : [
                                      Text(
                                        messages[index].sender,
                                        style: const TextStyle(
                                          fontSize: 12,
                                          color: Colors.deepPurpleAccent,
                                        ),
                                      ),
                                      Text(
                                        messages[index].content,
                                        style: const TextStyle(fontSize: 14),
                                        softWrap: true,
                                      ),
                                    ],
                            ),
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
              Align(
                alignment: Alignment.bottomLeft,
                child: Container(
                  padding: const EdgeInsets.only(left: 8, bottom: 8, top: 8),
                  height: 72,
                  width: double.infinity,
                  color: Colors.white,
                  child: Row(
                    children: <Widget>[
                      GestureDetector(
                        onTap: () {},
                        child: Container(
                          height: 36,
                          width: 36,
                          decoration: BoxDecoration(
                            color: Colors.deepPurpleAccent,
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: const Icon(
                            Icons.add,
                            color: Colors.white,
                            size: 28,
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 15,
                      ),
                      Expanded(
                        child: TextField(
                          decoration: const InputDecoration(
                            hintText: "Write message...",
                            hintStyle: TextStyle(color: Colors.black54),
                            border: InputBorder.none,
                          ),
                          controller: _messageController,
                        ),
                      ),
                      const SizedBox(
                        width: 15,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 8),
                        child: FloatingActionButton(
                          onPressed: () => _sendMessage(_name),
                          shape: const CircleBorder(),
                          backgroundColor: Colors.deepPurpleAccent,
                          elevation: 4,
                          child: const Icon(
                            Icons.send,
                            color: Colors.white,
                            size: 24,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  _sendMessage(String sender) async {
    final messageText = _messageController.value.text.trim();

    if (messageText.isEmpty) {
      return;
    }

    final newMessage = Message(
        content: messageText, sender: sender, timestamp: Timestamp.now());

    _messageController.text = "";
    await MessageRepository.createMessage(newMessage);
  }
}
