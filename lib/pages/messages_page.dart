import 'package:chat_app/auth_service.dart';
import 'package:chat_app/pages/chat_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MessagesPage extends StatefulWidget {
  const MessagesPage({super.key});

  @override
  State<MessagesPage> createState() => _MessagesPageState();
}

class _MessagesPageState extends State<MessagesPage> {
  // Instance of FirebaseAuth
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Sign out function
  void signOut() {
    final authService = Provider.of<AuthService>(context, listen: false);
    authService.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //back button
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text('Messages', style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.blueAccent
      ),
      body: _buildUserList(),
    );
  }

  // Build a list of users except for the current logged-in user
  Widget _buildUserList() {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('users').snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(child: Text('An error occurred: ${snapshot.error}'));
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        return ListView(
          padding: const EdgeInsets.all(8.0),
          children: snapshot.data!.docs
              .map<Widget>((doc) => _buildUserListItem(doc))
              .toList(),
        );
      },
    );
  }

  // Build individual user list item
  Widget _buildUserListItem(DocumentSnapshot document) {
    Map<String, dynamic> data = document.data()! as Map<String, dynamic>;

    // Display all users except current user
    if (_auth.currentUser!.email != data['email']) {
      return Card(
        margin: const EdgeInsets.symmetric(vertical: 8.0),
        elevation: 5.0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
        child: ListTile(
          contentPadding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
          title: Text(
            data['email'],
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
          subtitle: const Text('Tap to chat'),
          leading: CircleAvatar(
            radius: 25.0,
            backgroundColor: Colors.blueAccent,
            child: Icon(Icons.person, color: Colors.white),
          ),
          trailing: Icon(Icons.message, color: Colors.blueAccent),
          onTap: () {
            // Navigate to ChatPage with the clicked user's UID
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ChatPage(
                  receiverUserEmail: data['email'],
                  receiverUserID: data['uid'],
                ),
              ),
            );
          },
        ),
      );
    } else {
      return Container();
    }
  }
}
