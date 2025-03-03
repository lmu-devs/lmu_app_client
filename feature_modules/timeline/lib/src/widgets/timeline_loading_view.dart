import 'package:core/components.dart';
import 'package:core/constants.dart';
import 'package:flutter/widgets.dart';

class TimelineLoadingView extends StatelessWidget {
  const TimelineLoadingView({super.key});

  final _count = 3;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: LmuSizes.size_16),
        child: Column(
          children: [
            ...List.generate(
              _count,
              (index) => Column(
                children: [
                  const SizedBox(height: LmuSizes.size_16),
                  const LmuTileHeadlineLoading(),
                  LmuContentTile(
                    content: List.generate(
                      _count,
                      (index) => LmuListItemLoading(
                        titleLength: 2,
                        subtitleLength: 3,
                        hasDivier: index != _count - 1,
                      ),
                    ),
                  ),
                  const SizedBox(height: LmuSizes.size_16),
                  const LmuContentTile(
                    content: [LmuListItemLoading(titleLength: 2, subtitleLength: 3)],
                  ),
                ],
              ),
            ),
            const SizedBox(height: LmuSizes.size_96)
          ],
        ),
      ),
    );
  }
}
