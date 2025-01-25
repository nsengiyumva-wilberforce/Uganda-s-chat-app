import 'package:chat_app/components/chat_bubble.dart';
import 'package:chat_app/components/my_text_field.dart';
import 'package:chat_app/services/chat/chat_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChatPage extends StatefulWidget {
  final String receiverUserEmail;
  final String receiverUserID;
  const ChatPage(
      {super.key,
      required this.receiverUserEmail,
      required this.receiverUserID});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController _messageController = TextEditingController();
  final ChatService _chatService = ChatService();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  void sendMessage() async {
    if (_messageController.text.isNotEmpty) {
      await _chatService.sendMessage(
          widget.receiverUserID, _messageController.text);
      _messageController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.receiverUserEmail)),
      body: Column(
        children: [
          Expanded(child: _buildMessageList()),

          //user input
          _buildMessageInput(),
          const SizedBox(height: 25,)
        ],
      ),
    );
  }

  //build message list
  Widget _buildMessageList() {
    return StreamBuilder<QuerySnapshot>(
      stream: _chatService.getMessages(
          _firebaseAuth.currentUser!.uid, widget.receiverUserID),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Text('error');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text('loading');
        }

        return ListView(
          children: snapshot.data!.docs
              .map<Widget>((doc) => _buildMessageItem(doc))
              .toList(),
        );
      },
    );
  }

  //build message item
  Widget _buildMessageItem(DocumentSnapshot document) {
    Map<String, dynamic> data = document.data()! as Map<String, dynamic>;

    //align message to the right if it is sent by the current user else align to the left
    Alignment alignment = (data['senderId'] == _firebaseAuth.currentUser!.uid)
        ? Alignment.centerRight
        : Alignment.centerLeft;

    return Container(
        alignment: alignment,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: (data['senderId'] == _firebaseAuth.currentUser!.uid)? CrossAxisAlignment.end: CrossAxisAlignment.start,
            mainAxisAlignment: (data['senderId'] == _firebaseAuth.currentUser!.uid)? MainAxisAlignment.end: MainAxisAlignment.start,
            children: [
              Text(data['senderEmail']),
              const SizedBox(height: 5,),
             ChatBubble(message: data['message'])
            ],
          ),
        ));
  }

  //build message input
  Widget _buildMessageInput() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: Row(
        children: [
          //text field
          Expanded(
            child: MyTextField(
                controller: _messageController,
                hintText: 'Enter message',
                obscureText: false),
          ),
      
          //send button
          IconButton(
              onPressed: sendMessage,
              icon: const Icon(
                Icons.send,
                size: 40,
              )),
        ],
      ),
    );
  }
}
