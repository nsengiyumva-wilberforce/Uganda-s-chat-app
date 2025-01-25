import 'package:flutter/material.dart';
import 'add_post_page.dart'; // Import the AddPostPage

class PostsPage extends StatelessWidget {
  const PostsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> placeholderPosts = [
      {
        'title': 'Post 1',
        'content': 'This is the content of post 1',
        'image': 'https://picsum.photos/200/300',
        'userName': 'John Doe',  // User's full name
        'profilePic': 'https://picsum.photos/50',  // User's profile picture
      },
      {
        'title': 'Post 2',
        'content': 'This is the content of post 2',
        'image': 'https://picsum.photos/200/300',
        'userName': 'Jane Smith',
        'profilePic': 'https://picsum.photos/50',
      },
      {
        'title': 'Post 3',
        'content': 'This is the content of post 3',
        'image': 'https://picsum.photos/200/300',
        'userName': 'Mark Johnson',
        'profilePic': 'https://picsum.photos/50',
      },
    ];

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: ListView.builder(
            itemCount: placeholderPosts.length,
            itemBuilder: (context, index) {
              final post = placeholderPosts[index];
              return Card(
                margin: const EdgeInsets.only(bottom: 20),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 4,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(12),
                      child: Row(
                        children: [
                          // Displaying the user's profile picture
                          CircleAvatar(
                            radius: 20,
                            backgroundImage: NetworkImage(post['profilePic']!),
                          ),
                          const SizedBox(width: 10),
                          // Displaying the user's full name
                          Text(
                            post['userName']!,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            post['title']!,
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            post['content']!,
                            style: const TextStyle(
                              fontSize: 14,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ),
                    if (post['image'] != null)
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 12),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.3),
                              spreadRadius: 2,
                              blurRadius: 5,
                              offset: const Offset(0, 3),
                            ),
                          ],
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.network(post['image']!),
                        ),
                      ),
                    Padding(
                      padding: const EdgeInsets.all(12),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _buildPostActionButton(
                            icon: Icons.thumb_up,
                            color: Colors.blue,
                            label: 'Appreciate',
                            onPressed: () {},
                          ),
                          _buildPostActionButton(
                            icon: Icons.comment,
                            color: Colors.green,
                            label: 'Discuss',
                            onPressed: () {},
                          ),
                          _buildPostActionButton(
                            icon: Icons.share,
                            color: Colors.orange,
                            label: 'Spread',
                            onPressed: () {},
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddPostPage()),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildPostActionButton({
    required IconData icon,
    required Color color,
    required String label,
    required VoidCallback onPressed,
  }) {
    return TextButton.icon(
      onPressed: onPressed,
      icon: Icon(icon, color: color),
      label: Text(label),
    );
  }
}
