import 'package:flutter/material.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            // Account Settings Section
            _buildSettingsSection(
              title: 'Account Settings',
              options: [
                'Change Password',
                'Update Email',
                'Log Out',
              ],
              icons: [
                Icons.lock,
                Icons.email,
                Icons.exit_to_app,
              ],
            ),
            const SizedBox(height: 20),
            // Notifications Section
            _buildSettingsSection(
              title: 'Notifications',
              options: [
                'Push Notifications',
                'Email Notifications',
                'SMS Notifications',
              ],
              icons: [
                Icons.notifications,
                Icons.email,
                Icons.message,
              ],
            ),
            const SizedBox(height: 20),
            // Privacy Settings Section
            _buildSettingsSection(
              title: 'Privacy Settings',
              options: [
                'Privacy Policy',
                'Terms of Service',
                'Data Sharing Preferences',
              ],
              icons: [
                Icons.security,
                Icons.file_copy,
                Icons.share,
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSettingsSection({
    required String title,
    required List<String> options,
    required List<IconData> icons,
  }) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      elevation: 4,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: Colors.blueAccent,
              ),
            ),
          ),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: options.length,
            itemBuilder: (context, index) {
              return ListTile(
                contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                leading: Icon(
                  icons[index],
                  color: Colors.blueAccent,
                  size: 28,
                ),
                title: Text(
                  options[index],
                  style: const TextStyle(fontSize: 16),
                ),
                onTap: () {
                  // Handle tap (can navigate to detailed settings page or show a dialog)
                  print('${options[index]} tapped');
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
