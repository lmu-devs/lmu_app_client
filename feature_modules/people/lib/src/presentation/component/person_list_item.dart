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
    final fullName = person.academicDegree != null && person.academicDegree!.isNotEmpty
        ? '${person.academicDegree} ${person.name} ${person.surname}'
        : '${person.name} ${person.surname}';

    return LmuListItem.action(
      title: fullName,
      subtitle: person.title,
      actionType: LmuListItemAction.chevron,
      onTap: onTap,
    );
  }
}
