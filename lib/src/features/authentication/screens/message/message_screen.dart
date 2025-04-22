import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pawlse/src/common_widget/buttons/chat_bubble.dart';
import 'package:pawlse/src/features/authentication/screens/dashboard/chat/chat_service.dart';
import 'package:intl/intl.dart';

class MessageScreen extends StatefulWidget {
  final String receiverUserEmail;
  final String receiverUserId;
  const MessageScreen(
      {super.key,
      required this.receiverUserEmail,
      required this.receiverUserId});

  @override
  State<MessageScreen> createState() => _MessageScreenState();
}

class _MessageScreenState extends State<MessageScreen> {
  final TextEditingController _messageController = TextEditingController();
  final ChatService _chatService = ChatService();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> sendMessage() async {
    if (_messageController.text.isNotEmpty) {
      await _chatService.sendMessage(
          widget.receiverUserId, _messageController.text);
      _messageController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.receiverUserEmail),
      ),
      body: Column(
        children: [
          Expanded(child: _buildMessageList()),
          _buildMessageInput(),
          const SizedBox(
            height: 25,
          )
        ],
      ),
    );
  }

  Widget _buildMessageInput() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Row(
        children: [
          Expanded(
              child: TextFormField(
            controller: _messageController,
            decoration: const InputDecoration(
              hintText: "Enter Message",
            ),
          )),
          IconButton(
              onPressed: sendMessage,
              icon: const Icon(
                Icons.arrow_upward,
                size: 40,
              ))
        ],
      ),
    );
  }

  Widget _buildMessageList() {
    return StreamBuilder(
        stream: _chatService.getMessages(
            widget.receiverUserId, _auth.currentUser!.uid),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text("Error ${snapshot.error}");
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Text("Loading...");
          }
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(
              child: Text(
                "Say something to your client",
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
            );
          }
          return ListView(
            children: snapshot.data!.docs
                .map((document) => _buildMessageItem(document))
                .toList(),
          );
        });
  }

  Widget _buildMessageItem(DocumentSnapshot document) {
    Map<String, dynamic> data = document.data() as Map<String, dynamic>;

    bool isCurrentUser = data["senderId"] == _auth.currentUser!.uid;

    // Define colors based on sender
    Color bubbleColor = isCurrentUser ? const Color(0xFFFFE0B2) : Colors.brown;
    Color textColor = isCurrentUser ? Colors.black : Colors.white;
    CrossAxisAlignment crossAxisAlignment =
        isCurrentUser ? CrossAxisAlignment.end : CrossAxisAlignment.start;

    // Extract timestamp and format time
    Timestamp timestamp = data["timestamp"] ?? Timestamp.now();
    String formattedTime = DateFormat('hh:mm a').format(timestamp.toDate());

    return Container(
      alignment: isCurrentUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          crossAxisAlignment: crossAxisAlignment,
          children: [
            Text(
              data["senderEmail"],
              style: const TextStyle(fontSize: 12, color: Colors.grey),
            ),
            const SizedBox(height: 4),
            ChatBubble(
              message: data["message"],
              color: bubbleColor,
              textColor: textColor,
              formattedTime: formattedTime,
              crossAxisAlignment: crossAxisAlignment,
            ),
            const SizedBox(height: 4),
          ],
        ),
      ),
    );
  }

  // Widget _buildMessageItem(DocumentSnapshot document) {
  //   Map<String, dynamic> data = document.data() as Map<String, dynamic>;

  //   var alignment = (data["senderId"] == _auth.currentUser!.uid)
  //       ? Alignment.centerRight
  //       : Alignment.centerLeft;

  //   return Container(
  //     alignment: alignment,
  //     child: Padding(
  //       padding: const EdgeInsets.all(8.0),
  //       child: Padding(
  //         padding: const EdgeInsets.symmetric(horizontal: 10),
  //         child: Column(
  //             crossAxisAlignment: (data["senderId"] == _auth.currentUser!.uid)
  //                 ? CrossAxisAlignment.end
  //                 : CrossAxisAlignment.start,
  //             mainAxisAlignment: (data["senderId"] == _auth.currentUser!.uid)
  //                 ? MainAxisAlignment.end
  //                 : MainAxisAlignment.start,
  //             children: [
  //               Text(data["senderEmail"]),
  //               const SizedBox(
  //                 height: 4,
  //               ),
  //               ChatBubble(
  //                 message: data["message"],
  //                 color: (data["senderId"] == _auth.currentUser!.uid)
  //                     ? const Color(0xFFFFE0B2)
  //                     : Colors.brown,
  //                 textColor: (data["senderId"] == _auth.currentUser!.uid)
  //                     ? Colors.black
  //                     : Colors.white,
  //               ),
  //             ]),
  //       ),
  //     ),
  //   );
  // }
}
