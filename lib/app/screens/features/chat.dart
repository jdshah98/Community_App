import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:community_app/app/consumer/app_state.dart';
import 'package:community_app/app/model/message.dart';
import 'package:community_app/app/repository/message.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _messageController = TextEditingController();

  final MessageStorage _messageStorage = MessageStorage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Messages",
          style: TextStyle(letterSpacing: 0.1),
        ),
        backgroundColor: Colors.deepPurpleAccent,
        foregroundColor: Colors.white,
      ),
      body: LayoutBuilder(
        builder: (context, constraint) {
          return Consumer<AppState>(
            builder: (context, state, child) {
              final name = state.user.members.entries.first.value.name;
              return ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraint.maxHeight),
                child: IntrinsicHeight(
                  child: Column(
                    children: <Widget>[
                      Expanded(
                        child: ListenableBuilder(
                          listenable: _messageStorage,
                          builder: (context, child) {
                            List<Message> messages = _messageStorage.messages;
                            return ListView.builder(
                              reverse: true,
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
                                    alignment: (messages[index].sender == name
                                        ? Alignment.topRight
                                        : Alignment.topLeft),
                                    child: Container(
                                      constraints: BoxConstraints(
                                        maxWidth:
                                            MediaQuery.of(context).size.width *
                                                0.8,
                                      ),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                        color: (messages[index].sender == name
                                            ? Colors.indigo.shade100
                                            : Colors.grey.shade200),
                                      ),
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 16,
                                        vertical: 8,
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: messages[index].sender == name
                                            ? [
                                                Text(
                                                  messages[index].content,
                                                  style: const TextStyle(
                                                      fontSize: 14),
                                                  softWrap: true,
                                                  textAlign: TextAlign.right,
                                                ),
                                              ]
                                            : [
                                                Text(
                                                  messages[index].sender,
                                                  style: const TextStyle(
                                                    fontSize: 12,
                                                    color:
                                                        Colors.deepPurpleAccent,
                                                  ),
                                                ),
                                                Text(
                                                  messages[index].content,
                                                  style: const TextStyle(
                                                      fontSize: 14),
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
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 8),
                        padding:
                            const EdgeInsets.only(left: 8, bottom: 8, top: 8),
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
                                onPressed: () => _sendMessage(name),
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
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
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
    _messageStorage.updated();
  }
}

class MessageStorage with ChangeNotifier {
  List<Message> messages = List.empty();

  MessageStorage() {
    _fetchMessages();
  }

  void _fetchMessages() async {
    var snapshot = await MessageRepository.getMessageRef()
        .orderBy("Timestamp", descending: true)
        .get(const GetOptions(source: Source.cache));

    messages = snapshot.docs
        .map((doc) => Message.fromMap(doc.data()! as Map<String, dynamic>))
        .toList();
  }

  void updated() {
    MessageRepository.getMessageRef()
        .orderBy("Timestamp", descending: true)
        .get(const GetOptions(source: Source.cache))
        .then((snapshot) {
      messages = snapshot.docs
          .map((doc) => Message.fromMap(doc.data()! as Map<String, dynamic>))
          .toList();
      notifyListeners();
    });
  }
}
