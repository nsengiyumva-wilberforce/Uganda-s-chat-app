import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class AddPostPage extends StatefulWidget {
  const AddPostPage({super.key});

  @override
  _AddPostPageState createState() => _AddPostPageState();
}

class _AddPostPageState extends State<AddPostPage> {
  final _formKey = GlobalKey<FormState>();
  final _contentController = TextEditingController();
  File? _selectedImage;
  File? _selectedVideo;

  Future<void> _addPost() async {
    if (_formKey.currentState!.validate()) {
      await FirebaseFirestore.instance.collection('posts').add({
        'content': _contentController.text,
        'image': _selectedImage != null ? _selectedImage!.path : null,
        'video': _selectedVideo != null ? _selectedVideo!.path : null,
        'timestamp': FieldValue.serverTimestamp(),
      });
      Navigator.pop(context);
    }
  }

  Future<void> _pickMedia(bool isImage) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
      preferredCameraDevice: isImage ? CameraDevice.rear : CameraDevice.front,
    );

    if (pickedFile != null) {
      setState(() {
        if (isImage) {
          _selectedImage = File(pickedFile.path);
        } else {
          _selectedVideo = File(pickedFile.path);
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Post'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(  // Wrap the whole body in a SingleChildScrollView
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Text area
                TextFormField(
                  controller: _contentController,
                  decoration: const InputDecoration(
                    hintText: "What's on your mind?",
                    border: OutlineInputBorder(),
                    contentPadding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
                  ),
                  maxLines: 10, // Set to 20 lines
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please write something to post';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                // Icons for image and video upload
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      onPressed: () => _pickMedia(true), // Pick image
                      icon: const Icon(Icons.image, size: 30),
                      color: Colors.blue,
                    ),
                    const SizedBox(width: 20),
                    IconButton(
                      onPressed: () => _pickMedia(false), // Pick video
                      icon: const Icon(Icons.videocam, size: 30),
                      color: Colors.blue,
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                // Submit button
                ElevatedButton(
                  onPressed: _addPost,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  child: const Text(
                    'Post',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
