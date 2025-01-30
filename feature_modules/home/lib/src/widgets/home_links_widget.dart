import 'package:core/components.dart';
import 'package:core/constants.dart';
import 'package:core/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lucide/flutter_lucide.dart';
import '../repository/api/models/link_model.dart';

class HomeLinksView extends StatelessWidget {
  const HomeLinksView({
    super.key,
    required this.links,
  });

  final List<LinkModel> links;

  IconData getIcon(String title) {
    return switch (title) {
      'Moodle' => LucideIcons.book,
      'LMU-Portal' => LucideIcons.house,
      'LMU-Mail' => LucideIcons.mail,
      'Beitragskonto' => LucideIcons.coins,
      'Raumfinder' => LucideIcons.map_pin,
      'Immatrikulation' => LucideIcons.file_check,
      'Benutzerkonto' => LucideIcons.user,
      _ => LucideIcons.link,
    };
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: LmuSizes.size_16),
      child: Wrap(
        direction: Axis.horizontal,
        spacing: LmuSizes.size_8,
        children: links.map((link) {
          return LmuButton(
            title: link.title,
            leadingIcon: getIcon(link.title),
            emphasis: ButtonEmphasis.secondary,
            onTap: () => LmuUrlLauncher.launchWebsite(
              url: link.url,
              context: context,
              mode: LmuUrlLauncherMode.externalApplication,
            ),
          );
        }).toList(),
      ),
    );
  }
}
