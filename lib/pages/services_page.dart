// services_page.dart
import 'package:flutter/material.dart';

class ServicesPage extends StatelessWidget {
  final Map<String, List<String>> categorizedServices = {
    'General Services': [
      'Food Delivery',
      'Ride Hailing',
      'Grocery Shopping',
      'House Cleaning',
      'Laundry Services',
      'Pet Care',
      'Beauty Services',
      'Health and Wellness',
      'Home Repairs',
      'Tutoring Services',
    ],
    'Financial Services': [
      'Mobile Money',
      'Banking Services',
      'Loans',
      'Insurance',
      'Investment Opportunities',
      'Savings Accounts',
      'Financial Advisory',
    ],
    'Other Services': [
      'Event Planning',
      'Travel and Tourism',
      'Real Estate',
      'Legal Services',
      'Freelance Work',
    ],
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Services in Uganda'),
      ),
      body: ListView(
        children: categorizedServices.entries.map((entry) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  entry.key,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              ...entry.value.map((service) {
                return ListTile(
                  title: Text(service),
                  onTap: () {
                    // Handle service tap
                  },
                );
              }).toList(),
            ],
          );
        }).toList(),
      ),
    );
  }
}