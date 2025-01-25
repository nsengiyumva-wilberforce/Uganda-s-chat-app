import 'package:chat_app/pages/messages_page.dart';
import 'package:chat_app/pages/notifications_page.dart';
import 'package:chat_app/pages/posts_page.dart';
import 'package:chat_app/pages/settings_page.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    const PostsPage(),
    const NotificationsPage(),
    const SettingsPage(),
  ];

  final TextEditingController _searchController = TextEditingController();

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _goTochatBox() {
    //final authService = Provider.of<AuthService>(context, listen: false);
    //authService.signOut();

    //navigate to the chat page
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const MessagesPage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: CircleAvatar(
          backgroundImage: NetworkImage('https://your-profile-pic-url.com'), // Replace with actual URL or asset
        ),
        title: _selectedIndex == 0 // Check if on PostsPage
            ? Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: TextField(
                  controller: _searchController,
                  decoration: InputDecoration(
                    hintText: 'Search...',
                    border: InputBorder.none,
                    suffixIcon: Icon(Icons.search),
                  ),
                ),
              )
            : Text(
                _selectedIndex == 1
                    ? 'Notifications'
                    : _selectedIndex == 2
                        ? 'Settings'
                        : 'Home',
              ),
        actions: [
          if (_selectedIndex == 0) // Only show the chat button on PostsPage
            IconButton(
              onPressed: _goTochatBox,
              icon: const Icon(Icons.message),
            ),
        ],
      ),
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications),
            label: 'Notifications',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
      ),
    );
  }
}
