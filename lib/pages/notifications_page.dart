import 'package:flutter/material.dart';

class NotificationsPage extends StatelessWidget {
  const NotificationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100], // Light background for better readability
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: 5, // Example notification count
          itemBuilder: (context, index) {
            return Card(
              margin: const EdgeInsets.symmetric(vertical: 8),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 4,
              child: ListTile(
                contentPadding: const EdgeInsets.all(16),
                leading: Icon(
                  Icons.notifications,
                  color: Colors.blueAccent,
                  size: 30,
                ),
                title: Text(
                  'Notification ${index + 1}',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                subtitle: Text(
                  'This is an example of a notification. Tap to read more.',
                  style: TextStyle(
                    color: Colors.grey[600],
                  ),
                ),
                trailing: Icon(
                  Icons.chevron_right,
                  color: Colors.blueAccent,
                ),
                onTap: () {
                  // Action when tapped
                  // You can navigate to a detailed page or show more info
                  print('Notification ${index + 1} tapped');
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
