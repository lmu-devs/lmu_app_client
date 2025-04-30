import 'package:core/components.dart';
import 'package:core/constants.dart';
import 'package:flutter/material.dart';

class TimelineLoadingView extends StatelessWidget {
  const TimelineLoadingView({super.key});

  final _count = 2;

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: LmuSizes.size_16),
          child: Column(
            children: [
              ...List.generate(
                _count,
                (index) => Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: LmuSizes.size_16),
                    LmuTextLoading.h3(charNo: 12),
                    LmuTextLoading.body(charNo: 10),
                    const SizedBox(height: LmuSizes.size_8),
                    LmuContentTile(
                      contentList: List.generate(
                        _count,
                        (index) => LmuListItemLoading(
                          leadingArea: LmuText.body("01."),
                          titleLength: 2,
                          subtitleLength: 3,
                        ),
                      ),
                    ),
                    const SizedBox(height: LmuSizes.size_16),
                    LmuContentTile(
                      contentList: List.generate(
                        _count,
                        (index) => LmuListItemLoading(
                          leadingArea: LmuText.body("01."),
                          titleLength: 2,
                          subtitleLength: 3,
                        ),
                      ),
                    ),
                    const SizedBox(height: LmuSizes.size_16),
                    LmuContentTile(
                      content: LmuListItemLoading(
                        leadingArea: LmuText.body("01."),
                        titleLength: 2,
                        subtitleLength: 3,
                      ),
                    ),
                    if (_count != index - 1) const SizedBox(height: LmuSizes.size_32),
                  ],
                ),
              ),
              const SizedBox(height: LmuSizes.size_96)
            ],
          ),
        ),
      ),
    );
  }
}
