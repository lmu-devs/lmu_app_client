import 'package:core/components.dart';
import 'package:core/localizations.dart';
import 'package:core/utils.dart';
import 'package:flutter/material.dart';

import '../../domain/model/people.dart';

class PeopleCard extends StatelessWidget {
  const PeopleCard({super.key, required this.people});

  final People people;

  void _handleTap(BuildContext context) => LmuUrlLauncher.launchWebsite(
        context: context,
        url: people.profileUrl,
        mode: LmuUrlLauncherMode.externalApplication,
      );

  void _handleLongPress(BuildContext context) => CopyToClipboardUtil.copyToClipboard(
        context: context,
        copiedText: people.profileUrl,
        message: context.locals.home.linkCopiedToClipboard,
      );

  String get _displayName {
    final firstName = people.basicInfo.firstName;
    final lastName = people.basicInfo.lastName;
    final academicDegree = people.basicInfo.academicDegree;
    String name = firstName;
    if (lastName.isNotEmpty) {
      name += ' $lastName';
    }
    if (academicDegree != null && academicDegree.isNotEmpty) {
      name += ' $academicDegree';
    }
    return name;
  }

  @override
  Widget build(BuildContext context) {
    return LmuCard(
      title: _displayName,
      onTap: () => _handleTap(context),
      onLongPress: () => _handleLongPress(context),
    );
  }
}
