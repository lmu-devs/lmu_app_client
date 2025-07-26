import 'package:core/components.dart';
import 'package:flutter/material.dart';

class PeopleSearchPage extends StatefulWidget {
  const PeopleSearchPage({super.key, required this.facultyId});

  final int facultyId;

  @override
  State<PeopleSearchPage> createState() => _PeopleSearchPageState();
}

class _PeopleSearchPageState extends State<PeopleSearchPage> {
  @override
  Widget build(BuildContext context) {
    return LmuScaffold(
      appBar: LmuAppBarData(
        largeTitle: 'Suche',
        leadingAction: LeadingAction.back,
      ),
      body: Center(
        child: LmuText.body('Suchergebnisse erscheinen hier...'),
      ),
    );
  }
}
