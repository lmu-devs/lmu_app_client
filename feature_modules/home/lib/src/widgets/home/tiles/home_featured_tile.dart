import 'package:core/components.dart';
import 'package:core/utils.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

import '../../../repository/api/models/home/home_featured.dart';
import '../../../service/home_preferences_service.dart';

class HomeFeaturedTile extends StatelessWidget {
  const HomeFeaturedTile({super.key, required this.featured});

  final HomeFeatured featured;

  @override
  Widget build(BuildContext context) {
    return StaggeredGridTile.count(
      crossAxisCellCount: 2,
      mainAxisCellCount: 1,
      child: LmuFeatureTile(
        title: featured.title,
        subtitle: featured.description,
        onClose: () => GetIt.I.get<HomePreferencesService>().setFeaturedClosed(featured.id),
        onTap: () {
          final urlType = featured.urlType;
          final url = featured.url;
          if (urlType == null || url == null) return;

          switch (urlType) {
            case HomeUrlType.interal:
              context.go(url);
              break;
            case HomeUrlType.external:
              LmuUrlLauncher.launchWebsite(context: context, url: url);
              break;
          }
        },
      ),
    );
  }
}
