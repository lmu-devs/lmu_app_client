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

  @override
  Widget build(BuildContext context) {
    return LmuListItem.action(
      title: person.name,
      subtitle: person.title,
      actionType: LmuListItemAction.chevron,
      onTap: onTap,
    );
  }
} 