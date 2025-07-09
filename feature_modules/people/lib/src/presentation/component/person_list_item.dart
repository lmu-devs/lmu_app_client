import 'package:core/components.dart';
import 'package:flutter/material.dart';

import '../../domain/model/people.dart';

class PersonListItem extends StatelessWidget {
  const PersonListItem({
    super.key,
    required this.person,
    required this.onTap,
  });

  final People person;
  final VoidCallback onTap;

  String _getLastNameInitial(String surname) {
    return surname.isNotEmpty ? surname[0].toUpperCase() : '#';
  }

  @override
  Widget build(BuildContext context) {
    return LmuListItem.action(
      title: '${person.name} ${person.surname}',
      subtitle: person.title,
      actionType: LmuListItemAction.chevron,
      onTap: onTap,
    );
  }
}
