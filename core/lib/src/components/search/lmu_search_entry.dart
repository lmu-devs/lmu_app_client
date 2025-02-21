import 'package:flutter/material.dart';

class LmuSearchEntry {
  const LmuSearchEntry({
    required this.title,
    this.subtitle,
    required this.onTap,
    this.icon,
    this.iconColor,
    this.additionalTags,
  });

  final String title;
  final String? subtitle;
  final IconData? icon;
  final Color? iconColor;
  final void Function() onTap;
  final List<String>? additionalTags;
}
