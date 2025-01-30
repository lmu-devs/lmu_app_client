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
      width: 222,
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
              child: SizedBox(
                height: 120,
                width: 222,
                child: ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(LmuRadiusSizes.medium)),
                  child: FutureBuilder(
                    future: precacheImage(
                      NetworkImage(trailer.thumbnail.url),
                      context,
                    ),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.done) {
                        return Image.network(
                          trailer.thumbnail.url,
                          height: 120,
                          width: 222,
                          fit: BoxFit.cover,
                          semanticLabel: trailer.thumbnail.name,
                        );
                      } else {
                        return LmuSkeleton(
                          child: Container(
                            height: 120,
                            width: 222,
                            color: Colors.white,
                          ),
                        );
                      }
                    },
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
