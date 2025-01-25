import 'package:chat_app/model/message.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChatService extends ChangeNotifier{
  //get instance of auth and firestore
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  //send message
  Future<void> sendMessage(String receiverId, String message) async{
    //get current user info
    final String currentUserId = _auth.currentUser!.uid;
    final String currentUserEmail = _auth.currentUser!.email!;
    final Timestamp timestamp = Timestamp.now();

    //create new message
    final newMessage = Message(
      senderId: currentUserId,
      senderEmail: currentUserEmail,
      receiverId: receiverId,
      message: message,
      timestamp: timestamp,
    );
    //construct a chat room id from the current user id and receiver id (sorted to ensure uniqueness)
    List<String> ids = [currentUserId, receiverId];
    ids.sort();
    String chatRoomId = ids.join('_'); //combine the ids into a single string to use as chat room id

    //add the new message to the database
    await _firestore.collection('chatrooms').doc(chatRoomId).collection('messages').add(newMessage.toMap());
  }
  //get messages
  Stream<QuerySnapshot> getMessages(String userId, String otherUserId){
    //construct a chat room id from the current user id and receiver id (sorted to ensure uniqueness)
    List<String> ids = [userId, otherUserId];
    ids.sort();
    String chatRoomId = ids.join('_'); //combine the ids into a single string to use as chat room id

    //get messages from the database
    return _firestore.collection('chatrooms').doc(chatRoomId).collection('messages').orderBy('timestamp', descending: false).snapshots();
  }
}