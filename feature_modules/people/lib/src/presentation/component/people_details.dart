import 'package:flutter/material.dart';

class PeopleDetails extends StatelessWidget {
  final String id;
  final String title;
  final String description;

  const PeopleDetails({
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('ID: $id', style: Theme.of(context).textTheme.bodySmall),
            const SizedBox(height: 8),
            Text(description, style: Theme.of(context).textTheme.bodyMedium),
          ],
        ),
      ),
    );
  }
}
