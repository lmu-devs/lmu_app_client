import 'package:flutter/material.dart';

class PeopleDetailsPage extends StatelessWidget {
  final String id;
  final String title;
  final String description;

  const PeopleDetailsPage({
    super.key,
    required this.id,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Text(description),
      ),
    );
  }
}
