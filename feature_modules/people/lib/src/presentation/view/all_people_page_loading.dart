import 'package:core/components.dart';
import 'package:core/constants.dart';
import 'package:flutter/widgets.dart';
import 'package:people/src/presentation/component/people_suggestion_tile.dart';

class AllPeoplePageLoading extends StatelessWidget {
  const AllPeoplePageLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Generate 3 letter sections with 3-5 items each
        for (var i = 0; i < 3; i++) ...[
          LmuTileHeadlineLoading(titleLength: 1),
          LmuContentTile(
            contentList: List.generate(
              i + 3, // 3, 4, 5 items per section
              (index) => LmuListItemLoading(
                titleLength: 3,
                subtitleLength: 2,
                hasDivier: true,
                action: LmuListItemAction.chevron,
              ),
            ),
          ),
          const SizedBox(height: LmuSizes.size_16),
        ],
        const PeopleSuggestionTile(),
      ],
    );
  }
}
