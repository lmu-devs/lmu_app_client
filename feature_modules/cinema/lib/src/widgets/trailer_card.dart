import 'package:core/components.dart';
import 'package:core/constants.dart';
import 'package:core/themes.dart';
import 'package:core/utils.dart';
import 'package:flutter/material.dart';

import '../repository/api/api.dart';

class TrailerCard extends StatelessWidget {
  const TrailerCard({
    Key? key,
    required this.trailer,
  }) : super(key: key);

  final TrailerModel trailer;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 220,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () => LmuUrlLauncher.launchWebsite(
              url: trailer.url,
              context: context,
              mode: LmuUrlLauncherMode.externalApplication,
            ),
            child: Container(
              margin: const EdgeInsets.only(right: LmuSizes.size_8),
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(
                  Radius.circular(LmuRadiusSizes.medium),
                ),
              ),
              child: AspectRatio(
                aspectRatio: 16 / 9,
                child: Semantics(
                  label: trailer.thumbnail.name,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(LmuRadiusSizes.medium)),
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: LmuCachedNetworkImageProvider(trailer.thumbnail.url),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: LmuSizes.size_8),
          LmuText.bodySmall(
            trailer.title,
            color: context.colors.neutralColors.textColors.strongColors.base,
            maxLines: 2,
          ),
          const SizedBox(height: LmuSizes.size_2),
          LmuText.bodySmall(
            trailer.site,
            color: context.colors.neutralColors.textColors.mediumColors.base,
          ),
        ],
      ),
    );
  }
}
