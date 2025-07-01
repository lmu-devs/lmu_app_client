import 'package:flutter/material.dart';

class LectureDetailPage extends StatelessWidget {
  final String title;

  const LectureDetailPage({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        leading: BackButton(),
        actions: [
          IconButton(
            icon: Icon(Icons.star_border),
            onPressed: () {
              // Handle favorite
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            Text(
              title,
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 8),
            Text(
              'Master • 6 SWS • Englisch',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {},
              child: const Text('Plane diesen Kurs'),
            ),
            const SizedBox(height: 24),
            const Text('Grunddaten', style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            _infoRow('Lehrveranstaltung', '2x VL, 1x Übung'),
            _infoRow('Zeit', 'Mo 16:15 – 17:45'),
            _infoRow('Dauer', '12.05.2025 – 23.07.2025'),
            _infoRow('Adresse', 'Luisenstr. 37 (C)'),
            _infoRow('Raum', 'C 006'),
            const SizedBox(height: 24),
            const Text('Weitere Informationen...'),
          ],
        ),
      ),
    );
  }

  Widget _infoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('$label: ', style: const TextStyle(fontWeight: FontWeight.bold)),
          Expanded(child: Text(value)),
        ],
      ),
    );
  }
}
