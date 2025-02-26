import 'package:core/components.dart';
import 'package:core/constants.dart';
import 'package:core/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import '../../bloc/links/links.dart';
import '../../repository/api/models/links/link_model.dart';
import '../../service/home_preferences_service.dart';

class FavoriteLinkRow extends StatelessWidget {
  const FavoriteLinkRow({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LinksCubit, LinksState>(
      bloc: GetIt.I.get<LinksCubit>(),
      builder: (context, state) {
        if (state is LinksLoadSuccess) {
          final List<LinkModel> fetchedLinks = state.links;
          return ValueListenableBuilder<List<String>>(
            valueListenable: GetIt.I<HomePreferencesService>().likedLinksNotifier,
            builder: (context, likedLinks, child) {
              return likedLinks.isNotEmpty
                  ? Padding(
                      padding: const EdgeInsets.only(top: LmuSizes.size_4, bottom: LmuSizes.size_8),
                      child: LmuButtonRow(
                        buttons: fetchedLinks.where((link) => likedLinks.contains(link.title)).map((link) {
                          return LmuButton(
                            emphasis: ButtonEmphasis.secondary,
                            title: link.title,
                            leadingWidget: LmuCachedNetworkImage(
                              imageUrl: link.faviconUrl,
                              height: LmuIconSizes.small,
                              width: LmuIconSizes.small,
                            ),
                            onTap: () => LmuUrlLauncher.launchWebsite(
                              url: link.url,
                              context: context,
                              mode: LmuUrlLauncherMode.externalApplication,
                            ),
                          );
                        }).toList(),
                      ),
                    )
                  : const SizedBox.shrink();
            },
          );
        }

        return const SizedBox.shrink();
      },
    );
  }
}
