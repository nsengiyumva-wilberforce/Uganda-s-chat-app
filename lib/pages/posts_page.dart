import 'package:flutter/material.dart';
import 'add_post_page.dart';

class PostsPage extends StatefulWidget {
  const PostsPage({super.key});

  @override
  _PostsPageState createState() => _PostsPageState();
}

class _PostsPageState extends State<PostsPage> {
  final List<Map<String, dynamic>> placeholderPosts = [
    {
      'title': 'Post 1',
      'content': 'This is the content of post 1. It is short.',
      'image': 'https://picsum.photos/200/300',
      'userName': 'John Doe',
      'profilePic': 'https://picsum.photos/50',
      'likes': 0,
      'comments': <String>[],
      'isExpanded': false,
    },
    {
      'title': 'Post 2',
      'content': 'This is the content of post 2. It is also short.',
      'image': 'https://picsum.photos/200/300',
      'userName': 'Jane Smith',
      'profilePic': 'https://picsum.photos/50',
      'likes': 0,
      'comments': <String>[],
      'isExpanded': false,
    },
    {
      'title': 'Long Post',
      'content': 'This is a very long post content that should definitely exceed the maximum '
          'number of lines allowed in the preview. Lorem ipsum dolor sit amet, consectetur '
          'adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. '
          'Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip '
          'ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit '
          'esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non '
          'proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',
      'image': 'https://picsum.photos/200/300',
      'userName': 'Alice Johnson',
      'profilePic': 'https://picsum.photos/50',
      'likes': 0,
      'comments': <String>[],
      'isExpanded': false,
    },
  ];

  @override
  Widget build(BuildContext context) {
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
                    // User profile and name
                    Padding(
                      padding: const EdgeInsets.all(12),
                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: 20,
                            backgroundImage: NetworkImage(post['profilePic']!),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Text(
                              post['userName']!,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ),
                    // Post title and content
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
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 8),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                post['content']!,
                                style: const TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey,
                                ),
                                maxLines: post['isExpanded'] ? null : 3,
                                overflow: post['isExpanded']
                                    ? null
                                    : TextOverflow.ellipsis,
                              ),
                              if (_needsReadMore(post['content']))
                                InkWell(
                                  onTap: () {
                                    setState(() {
                                      post['isExpanded'] = !post['isExpanded'];
                                    });
                                  },
                                  child: Text(
                                    post['isExpanded']
                                        ? 'Show less'
                                        : 'Read more',
                                    style: const TextStyle(
                                      color: Colors.blue,
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    // Post image
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
                          child: Image.network(
                            post['image']!,
                            width: double.infinity,
                            height: MediaQuery.of(context).size.height * 0.3,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    // Action buttons
                    Padding(
                      padding: const EdgeInsets.all(12),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          _buildCompactPostActionButton(
                            icon: Icons.thumb_up,
                            color: Colors.blue,
                            label: 'Appreciate (${post['likes']})',
                            onPressed: () {
                              setState(() {
                                post['likes']++;
                              });
                            },
                          ),
                          _buildCompactPostActionButton(
                            icon: Icons.comment,
                            color: Colors.green,
                            label: 'Discuss (${post['comments'].length})',
                            onPressed: () {
                              _showCommentsDialog(context, post);
                            },
                          ),
                          _buildCompactPostActionButton(
                            icon: Icons.share,
                            color: Colors.orange,
                            label: 'Spread',
                            onPressed: () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Share this post'),
                                ),
                              );
                            },
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

  // Check if content needs a "Read more" button
  bool _needsReadMore(String content) {
    const maxLines = 3;
    final textPainter = TextPainter(
      text: TextSpan(
        text: content,
        style: const TextStyle(fontSize: 14, color: Colors.grey),
      ),
      maxLines: maxLines,
      textDirection: TextDirection.ltr,
    )..layout(maxWidth: 300); // Adjust maxWidth based on your layout
    return textPainter.didExceedMaxLines;
  }

  // Compact button widget
  Widget _buildCompactPostActionButton({
    required IconData icon,
    required Color color,
    required String label,
    required VoidCallback onPressed,
  }) {
    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: color, size: 20),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  // Comments dialog
  void _showCommentsDialog(BuildContext context, Map<String, dynamic> post) {
    final TextEditingController _commentController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Comments'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: post['comments'].length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(post['comments'][index]),
                    );
                  },
                ),
              ),
              TextField(
                controller: _commentController,
                decoration: const InputDecoration(
                  hintText: 'Add a comment...',
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                if (_commentController.text.isNotEmpty) {
                  setState(() {
                    post['comments'].add(_commentController.text);
                  });
                  _commentController.clear();
                }
              },
              child: const Text('Add Comment'),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }
}