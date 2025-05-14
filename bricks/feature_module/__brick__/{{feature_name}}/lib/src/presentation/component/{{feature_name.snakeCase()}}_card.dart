import 'package:core/components.dart';
import 'package:flutter/material.dart';

class {{feature_name.pascalCase()}}Card extends StatelessWidget {
  const {{feature_name.pascalCase()}}Card({super.key, 
    required this.id,
    required this.title,
    required this.description,
    required this.onTap,
  });

  final String id;
  final String title;
  final String description;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return LmuCard(
      title: title,
      subtitle: description,
      leadingIcon: const LmuInListBlurEmoji(emoji: "😀"),
      onTap: onTap,
    );
  }
}
